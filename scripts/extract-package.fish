function extract-package
    set target $argv[1]
    pwd
    mkdir -p $target
    cp README.md $target
    cp LICENSE $target
    cp typst.toml $target
    cp polylux.typ $target
    cp logic.typ $target
    mkdir -p $target/themes
    cp themes/* $target/themes
    mkdir -p $target/utils
    cp utils/* $target/utils
    echo "Done"
end
