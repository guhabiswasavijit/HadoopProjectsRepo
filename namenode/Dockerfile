FROM avijit1979/hadoop_3.3.1


HEALTHCHECK CMD curl -f http://localhost:8020/ || exit 1
ENV HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop
ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name
RUN mkdir -p /hadoop/dfs/name
VOLUME /hadoop/dfs/name
WORKDIR /opt/hadoop
USER root
SHELL ["/bin/bash", "-c"]
ENV PATH /opt/hadoop/bin:/opt/hadoop/sbin:$PATH
COPY gss-jaas.conf /etc/gss-jaas.conf
ADD runNameNode.sh runNameNode.sh
RUN chmod a+x runNameNode.sh
USER hdfs

CMD ["./runNameNode.sh"]
