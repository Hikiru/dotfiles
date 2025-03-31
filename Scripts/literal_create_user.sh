#!/bin/bash

# Function to create user with password and sudo privileges
create_sudo_user() {
    # Get username
    read -p "Enter username: " username

    # Validate username (basic check)
    if [[ ! "$username" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
        echo "Error: Invalid username format"
        exit 1
    fi

    # Check if user already exists
    if id "$username" &>/dev/null; then
        echo "Error: User $username already exists"
        exit 1
    fi

    # Get password with confirmation
    while true; do
        read -s -p "Enter password: " password
        echo
        read -s -p "Confirm password: " password_confirm
        echo
        
        if [ "$password" = "$password_confirm" ]; then
            break
        else
            echo "Passwords do not match. Try again."
        fi
    done

    # Create user with home directory and set shell to bash
    useradd -m -s /bin/bash "$username"
    
    # Set password using chpasswd (safe method)
    echo "$username:$password" | chpasswd

    # Add to sudo group (wheel on Arch)
    usermod -aG wheel "$username"

    echo "User $username created successfully with sudo privileges."
}

# Check if script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Try: sudo $0"
    exit 1
fi

# Execute the function
create_sudo_user

# Final check for sudoers configuration
if ! grep -q '^%wheel\s\+ALL=(ALL:ALL)\s\+ALL' /etc/sudoers; then
    echo -e "\nWARNING: The wheel group is not enabled in sudoers!"
    echo "To enable sudo access for the new user, uncomment this line in /etc/sudoers:"
    echo "%wheel ALL=(ALL:ALL) ALL"
fi
