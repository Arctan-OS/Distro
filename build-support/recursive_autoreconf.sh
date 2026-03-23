rm -f $SOURCE_DIR/reconfigure.log
touch $SOURCE_DIR/reconfigure.log

# Provide sysroot ACLOCAL include directory if present
ACLOCAL_INC=""
if [ -d $ARC_BUILD_PREFIX/share ]; then
   ACLOCAL_INC="-I${ARC_BUILD_PREFIX}/share"
fi

# Error if the source directory that is desired to
# be rescursively reconfigured does not exist
if [ ! -d $SOURCE_DIR ]; then
    echo "Directory $SOURCE_DIR does not exist!"
    exit 1
fi

# Reconfigure the deepest directories first (that contain a file or files
# named configure.ac configure.in or configure). Once reconfigured, add these
# directories to a list of directories that have been reconfigured
for d in $(find $SOURCE_DIR -depth -type d); do
    conf=$(find $d -name configure.ac -or -name configure.in -or -name configure -type f)

    if [ -z $(grep -zoP "$d\n" $SOURCE_DIR/reconfigure.log) ] && [ -n "$conf" ]; then
        cd $d && autoreconf -fvi "$@" $ACLOCAL_INC
        echo "Reconfigured ($?) $d" >> $SOURCE_DIR/reconfigure.log
    fi
done
