FROM avijit1979/hadoop_3.3.1


HEALTHCHECK CMD kadmin.local -q "list_principals" || exit 1
EXPOSE 749 88

ENV DEBIAN_FRONTEND noninteractive
# The -qq implies --yes
RUN apt-get -qq update
RUN apt-get -qq install locales krb5-kdc krb5-admin-server bash sudo
RUN apt-get -qq clean

RUN locale-gen "en_US.UTF-8"
RUN echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/default/locale
USER root
SHELL ["/bin/bash", "-c"]
COPY init-script.sh /opt/
WORKDIR /opt
RUN chmod u+x init-script.sh
CMD ./init-script.sh
