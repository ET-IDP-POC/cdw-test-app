FROM golang:1.20-alpine AS build
ADD . /src
WORKDIR /src
RUN go get -d -v -t
RUN GOOS=linux GOARCH=amd64 go build -v -o cdw-test-app 

FROM alpine:3.17.3
EXPOSE 8080
CMD ["cdw-test-app"]
ENV VERSION 1.1.4
COPY --from=build /src/cdw-test-app /usr/local/bin/cdw-test-app
RUN chmod +x /usr/local/bin/cdw-test-app
