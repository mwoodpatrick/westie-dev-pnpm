#!/usr/bin/env bash
#

function multiple_dirname() {
    local path=$1
    local number_of_levels=$2

    for i in $(seq 1 $number_of_levels);
    do
        path=`dirname $path`
    done

    echo $path;
}

mypath=`realpath $0`
APP_ROOT=`multiple_dirname $mypath 3`

docker exec -it --user vscode --env-file $APP_ROOT/.env westie-dev bash
