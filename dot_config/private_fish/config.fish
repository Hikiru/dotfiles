if status is-interactive
    # Commands to run in interactive sessions can go here
    alias sync='chezmoi git pull && chezmoi apply'
    alias dbu='distrobox enter --root ubuntu'
    alias musync='rsync --progress --recursive --ignore-existing --checksum --delete ~/Music/ /run/media/hikiru/H2/Music/'
    alias lg='lazygit'
    alias pak='pakku-mc'
    alias pw='packwiz'
    set -g fish_greeting
    starship init fish | source
end

# Created by `pipx` on 2026-05-20 01:12:06
set PATH $PATH /home/hikiru/.local/bin
