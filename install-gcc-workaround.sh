#! /bin/sh

set -e
set -u

# fix related to -fcommon on GCC 10 on Linux
if [ "$(uname)" == 'Linux' ]; then
    SH=$(which sh)
    CC=$(which gcc)

    MAJOR_VERSION_TO_PATCH="10"
    MAJOR_VERSION=$($CC -dumpversion | awk -F. '{ print $1 }' )

    if [ $MAJOR_VERSION -ge $MAJOR_VERSION_TO_PATCH ]; then
        echo "#! $SH" >> $cur__bin/gcc
        echo "exec $CC -fcommon '\"\$@\"'" >> $cur__bin/gcc
        chmod +x $cur__bin/gcc
    fi
fi
