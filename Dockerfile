FROM golang:1.20.1 as builder

WORKDIR /app

COPY ./go.mod ./go.sum ./
RUN go mod download

COPY ./ ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main ./cmd/test/main.go

## STEP 2
FROM scratch

COPY --from=0 /app/main /app
EXPOSE 8080

CMD [ "/app" ]
