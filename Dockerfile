FROM tomcat:latest
LABEL maintainer="Val Feron" \
      is-production="0" \
      version="0.0.1-beta" \
      release-date="2019-11-08"

ENV CATALINA_HOME /usr/local/tomcat
ENV JAVA_OPTS="-Xmx12g -Xms12g"

WORKDIR $CATALINA_HOME

# War file replacement
RUN rm -rf /webapps/*
COPY hello-world.war /webapps/ROOT.war

EXPOSE 8080

ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh", "run"]
