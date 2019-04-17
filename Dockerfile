FROM minio/mc
COPY ./run.sh /
RUN chmod 744 /run.sh
ENTRYPOINT ["/run.sh"]
