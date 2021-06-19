starship init fish | source

fish_add_path /home/sakoh/.local/bin
fish_add_path /home/sakoh/.cargo/bin

if status is-login
    if test -z "$tty" -a "$XDG_VTNR" = 1
        startx
    end
end
