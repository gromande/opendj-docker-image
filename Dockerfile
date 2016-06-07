FROM java:8

WORKDIR /opt

EXPOSE 1389 1636 4444
ADD opendj.zip /var/tmp/

#RUN echo `curl -s https://forgerock.org/djs/opendjrel.js | grep -o "http://.*\.zip" | tail -1` | xargs curl -o /var/tmp/opendj.zip
RUN unzip /var/tmp/opendj.zip -d /opt/ && rm -fr /var/tmp/opendj.zip
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

RUN /opt/opendj/setup --cli -p 1389 --ldapsPort 1636 --enableStartTLS --generateSelfSignedCertificate  --baseDN "dc=example,dc=com" -h localhost --rootUserPassword password --acceptLicense --no-prompt --doNotStart

ADD 99-custom-schema.ldif /opt/opendj/config/schema/
ADD custom-dit.ldif /var/tmp/

RUN /opt/opendj/bin/import-ldif --backendID userRoot --ldifFile /var/tmp/custom-dit.ldif && rm -fr /var/tmp/custom-dit.ldif

CMD ["/opt/opendj/bin/start-ds", "--nodetach"]
