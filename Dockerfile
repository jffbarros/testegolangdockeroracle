# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang


RUN apt-get update
RUN apt-get install -y pkg-config
RUN apt-get install -y alien
RUN apt-get install -y libaio1

RUN wget  --no-check-certificate https://googledrive.com/host/0B1Or3zIP-XLuYVhNZmthQVBTbzQ -O oracleinstantclient.rpm
RUN wget  --no-check-certificate https://googledrive.com/host/0B1Or3zIP-XLuNlJ6S2ZBZkZ6MTQ -O oraclesdk.rpm
RUN wget  --no-check-certificate https://googledrive.com/host/0B1Or3zIP-XLuUzZtT045Y0V1RmM -O /usr/oci8.pc

RUN alien -i oracleinstantclient.rpm
RUN alien -i oraclesdk.rpm


#ENV PKG_CONFIG_PATH /usr/oci8.pc
RUN cd /usr/lib/pkgconfig/ && curl -o oci8.pc https://raw.githubusercontent.com/wendyeq/go-oci8/master/oci8.pc
ENV LD_LIBRARY_PATH /usr/lib:/usr/local/lib:/usr/lib/oracle/12.1/client64/lib
RUN go get -u github.com/mattn/go-oci8
#RUN go get -u github.com/jffbarros/testegolangdockeroracle
#RUN go install -a github.com/jffbarros/testegolangdockeroracle

# Run the outyet command by default when the container starts.
#ENTRYPOINT /go/bin/testegolangdockeroracle

# Document that the service listens on port 8080.
#EXPOSE 8080