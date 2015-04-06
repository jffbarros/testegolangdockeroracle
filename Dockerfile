# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

#Instalação dos pacotes básicos
RUN apt-get update
RUN apt-get install -y pkg-config
RUN apt-get install -y alien
RUN apt-get install -y libaio1

#Download Oracle Instant Client 12 e SDK
RUN wget  --no-check-certificate https://googledrive.com/host/0B1Or3zIP-XLuYVhNZmthQVBTbzQ -O oracleinstantclient.rpm
RUN wget  --no-check-certificate https://googledrive.com/host/0B1Or3zIP-XLuNlJ6S2ZBZkZ6MTQ -O oraclesdk.rpm

#Converte e instala pacotes Oracle
RUN alien -i oracleinstantclient.rpm
RUN alien -i oraclesdk.rpm

#Baixa arquivo oci8.pc do repositório dentro do diretório do pkgconfig
RUN cd /usr/lib/pkgconfig/ && curl -o oci8.pc https://raw.githubusercontent.com/jffbarros/testegolangdockeroracle/master/oci8.pc

#Cria variável de ambiiente apontando para os arquivos de biblioteca
ENV LD_LIBRARY_PATH /usr/lib:/usr/local/lib:/usr/lib/oracle/12.1/client64/lib

#Instala go-oci8
RUN go get -u github.com/mattn/go-oci8

#Baixa repositório com aplicação de teste e gera executável
RUN go get -u github.com/jffbarros/testegolangdockeroracle
RUN go install -a github.com/jffbarros/testegolangdockeroracle

# Run the outyet command by default when the container starts.
ENTRYPOINT /go/bin/testegolangdockeroracle

# Document that the service listens on port 8081.
EXPOSE 8081