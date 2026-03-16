FROM golang:1.22-alpine
RUN apk add --no-cache git make gcc musl-dev
RUN go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
WORKDIR /workspace
