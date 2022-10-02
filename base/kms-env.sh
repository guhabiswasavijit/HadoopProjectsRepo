#!/usr/bin/env bash
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License. See accompanying LICENSE file.
#

# Set kms specific environment variables here.
#
# hadoop-env.sh is read prior to this file.
#

# KMS config directory
export KMS_CONFIG=${HADOOP_CONF_DIR}
export KMS_LOG=/opt/hadoop/logs
export KMS_TEMP=/opt/hadoop/temp
export KMS_HTTPS_PORT=9600
export KMS_MAX_THREADS=1000
export KMS_MAX_HTTP_HEADER_SIZE=65536
export KMS_SSL_ENABLED=true
export KMS_SSL_KEYSTORE_FILE=/opt/hadoop/kms.keystore
export KMS_SSL_KEYSTORE_PASS=changeit
