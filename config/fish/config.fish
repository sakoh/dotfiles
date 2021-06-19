starship init fish | source

set PATH $PATH /home/sakoh/.local/bin /home/sakoh/.cargo/bin

if status is-login
    if test -z "$tty" -a "$XDG_VTNR" = 1
        startx
    end
end
