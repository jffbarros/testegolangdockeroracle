# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

RUN go get -u github.com/jffbarros/testegolangdocker
RUN go install -a github.com/jffbarros/testegolangdocker

# Run the outyet command by default when the container starts.
ENTRYPOINT /go/bin/testegolangdocker

# Document that the service listens on port 8080.
EXPOSE 8080