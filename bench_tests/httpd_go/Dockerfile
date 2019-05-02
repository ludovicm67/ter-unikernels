FROM golang:1.12
WORKDIR /app
COPY . .
RUN go build
EXPOSE 1234
CMD [ "./httpd_go" ]
