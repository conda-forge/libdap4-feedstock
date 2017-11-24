#!/bin/bash

if [ $(uname) == Darwin ]; then
    export CC=clang
    export CXX=clang++
    export MACOSX_DEPLOYMENT_TARGET="10.9"
    export CXXFLAGS="-stdlib=libc++ $CXXFLAGS"
    export CXXFLAGS="$CXXFLAGS -stdlib=libc++"
fi


export LDFLAGS="-L$PREFIX/lib $LDFLAGS"
export CPPFLAGS="-I$PREFIX/include $CPPFLAGS"

autoreconf --force --install

bash configure --prefix=$PREFIX \
               --with-xml2=$PREFIX \
               --with-curl=$PREFIX \
               --enable-threads=pth

make
make check
make install
