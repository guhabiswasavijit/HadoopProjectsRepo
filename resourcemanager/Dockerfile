FROM avijit1979/hadoop_3.3.1

HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1
WORKDIR /opt/hadoop
USER root
SHELL ["/bin/bash", "-c"]
ADD runResourceManager.sh runResourceManager.sh
RUN chmod a+x runResourceManager.sh
ENV PATH /opt/hadoop/bin:/opt/hadoop/sbin:$PATH
EXPOSE 8088

CMD ["./runResourceManager.sh"]
