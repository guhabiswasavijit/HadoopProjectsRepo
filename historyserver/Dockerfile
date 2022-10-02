FROM avijit1979/hadoop_3.3.1


HEALTHCHECK CMD curl -f http://localhost:8188/ || exit 1
ENV HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop
ENV YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=/hadoop/yarn/timeline
RUN mkdir -p /hadoop/yarn/timeline
VOLUME /hadoop/yarn/timeline
WORKDIR /opt/hadoop
USER root
SHELL ["/bin/bash", "-c"]
ENV PATH /opt/hadoop/bin:/opt/hadoop/sbin:$PATH
ENV JAVA_HOME /usr/local/openjdk-11
ENV REALM ${REALM:-EXAMPLE.COM}
ENV KADMIN_PRINCIPAL ${KADMIN_PRINCIPAL:-kadmin/admin}
ENV KADMIN_PASSWORD ${KADMIN_PASSWORD:-MITiys4K5}
ADD runHistoryServer.sh runHistoryServer.sh
RUN chmod a+x runHistoryServer.sh

EXPOSE 8188

CMD ["./runHistoryServer.sh"]
