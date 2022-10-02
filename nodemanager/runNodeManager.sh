#!/bin/bash

source configureKerberosClient.sh\
  && service ssh start \
  && hdfs --daemon start portmap \
  && hdfs --daemon start nfs3 \
  && yarn nodemanager
