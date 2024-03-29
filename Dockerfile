FROM openjdk:17-jdk
VOLUME /tmp
RUN microdnf install findutils #this line has been added specifically for MAC OS
ARG JAVA_OPTS
ENV JAVA_OPTS=$JAVA_OPTS
COPY rewards rewards
WORKDIR rewards
RUN ./gradlew --no-daemon --version
RUN ./gradlew --no-daemon build
# COPY rewards/build/libs/rewards-0.0.1-SNAPSHOT.jar rewards.jar
EXPOSE 8080
EXPOSE 9002
#ENTRYPOINT exec java $JAVA_OPTS -jar rewards.jar
# For Spring-Boot project, use the entrypoint below to reduce Tomcat startup time.
ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar build/libs/rewards-0.0.1-SNAPSHOT.jar

