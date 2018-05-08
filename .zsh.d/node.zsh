### node.js settings

if which -s yarn; then
    path=(
        $(yarn global bin)
        $path
    )
fi
