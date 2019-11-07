FROM tomcat:1.0.0
LABEL maintainer="Val Feron"
LABEL com.example.is-production="0" \
      com.example.version="0.0.1-beta" \
      com.example.release-date="2019-11-08"

ENV CATALINA_HOME /usr/local/tomcat
ENV JAVA_OPTS="-Xmx12g -Xms12g"

WORKDIR $CATALINA_HOME

# War file replacement
RUN rm -rf /webapps/*
COPY hello-world.war /webapps/ROOT.war

EXPOSE 8080

ENTRYPOINT ["/bin/catalina.sh", "run"]
