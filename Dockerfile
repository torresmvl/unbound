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
    chown unbound /var/log/unbound/unbound.log && \
    ln -sf /dev/stdout /var/log/unbound/unbound.log

# COPY --chown=unbound:unbound log /var/log/unbound
# RUN ln -sf /dev/stdout /var/log/unbound/unbound.log

COPY config/pi-hole.conf /etc/unbound/unbound.conf
RUN unbound-checkconf

ENTRYPOINT [ "/sbin/tini", "--" ]
CMD ["unbound"]