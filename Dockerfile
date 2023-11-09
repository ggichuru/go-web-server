FROM golang:1.21-alpine

# Live reload code during development -> bee tool 
RUN go install github.com/beego/bee/v2@latest

# Configure env
ENV GO111MODULE=on
ENV GOFLAGS=-mod=vendor

# Create a folder inside the container to store the application source code and make it active
ENV APP_HOME /go/src/go-web-server
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# Exposed port
EXPOSE 8010

CMD [ "bee", "run" ]