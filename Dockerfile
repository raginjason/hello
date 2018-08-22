FROM golang:1.11-rc as builder

WORKDIR /go11
COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .
RUN ls -al
RUN CGO_ENABLED=0 GOOS=linux go build -o app ./...
RUN go test ./...

FROM scratch
COPY --from=builder /go11/app /app

CMD ["/app"]
