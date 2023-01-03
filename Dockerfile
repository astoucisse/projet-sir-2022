FROM openjdk:11
LABEL maintainer="sir@formation.com"
VOLUME /main-app
ADD target/formation-demo1-0.0.1-SNAPSHOT.jar ./
EXPOSE 9091
ENTRYPOINT ["java","-jar","formation-demo1-0.0.1-SNAPSHOT.jar"]
