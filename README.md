# OpenDJ Docker Image

The provided Dockerfile will generate an ephemeral OpenDJ image. Notice that this image is only intended for testing since all the data will be lost when the container is stopped.

By default the OpenDJ zip file is expected to be found in the root directory and it should be named "opendj.zip". If you prefer to pull the nightly build from the Forgerock server change the following lines:

```
RUN echo `curl -s https://forgerock.org/djs/opendjrel.js | grep -o "http://.*\.zip" | tail -1` | xargs curl -o /var/tmp/opendj.zip
#RUN unzip /var/tmp/opendj.zip -d /opt/ && rm -fr /var/tmp/opendj.zip
```

### Build the image

```
docker build -t $IMAGE_NAME:$IMAGE_VERSION .
```

### Start container:

```
docker run -d -p $HOST_LDAP_PORT:1389 $HOST_LDAPS_PORT:1636 $IMAGE_NAME:$IMAGE_VERSION
```
