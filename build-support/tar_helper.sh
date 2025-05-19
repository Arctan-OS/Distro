# Download the given TAR if needed
if [ ! -e $ARC_TAR ]; then
        echo "tar_helper: Downloading from $ARC_MIRROR into $ARC_TAR"
        curl -o $ARC_TAR -L $ARC_MIRROR
fi

# If the TAR is present and it has not yet been extracted
if [ ! -d $ARC_SOURCE_DIR ] && [ -e $ARC_TAR ]; then
        # Extract it
        tar -xf $ARC_TAR
        # Move it into *-src
        mv $ARC_NAME $ARC_SOURCE_DIR
        echo "tar_helper: Extracted $ARC_TAR -> $ARC_SOURCE_DIR"
        # Apply necessary patch work
        for f in $(find $(pwd) -maxdepth 1 -type f -name "*.patch"); do
                echo "tar_helper: Applying patch $f to $ARC_SOURCE_DIR"
                cd $ARC_NAME-src && patch -p1 < $f
        done
fi