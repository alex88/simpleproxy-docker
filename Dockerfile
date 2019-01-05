FROM alpine:latest as builder

RUN apk add --update --no-cache build-base unzip

RUN mkdir simpleproxy
RUN wget https://github.com/vzaliva/simpleproxy/archive/v.3.5.tar.gz
RUN tar --extract --file v.3.5.tar.gz --strip-components 1 --directory simpleproxy

RUN cd simpleproxy && \
	./configure && \
	make

FROM alpine:latest

COPY --from=builder simpleproxy/simpleproxy bin/simpleproxy

ENTRYPOINT ["simpleproxy"]
