#! /bin/bash
#
P=$(dirname $0)
#
CURRENT=$P/api
PREV=$P/api-prev
INCLUDE=$(pkg-config --libs ecore |gawk '{ print substr($1,3) }' | sed s/lib/include/)
#
[ ! -d $PREV ] && mkdir $PREV
[ ! -d $CURRENT ] && mkdir $CURRENT
rm *-diff 2>/dev/null
#
for header in \
    "${INCLUDE}/eina-1/eina/eina_types.h" \
    "${INCLUDE}/eet-1/Eet.h" \
    "${INCLUDE}/edje-1/Edje.h" \
    "${INCLUDE}/evas-1/Evas.h" \
    "${INCLUDE}/evas-1/Evas_GL.h" \
    "${INCLUDE}/ecore-1/Ecore.h" \
    "${INCLUDE}/ecore-1/Ecore_Con.h" \
    "${INCLUDE}/ecore-1/Ecore_Input.h" \
    "${INCLUDE}/ecore-1/Ecore_Getopt.h" \
    "${INCLUDE}/ecore-1/Ecore_Evas.h" \
    "${INCLUDE}/ecore-1/Ecore_Fb.h" \
    "${INCLUDE}/ecore-1/Ecore_File.h" \
    "${INCLUDE}/elementary-0/Elementary.h" \
    ; do
    #
    DIR=$(dirname $header)
    FILE=$(basename $header)
    #
    mv $CURRENT/$FILE-* $PREV/ 2>/dev/null
    #
    for what in functions enums types callbacks; do
        F=$FILE-$what
        cat $header | sed -r -n -f $P/sed-$what > $CURRENT/$F
        if [ -f $PREV/$F ]; then
            diff -u0 $PREV/$F $CURRENT/$F > $P/$F-diff
            N=$(cat $P/$F-diff | wc -l)
            [ $N -eq 0 ] && rm $P/$F-diff || echo "see $P/$F-diff"
        fi
    done
    #
done
