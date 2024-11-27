function mkcd
    test -n "$argv[1]" && mkdir -p "$argv[1]" && cd "$argv[1]"
end
