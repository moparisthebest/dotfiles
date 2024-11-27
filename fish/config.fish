if status is-interactive
    # Commands to run in interactive sessions can go here
    # bash -ic 'source ~/.bashrc; env' | grep -Ev '(LS_COLORS|PWD|SHLVL|_)=' | sed -e 's/^/set -gx /' | tr '=' ' ' | grep -i editor
    # | source; or true
    bash --norc --noprofile -ilc 'source ~/.bashrc; env; true' | grep -Ev '(LS_COLORS|PWD|SHLVL|_)=' | sed -re "s/([^=]+)=/\1 '/" -e 's/^/set -gx /' -e "s/\$/'/" -e 's/unix:path /unix:path=/' | source; or true
end

#echo wat
