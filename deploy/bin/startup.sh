#!/bin/bash

APPLICATION="${project.build.finalName}"
APPLICATION_JAR="${APPLICATION}.jar"
BIN_PATH=$(cd `dirname $0`; pwd)
cd `dirname $0`
cd ..
BASE_PATH=`pwd`
CONFIG_DIR=${BASE_PATH}"/config/"
LOG_DIR=${BASE_PATH}"/logs"
LOG_FILE="${APPLICATION}.log"
LOG_PATH="${LOG_DIR}/${LOG_FILE}"
LOG_BACK_DIR="${LOG_DIR}/back/"
LOG_STARTUP_PATH="${LOG_DIR}/startup.log"
NOW=`date +'%Y-%m-%m-%H-%M-%S'`
NOW_PRETTY=`date +'%Y-%m-%m %H:%M:%S'`
STARTUP_LOG="================================================ ${NOW_PRETTY} ================================================\n"

if [[ ! -d "${LOG_DIR}" ]]; then
  mkdir "${LOG_DIR}"
fi

if [[ ! -d "${LOG_BACK_DIR}" ]]; then
  mkdir "${LOG_BACK_DIR}"
fi

if [[ -f "${LOG_PATH}" ]]; then
	mv ${LOG_PATH} "${LOG_BACK_DIR}/${APPLICATION}_back_${NOW}.log"
fi

echo "" > ${LOG_PATH}

JAVA_OPT=`cat ${BASE_PATH}/jvm.options`
STARTUP_CMD="nohup java ${JAVA_OPT} -jar ${BASE_PATH}/boot/${APPLICATION_JAR} --spring.config.location=${CONFIG_DIR} > ${LOG_PATH} 2>&1 &"

STARTUP_LOG="${STARTUP_LOG}application name: ${APPLICATION}\n"
STARTUP_LOG="${STARTUP_LOG}application jar  name: ${APPLICATION_JAR}\n"
STARTUP_LOG="${STARTUP_LOG}application root path: ${BASE_PATH}\n"
STARTUP_LOG="${STARTUP_LOG}application log  path: ${LOG_PATH}\n"
STARTUP_LOG="${STARTUP_LOG}application JAVA_OPT : ${JAVA_OPT}\n"
STARTUP_LOG="${STARTUP_LOG}application startup command: ${STARTUP_CMD}\n"

eval ${STARTUP_CMD}

PID=$(ps -ef | grep "${APPLICATION_JAR}" | grep -v grep | awk '{ print $2 }')
STARTUP_LOG="${STARTUP_LOG}application pid: ${PID}\n"

echo -e ${STARTUP_LOG} >> ${LOG_STARTUP_PATH}
echo -e ${STARTUP_LOG}
tail -f ${LOG_PATH}