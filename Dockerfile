FROM golang:1.17-alpine AS builder

WORKDIR /app

COPY . .

RUN go mod init golang

RUN CGO_ENABLED=0 go build -ldflags '-w -s' -o main .

FROM scratch

COPY --from=builder /app/main /main

EXPOSE 8080

CMD ["/main"]