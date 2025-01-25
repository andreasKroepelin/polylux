if test (git branch --show-current) != release
    echo "You are not on the release branch!"
    return 1
end

set target $argv[1]
pwd
mkdir -p $target
cp README.md $target
cp LICENSE $target
cp typst.toml $target
cp -a src $target
cp -a examples $target
cp -a assets $target
echo Done
