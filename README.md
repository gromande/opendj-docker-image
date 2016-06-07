# OpenDJ Docker Image

Build the image:

`docker build -t $IMAGE_NAME:$IMAGE_VERSION .`

Start container:

`docker run -d -p $HOST_LDAP_PORT:1389 $HOST_LDAPS_PORT:1636 $IMAGE_NAME:$IMAGE_VERSION`
