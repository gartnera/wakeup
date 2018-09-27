FROM golang AS build-env
RUN mkdir -p /go/src/mpolden/wakeup/
WORKDIR /go/src/mpolden/wakeup/
COPY . .
RUN go get -d -v ./... && CGO_ENABLED=0 GOOS=linux go install ./...


FROM alpine
COPY --from=build-env /go/bin/wakeup /usr/bin/wakeup
COPY static /static
EXPOSE 8888
CMD /usr/bin/wakeup -s /static/ -c /cache -l :8888
