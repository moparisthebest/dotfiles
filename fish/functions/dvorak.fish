function dvorak
    set -f qwerty "-=qwertyuiop[]asdfghjkl;zxcvbnm,./_+QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>?'"
    set -f dvorak "[]',.pyfgcrl/=aoeuidhtns;qjkxbmwvz{}\"<>PYFGCRL?+AOEUIDHTNS_:QJKXBMWVZ-"
    tr -- "$qwerty" "$dvorak"
end
