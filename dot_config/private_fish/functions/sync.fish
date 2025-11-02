function sync --wraps='chezmoi git pull && chezmoi apply && cd ~/nix-config && git pull && just all' --description 'alias sync=chezmoi git pull && chezmoi apply && cd ~/nix-config && git pull && just all'
    chezmoi git pull && chezmoi apply && cd ~/nix-config && git pull && just all $argv
end
