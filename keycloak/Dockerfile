FROM jboss/keycloak:16.1.0
#COPY --chown=jboss ./changeTimeout.batch /tmp/changeTimeout.batch

#RUN cd $JBOSS_HOME \
# && ./bin/jboss-cli.sh --file=/tmp/changeTimeout.batch \
#  && rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history \
#  && rm -rf $JBOSS_HOME/standalone/data \
#  && rm -rf $JBOSS_HOME/standalone/tmp \
#  && rm -rf /tmp/changeTimeout.batch
  

ARG DB_VENDOR
ARG DB_ADDR
ARG DB_DATABASE
ARG DB_USER
ARG DB_PASSWORD
ARG KEYCLOAK_USER
ARG KEYCLOAK_PASSWORD


EXPOSE 1812/udp
EXPOSE 1813/udp
ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]

CMD ["-b", "0.0.0.0"]
