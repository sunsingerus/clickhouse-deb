#!/bin/bash

# tested on 
# Ubuntu 16.04
# Ubuntu 14.04


# Git version of ClickHouse that we package
CH_VERSION="${CH_VERSION:-1.1.54292}"

# Git tag marker (stable/testing)
CH_TAG="${CH_TAG:-stable}"
#CH_TAG="${CH_TAG:-testing}"

# What sources are we going to compile - either download ready release file OR use 'git clone'
#USE_SOURCES_FROM="releasefile"
USE_SOURCES_FROM="git"


# Current work dir
CWD_DIR=$(pwd)


# Where source files would be kept
SOURCES_DIR="build"


##
## Prepare $RPMBUILD_DIR/SOURCES/ClickHouse-$CH_VERSION-$CH_TAG.zip file
##
function prepare_sources()
{
        banner "Ensure SOURCES dir is in place"
        mkdirs 

        echo "Clean sources dir"
        rm -rf "$SOURCES_DIR"/ClickHouse*

        if [ "$USE_SOURCES_FROM" == "releasefile" ]; then
                banner "Downloading ClickHouse source archive v${CH_VERSION}-${CH_TAG}.zip"
                wget --progress=dot:giga "https://github.com/yandex/ClickHouse/archive/v${CH_VERSION}-${CH_TAG}.zip" --output-document="$SOURCES_DIR/ClickHouse-${CH_VERSION}-${CH_TAG}.zip"

        elif [ "$USE_SOURCES_FROM" == "git" ]; then
                echo "Cloning from github v${CH_VERSION}-${CH_TAG} into $SOURCES_DIR/ClickHouse-${CH_VERSION}-${CH_TAG}"

                cd "$SOURCES_DIR"

                # Go older way because older versions of git (CentOS 6.9, for example) do not understand new syntax of branches etc
                # Clone specified branch with all submodules into $SOURCES_DIR/ClickHouse-$CH_VERSION-$CH_TAG folder
                echo "Clone ClickHouse repo"
                git clone "https://github.com/yandex/ClickHouse" "ClickHouse-${CH_VERSION}-${CH_TAG}"

                cd "ClickHouse-${CH_VERSION}-${CH_TAG}"

                echo "Checkout specific tag v${CH_VERSION}-${CH_TAG}"
                git checkout "v${CH_VERSION}-${CH_TAG}"

                echo "Update submodules"
                git submodule update --init --recursive

                cd "$CWD_DIR"

        else
                echo "Unknows sources"
                exit 1
        fi
}

##
##
##
function install_dependencies()
{
	sudo apt install -y devscripts
	sudo apt install -y build-essential
	sudo apt install -y libreadline-dev
	sudo apt install -y clang
	sudo apt install -y debhelper

	sudo apt-get install -y software-properties-common
	sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
	sudo add-apt-repository -y 'deb [arch=amd64,i386,ppc64el] http://mirror.timeweb.ru/mariadb/repo/10.2/ubuntu xenial main'
	sudo apt-get update
	sudo apt install -y libmariadbclient-dev

	sudo apt install -y cmake libicu-dev libltdl-dev libssl-dev unixodbc-dev

	# GCC-7
	#sudo add-apt-repository -y ppa:jonathonf/gcc-7.2
	#sudo apt-get update
	#apt-cache search gcc-7
	#sudo apt install -y gcc-7
	#sudo apt install -y g++-7

	# GCC-6
	sudo add-apt-repository -y ppa:jonathonf/gcc-6.3
	sudo apt-get update
	# apt-cache search gcc-6
	sudo apt install -y gcc-6
	sudo apt install -y g++-6


}

mkdir -p "${SOURCES_DIR}"

prepare_sources

cd "${SOURCES_DIR}/ClickHouse-${CH_VERSION}-${CH_TAG}"
./release

