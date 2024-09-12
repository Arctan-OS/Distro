ACLOCAL_INC=""
if [ -d $(ARC_SYSROOT)/usr/local/share ]; then
   ACLOCAL_INCLUDE"-I${ARC_SYSROOT}/usr/local/share"
fi

for f in $(find $(pwd)/$ARC_RECONF_DIR -name configure.ac -or -name configure.in -type f);
do
    echo "reconfiguring $(dirname "$f")" >> $(ARC_ROOT)/reconfigs.txt
    cd "$(dirname "$f")" && autoreconf -fvi "$@" $ACLOCAL_INC
done
