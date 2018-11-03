# Dockerfile for RANDI2
# * needs an additional postgres container

FROM tomcat:7

#MAINTAINER Matthew Shun-Shin (matthew.shunshin@gmail.com)
LABEL maintainer "Matthew Shun-Shin (matthew.shunshin@gmail.com)"

ENV RANDI2_HOME    $CATALINA_HOME/webapps/RANDI2

ENV RANDI2_VERSION 0.9.4

RUN ["mkdir", "/tmp/randi2"]
COPY RANDI2_0.9.4.tar.gz /tmp/randi2/randi2.tar.gz

RUN cd /tmp/randi2 && \
    tar -xvzf randi2.tar.gz && \
    mkdir $RANDI2_HOME && \
    cd $RANDI2_HOME && \
    cp /tmp/randi2/RANDI2_0.9.4/RANDI2_094.war ./RANDI2.war && \
    unzip RANDI2.war && cd ..

COPY create_tomcat_admin_user.sh /create_tomcat_admin_user.sh
COPY run.sh /run.sh
    
RUN chmod +x /*.sh
    
ENV JAVA_OPTS -Xmx1280m -XX:+UseParallelGC -XX:MaxPermSize=180m -XX:+CMSClassUnloadingEnabled

CMD ["/run.sh"]
