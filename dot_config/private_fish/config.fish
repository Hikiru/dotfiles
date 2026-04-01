if status is-interactive
    # Commands to run in interactive sessions can go here
    alias sync='chezmoi git pull && chezmoi apply'
    alias dbu='distrobox enter --root ubuntu'
    alias musync='rsync --progress --recursive --ignore-existing --checksum --delete ~/Music/ /run/media/hikiru/H2/Music/'
    set -g fish_greeting
    starship init fish | source
end
