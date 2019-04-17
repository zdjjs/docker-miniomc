#!/bin/sh

: ${MINIO_ACCESS_KEY:=AKIAIOSFODNN7EXAMPLE}
: ${MINIO_SECRET_KEY:=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY}
: ${MINIO_BUCKET:=static}
: ${MINIO_PUBLIC_DOWNLOAD:=false}

until (/usr/bin/mc config host add minio http://minio:9000 ${MINIO_ACCESS_KEY} ${MINIO_SECRET_KEY}) do sleep 1; done;
/usr/bin/mc mb minio/${MINIO_BUCKET}

if ${MINIO_PUBLIC_DOWNLOAD}; then
    /usr/bin/mc policy download minio/${MINIO_BUCKET};
fi

if [ -e /data_init ]; then
    /usr/bin/mc cp -r /data_init/ minio/${MINIO_BUCKET}/
fi
