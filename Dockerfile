FROM centos

MAINTAINER com

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O http://apachemirror.wuchna.com/tomcat/tomcat-8/v8.5.43/bin/apache-tomcat-8.5.43.tar.gz
RUN tar xvf apache*.tar.gz
RUN mv apache-tomcat-8.5.43/* /opt/tomcat/.
#RUN set -x \
#    && curl -u admin:aspire@123 http://3.87.197.145:8080/job/simple-app/lastSuccessfulBuild/artifact/target/WebApp.war --output WebApp.war \
#    && chmod 777 -R /opt/tomcat
ADD ./target/*.war .
RUN chmod 777 -R /opt/tomcat
RUN yum -y install java
RUN java -version

WORKDIR /opt/tomcat/webapps
RUN chmod 777 /opt/tomcat/webapps -R
#RUN curl -O http://3.87.197.145:8080/job/simple-app/lastSuccessfulBuild/artifact/target/WebApp.war
RUN mv /opt/tomcat/*.war .
EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
