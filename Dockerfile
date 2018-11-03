# Dockerfile for RANDI2
# * needs an additional postgres container

FROM tomcat:7

#MAINTAINER Matthew Shun-Shin (matthew.shunshin@gmail.com)
LABEL maintainer "Matthew Shun-Shin (matthew.shunshin@gmail.com)"

ENV RANDI_HOME    $CATALINA_HOME/webapps/randi

ENV RANDI_VERSION 0.9.4

RUN ["mkdir", "/tmp/randi"]
COPY RANDI2_0.9.4.tar.gz /tmp/randi/randi.tar.gz

RUN rm -rf $CATALINA_HOME/webapps/* && \
    cd /tmp/randi && \
    tar -xvzf randi.tar.gz && \
    mkdir $RANDI_HOME && \
    cd $RANDI_HOME && \
    cp /tmp/randi/RANDI2_0.9.4/RANDI2_094.war ./randi.war && \
    unzip randi.war && \
    rm randi.war

COPY config.properties $RANDI_HOME/WEB-INF/classes/config.properties
COPY create_tomcat_admin_user.sh /create_tomcat_admin_user.sh
COPY run.sh /run.sh
    
RUN chmod +x /*.sh
    
ENV JAVA_OPTS -Xmx1280m -XX:+UseParallelGC -XX:MaxPermSize=180m -XX:+CMSClassUnloadingEnabled

CMD ["/run.sh"]
