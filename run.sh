#!/bin/bash

if [ ! -f /.tomcat_admin_created ]; then
  /create_tomcat_admin_user.sh
fi

if [ -z "$LOG_LEVEL" ]; then
  echo "Using default log level."
else
  echo "org.apache.catalina.core.ContainerBase.[Catalina].level = $LOG_LEVEL" > $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/logging.properties
  echo "org.apache.catalina.core.ContainerBase.[Catalina].handlers = java.util.logging.ConsoleHandler" >> $CATALINA_HOME/webapps/OpenClinica/WEB-INF/classes/logging.properties
  echo "org.apache.catalina.core.ContainerBase.[Catalina].level = $LOG_LEVEL" > $CATALINA_HOME/webapps/OpenClinica-ws/WEB-INF/classes/logging.properties
  echo "org.apache.catalina.core.ContainerBase.[Catalina].handlers = java.util.logging.ConsoleHandler" >> $CATALINA_HOME/webapps/OpenClinica-ws/WEB-INF/classes/logging.properties
fi  

exec ${CATALINA_HOME}/bin/catalina.sh run
