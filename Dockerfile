# syntax=docker/dockerfile:1

# Boilerplate from https://docs.docker.com/language/golang/build-images/

FROM golang:1.22.0

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies
# Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source code
# Note the slash at the end, as explained in https://docs.docker.com/reference/dockerfile/#copy
COPY *.go ./src

# Build the Go app
RUN CGO_ENABLED=0 GOOS=linux go build -o /go-atproto

# To bind to a TCP port, runtime parameters must be supplied to the docker command
# But we can (optionally) document in the Dockerfile what ports the application is going to listen on by default.
# https://docs.docker.com/reference/dockerfile/#expose
EXPOSE 8080

# Run
CMD ["/go-atproto"]
