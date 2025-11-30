if status is-interactive
    # Commands to run in interactive sessions can go here
    alias sync='chezmoi git pull && chezmoi apply && cd ~/nix-config && git pull && just'
    alias dbu='distrobox enter --root ubuntu'
    set -g fish_greeting
    starship init fish | source
end
