FROM java:8-jdk
LABEL maintainer="john.lin@ringcentral.com"

ENV OPENMQ_VERSION=5.1
ENV OPENMQ_ARCHIVE=openmq5_1-binary-linux.zip

ADD /config/config.properties /opt/openmq/MessageQueue${OPENMQ_VERSION}/var/mq/instances/imqbroker/props/config.properties

RUN cd /opt/openmq/ && \
    wget "http://download.java.net/mq/open-mq/${OPENMQ_VERSION}/latest/${OPENMQ_ARCHIVE}" 2>/dev/null && \
    unzip ${OPENMQ_ARCHIVE} && \
    rm -f ${OPENMQ_ARCHIVE}

# portmapper & broker
EXPOSE 7676
# stomp service
EXPOSE 7677

CMD ["/opt/openmq/MessageQueue5.1/mq/bin/imqbrokerd","-startRmiRegistry","-rmiRegistryPort","1616","-port","7676","-silent","-vmargs","-server","-Xms1g","-Xmx5g","-XX:MaxMetaspaceSize=1g","-XX:-UseGCOverheadLimit","-Djava.io.tmpdir=/tmp"]