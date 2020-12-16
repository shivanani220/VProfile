FROM tomcat
MAINTAINER shiva
ARG CONT_IMG_VER
WORKDIR /usr/local/tomcat
EXPOSE 8080
COPY  ./target/vprofile-v1.war /usr/local/tomcat/webapps
