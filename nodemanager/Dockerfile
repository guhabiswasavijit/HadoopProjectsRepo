FROM avijit1979/hadoop_3.3.1


HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1
WORKDIR /opt/hadoop
USER root
SHELL ["/bin/bash", "-c"]
ADD runNodeManager.sh runNodeManager.sh
RUN chmod a+x runNodeManager.sh
ENV HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop
ENV PATH /opt/hadoop/bin:/opt/hadoop/sbin:$PATH

EXPOSE 8042

CMD ["./runNodeManager.sh"]
