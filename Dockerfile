FROM tomcat:1.0.0
LABEL maintainer="Val Feron"

ENV CATALINA_HOME /usr/local/tomcat
ENV JAVA_OPTS="-Xmx12g -Xms12g"

WORKDIR $CATALINA_HOME

# War file replacement
RUN rm -rf /webapps/*
COPY hello-world.war /webapps/ROOT.war

EXPOSE 8080

ENTRYPOINT ["/bin/catalina.sh", "run"]
