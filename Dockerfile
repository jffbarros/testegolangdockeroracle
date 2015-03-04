# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

RUN go get -u github.com/mattn/go-oci8
RUN go get -u github.com/jffbarros/testegolangdockeroracle
RUN go install -a github.com/jffbarros/testegolangdockeroracle

# Run the outyet command by default when the container starts.
ENTRYPOINT /go/bin/testegolangdockeroracle

# Document that the service listens on port 8080.
EXPOSE 8080