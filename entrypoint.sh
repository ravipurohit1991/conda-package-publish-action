#!/bin/bash

set -ex
set -o pipefail

go_to_build_dir() {
    if [ ! -z $INPUT_SUBDIR ]; then
        cd $INPUT_SUBDIR
    fi
}

go_to_build_dir_all() {
    if [ ! -z $INPUT_SUBDIRALL ]; then
        cd $INPUT_SUBDIRALL
    fi
}

check_if_meta_yaml_file_exists() {
    if [ ! -f meta.yaml ]; then
        echo "meta.yaml must exist in the directory that is being packaged and published."
        exit 1
    fi
}

build_package(){
    ##conda build --output --check -c conda-forge --output-folder . .
    conda mambabuild -c conda-forge --output-folder . .
    conda convert -p osx-64 linux-64/*.tar.bz2
    conda convert -p win-64 linux-64/*.tar.bz2
}

upload_package(){
    export ANACONDA_API_TOKEN=$INPUT_ANACONDATOKEN
    conda config --set anaconda_upload yes
    anaconda upload --label main linux-64/*.tar.bz2
    anaconda upload --label main osx-64/*.tar.bz2
    anaconda upload --label main win-64/*.tar.bz2
}

build_package_noarch(){
    ##conda build --output --check -c conda-forge --output-folder . .
    conda mambabuild -c conda-forge --output-folder . .
}

upload_package_noarch(){
    export ANACONDA_API_TOKEN=$INPUT_ANACONDATOKEN
    conda config --set anaconda_upload yes
    anaconda upload --label main noarch/*.tar.bz2
}

echo "Building No arch with mamba"
go_to_build_dir
check_if_meta_yaml_file_exists
build_package_noarch
upload_package_noarch
echo "Building linux arch and converting to other architectures"
go_to_build_dir_all
check_if_meta_yaml_file_exists
build_package
upload_package
