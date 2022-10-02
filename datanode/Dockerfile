FROM avijit1979/hadoop_3.3.1


HEALTHCHECK CMD curl -f http://localhost:50075/ || exit 1
ENV HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop
ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
VOLUME /hadoop/dfs/data
WORKDIR /opt/hadoop
USER root
SHELL ["/bin/bash", "-c"]
ENV PATH /opt/hadoop/bin:/opt/hadoop/sbin:$PATH
COPY gss-jaas.conf /etc/gss-jaas.conf
ADD runDataNode.sh runDataNode.sh
RUN chmod a+x runDataNode.sh
USER hdfs
CMD ["./runDataNode.sh"]
