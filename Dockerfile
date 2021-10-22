# https://github.com/sonatype/docker-nexus3
ARG NEXUS_VERSION=latest
FROM sonatype/nexus3:${NEXUS_VERSION}

ENV SONATYPE_DIR="/opt/sonatype"
ENV NEXUS_HOME="${SONATYPE_DIR}/nexus" \
    NEXUS_DATA="/nexus-data" \
    SONATYPE_WORK=${SONATYPE_DIR}/sonatype-work \
    JAVA_MIN_MEM="1200M" \
    JAVA_MAX_MEM="1200M" \
    JKS_PASSWORD="changeit"

ENV NEXUS_PLUGINS ${NEXUS_HOME}/system

# https://github.com/flytreeleft/nexus3-keycloak-plugin
ENV KEYCLOAK_PLUGIN_VERSION 0.6.0-SNAPSHOT
ENV KEYCLOAK_PLUGIN_RELEASE 0.6.0-prev2-SNAPSHOT
ENV KEYCLOAK_PLUGIN /org/github/flytreeleft/nexus3-keycloak-plugin/${KEYCLOAK_PLUGIN_RELEASE}/nexus3-keycloak-plugin-${KEYCLOAK_PLUGIN_VERSION}

USER root

ADD ./nexus3-keycloak-plugin-${KEYCLOAK_PLUGIN_VERSION}.jar \
     ${NEXUS_PLUGINS}${KEYCLOAK_PLUGIN}.jar

ADD ./keycloak.json ${NEXUS_HOME}/etc
ADD ./keycloak.json ${NEXUS_DATA}/etc

RUN chmod 644 ${NEXUS_PLUGINS}/org/github/flytreeleft/nexus3-keycloak-plugin/${KEYCLOAK_PLUGIN_RELEASE}/nexus3-keycloak-plugin-${KEYCLOAK_PLUGIN_VERSION}.jar
RUN echo "reference\:file\:${KEYCLOAK_PLUGIN}.jar = 200" >> ${NEXUS_HOME}/etc/karaf/startup.properties

# setup permissions
RUN chown nexus:nexus -R /opt/sonatype/nexus

USER nexus