FROM golang:1.22.3 as builder

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY *.go ./
RUN go build -o fitbit-data-replicator main.go

FROM scratch
COPY --from=builder /app/fitbit-data-replicator /
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["/fitbit-data-replicator"]
