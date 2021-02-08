FROM alpine:edge as base

RUN \
    apk add --update --no-cache --virtual .unbound-deps \
    unbound \
    bind-tools \
    openssl \
    tini

RUN wget -S https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints

RUN \
    mkdir -p /var/log/unbound && \
    touch /var/log/unbound/unbound.log && \
    chown unbound:unbound /var/log/unbound/unbound.log && \
    ln -sf /dev/stdout /var/log/unbound/unbound.log 

COPY config/pi-hole.conf /etc/unbound/unbound.conf
RUN unbound-anchor && \
    unbound-checkconf && \
    chown unbound:unbound /usr/share/dnssec-root/trusted-key.key

ENTRYPOINT [ "/sbin/tini", "--" ]
CMD ["unbound"]