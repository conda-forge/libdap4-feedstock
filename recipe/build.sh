#!/bin/bash

# Yes, this is actually meant to be CPPFLAGS (preprocessor flags)
export CPPFLAGS="-I$PREFIX/include $CPPFLAGS"
# Set c++ std away from default of c++17 due to https://www.mail-archive.com/gcc@gcc.gnu.org/msg81929.html
# error text is "error: ISO C++1z does not allow dynamic exception specifications"
export CXXFLAGS="-I$PREFIX/include $CXXFLAGS -std=c++14"

autoreconf --force --install

bash configure --prefix=$PREFIX \
               --with-xml2=$PREFIX \
               --with-curl=${PREFIX} \
               --enable-threads=pth

make -j${CPU_COUNT} ${VERBOSE_AT}
make check
make install
