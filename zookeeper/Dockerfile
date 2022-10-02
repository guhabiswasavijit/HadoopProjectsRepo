FROM avijit1979/hadoop_3.3.1


HEALTHCHECK CMD curl -f http://localhost:2181/ || exit 1
WORKDIR /opt

RUN curl -L http://apache.osuosl.org/zookeeper/zookeeper-3.8.0/apache-zookeeper-3.8.0.tar.gz -s -o - | tar -xzf -
RUN mv apache-zookeeper-3.8.0 zookeeper
#ENV JAVA_HOME /usr/local/openjdk-11
USER root
RUN mkdir -p /opt/zookeeper/data
SHELL ["/bin/bash", "-c"]
COPY zoo.cfg /opt/zookeeper/conf/zoo.cfg
RUN chmod a+x /opt/zookeeper/bin/zkServer.sh
RUN chown -R hdfs:hadoop /opt/zookeeper/
WORKDIR /opt/zookeeper/bin
USER hdfs
CMD ["./zkServer.sh start"]
