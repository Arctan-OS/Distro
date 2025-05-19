# Download the given TAR if needed
if [ ! -e $ARC_TAR ]; then
        curl -o $ARC_TAR $ARC_MIRROR
fi

# If the TAR is present and it has not yet been extracted
if [ ! -d $ARC_SOURCE_DIR ] && [ -e $ARC_TAR ]; then
        # Extract it
        tar -xf $ARC_TAR
        # Move it into *-src
        mv $ARC_NAME $ARC_SOURCE_DIR
        # Apply necessary patch work
        for f in $(find $(pwd) -type f -name "*.patch"); do
                cd $ARC_NAME-src && patch -p1 < $f
        done
fi