#!/bin/bash

# Git version of ClickHouse
CH_VERSION="${CH_VERSION:-1.1.54385}"

# Git tag marker (stable/testing)
CH_TAG="${CH_TAG:-stable}"
#CH_TAG="${CH_TAG:-testing}"

echo "Clone ClickHouse repo"
git clone "https://github.com/yandex/ClickHouse" "ClickHouse-${CH_VERSION}-${CH_TAG}"

cd "ClickHouse-${CH_VERSION}-${CH_TAG}"

echo "Checkout specific tag v${CH_VERSION}-${CH_TAG}"
git checkout "v${CH_VERSION}-${CH_TAG}"

echo "Update submodules"
git submodule update --init --recursive

cd ..

