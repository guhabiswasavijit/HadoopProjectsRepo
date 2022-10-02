FROM avijit1979/hadoop_3.3.1


HEALTHCHECK CMD curl -f https:/localhost:9600/kms/v1/keys || exit 1
ENV HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop

WORKDIR /opt/hadoop
USER root
SHELL ["/bin/bash", "-c"]
ENV PATH /opt/hadoop/bin:/opt/hadoop/sbin:$PATH
ADD runKmsServer.sh runKmsServer.sh
COPY gss-jaas.conf /etc/gss-jaas.conf
RUN chmod a+x runKmsServer.sh
COPY kms.keystore kms.keystore
USER hdfs

CMD ["./runKmsServer.sh"]
