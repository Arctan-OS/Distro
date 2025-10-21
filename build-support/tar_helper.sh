# Download the given TAR if needed
if [ ! -e $ARC_TAR ]; then
        $ECHO "tar_helper: Downloading from $ARC_MIRROR into $ARC_TAR"
        $CURL -o $ARC_TAR -L $ARC_MIRROR
fi

# If the TAR is present and it has not yet been extracted
if [ ! -d $ARC_SOURCE_DIR ] && [ -e $ARC_TAR ]; then
        # Extract it
        $TAR -xf $ARC_TAR
        # Move it into *-src
        $MV $ARC_NAME $ARC_SOURCE_DIR
        $ECHO "tar_helper: Extracted $ARC_TAR -> $ARC_SOURCE_DIR"
        # Apply necessary patch work
        for f in $(find $(pwd) -maxdepth 1 -type f -name "*.patch"); do
                $ECHO "tar_helper: Applying patch $f to $ARC_SOURCE_DIR"
                $CD $ARC_NAME-src && patch -p1 < $f
        done
fi
