function reload-theme -d "Reload theme by running wallust commands and killing programs"
    argparse --name=reload-theme \
        'h/help' \
        'e/extra-programs=*' \
        't/theme=?' \
        'c/colorscheme=?' \
        'r/run=?' \
        's/spawn=?' \
        -- $argv
    or return 1

    # Show help if requested
    if set --query _flag_help
        echo "Usage: reload-theme [OPTIONS]"
        echo ""
        echo "Reload theme by running wallust commands and killing programs"
        echo ""
        echo "Options:"
        echo "  -h, --help              Show this help message"
        echo "  -e, --extra-programs    Additional programs to restart (can be used multiple times)"
        echo "  -t, --theme THEME       Set wallust theme"
        echo "  -c, --colorscheme CS    Set wallust colorscheme"
        echo "  -r, --run COMMAND       Run wallust wallpaper theme gen"
        echo "  -s, --spawn PROGRAM     Program to spawn at end"
        echo ""
        return 0
    end

    # Default programs to restart
    set default_programs zen-beta nautilus easyeffects gnome-software

    set programs $default_programs
    if set --query _flag_extra_programs
        set --append programs $_flag_extra_programs
    end

    set spawn_programs zen
    if set --query _flag_spawn
        set --append spawn_programs $_flag_spawn
    end

    set required_commands wallust niri pkill
    for cmd in $required_commands
        if not command --query $cmd
            echo "Error: Required command '$cmd' not found" >&2
            return 1
        end
    end

    set wallust_success true

    if set --query _flag_theme
        wallust theme $_flag_theme -q
        or set wallust_success false
    end

    if set --query _flag_colorscheme
        wallust cs $_flag_colorscheme -q
        or set wallust_success false
    end

    if set --query _flag_run
        wallust run $_flag_run
        or set wallust_success false
    end

    if test $wallust_success = false
        echo "Warning: Some wallust commands failed, but continuing with program restart..." >&2
    end

    for program in $programs
        pkill $program
    end

    sleep 0.5

    if not niri msg action spawn -- $spawn_program
        echo "Error: Failed to spawn $spawn_program" >&2
        return 1
    end
end
