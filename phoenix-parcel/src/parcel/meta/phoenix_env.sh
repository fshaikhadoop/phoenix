#!/bin/bash
############################################################################
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
############################################################################

set -ex


#The following is written to aid local testing
if [ -z ${PARCELS_ROOT} ] ; then
    export MYDIR=`dirname "${BASH_SOURCE[0]}"`
    PARCELS_ROOT=`cd ${MYDIR}/../.. &&  pwd`
fi
PARCEL_DIRNAME=${PARCEL_DIRNAME-PHOENIX}

export PHOENIX_HOME=${PARCELS_ROOT}/${PARCEL_DIRNAME}/lib/phoenix

[ -d ${PHOENIX_HOME} ] || {
    echo "Could not find phoenix parcel lib dir, exiting" >&2
    exit 1
}

PHOENIX_SERVER_JAR_PATH=`echo ${PHOENIX_HOME}/phoenix-*-server.jar | sed 's/ /:/g'`
echo "appending '${PHOENIX_SERVER_JAR_PATH}' to HBASE_CLASSPATH"
if [ -z ${HBASE_CLASSPATH} ] ; then
    export HBASE_CLASSPATH=${PHOENIX_SERVER_JAR_PATH}
else
    export HBASE_CLASSPATH="${HBASE_CLASSPATH}:${PHOENIX_SERVER_JAR_PATH}"
fi
echo "Set HBASE_CLASSPATH to '${HBASE_CLASSPATH}'"
echo "Set PHOENIX_HOME to '${PHOENIX_HOME}'"
echo "phoenix_env.sh successfully executed at `date`"
