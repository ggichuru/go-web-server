FROM golang:1.21-alpine

# Live reload code during development -> bee tool 
RUN go install github.com/beego/bee/v2@latest

# Create a working dir
WORKDIR /app

# Copy go mod and sum files
COPY go.mod ./

# Download all dependencies
RUN go mod download

# Copy the source from the current directory to the working directory inside the container
COPY . ./


# Exposed port
EXPOSE 8010

CMD [ "bee", "run" ]