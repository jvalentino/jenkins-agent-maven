FROM jenkins/agent:latest-jdk11
USER root
RUN apt-get update && apt-get install -y maven=3.6.3-5

# Handle using OpenJDK 17 as the maven runtime
RUN apt-get update && apt-get install -y openjdk-17-jdk

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-arm64
RUN export JAVA_HOME