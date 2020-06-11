#!/bin/bash
APPLICATION_JAR="${project.build.finalName}.jar"
PID=$(ps -ef | grep "${APPLICATION_JAR}" | grep -v grep | awk '{ print $2 }')
kill -9 ${PID}