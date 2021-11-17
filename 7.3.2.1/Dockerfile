FROM library/golang:1.12.4-stretch as builder

MAINTAINER harrywu0913 <1248120122@qq.com>

ENV FILEBEAT_VERSION 7.3.2

RUN set -x \
    && mkdir -p ${GOPATH}/src/github.com/elastic \
	&& cd ${GOPATH}/src/github.com/elastic \
    # && git clone https://gitee.com/harrywu0913/beats.git \
	&& git clone https://github.com/elastic/beats \
	&& cd beats/x-pack/filebeat \
    && make update \
    && env GOPROXY="https://goproxy.cn,https://goproxy.io,direct" mage build \
    && addgroup --system --gid 1000 filebeat \
    && adduser --system --disabled-login --home /usr/share/filebeat --uid 1000 --gid 1000 filebeat \
    && cp -r \
        ${GOPATH}/src/github.com/elastic/beats/x-pack/filebeat/filebeat \
        ${GOPATH}/src/github.com/elastic/beats/x-pack/filebeat/*.yml \
        ${GOPATH}/src/github.com/elastic/beats/x-pack/filebeat/build/package/* \
        ${GOPATH}/src/github.com/elastic/beats/x-pack/filebeat/build/kibana \
        /usr/share/filebeat/ \
    && find /usr/share/filebeat -type d -exec chmod 0750 {} \; \
    && find /usr/share/filebeat -type f -exec chmod 0640 {} \; \
    && mkdir /usr/share/filebeat/data /usr/share/filebeat/logs \
    && chown -R root:filebeat /usr/share/filebeat \
    && chmod 0770 /usr/share/filebeat/modules.d /usr/share/filebeat/data /usr/share/filebeat/logs

FROM library/debian:buster-slim

ENV FILEBEAT_VERSION=7.3.2 \
    PATH=/usr/share/filebeat:$PATH

# Install filebeat
RUN set -x \
    && addgroup --system --gid 1000 filebeat \
    && adduser --system --disabled-login --home /usr/share/filebeat --uid 1000 --gid 1000 filebeat

COPY --from=builder /usr/share/filebeat /usr/share/filebeat

COPY docker-entrypoint /usr/local/bin/docker-entrypoint

WORKDIR /usr/share/filebeat

USER 1000

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

CMD ["-e"]