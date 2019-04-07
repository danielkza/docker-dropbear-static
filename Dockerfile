FROM alpine AS builder

RUN apk add --no-cache alpine-sdk
RUN apk add --no-cache \
    musl-dev \
    zlib-dev \
    tar \
    bzip2

ARG DROPBEAR_VERSION=2019.78
WORKDIR /src
RUN curl -sSL https://matt.ucc.asn.au/dropbear/releases/dropbear-${DROPBEAR_VERSION}.tar.bz2 \
    | tar --strip-components=1 -xvj

ENV PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp"
RUN ./configure \
      --enable-static \
      --disable-utmp \
      --disable-wtmp \
      --disable-lastlog \
    && make -j4 PROGRAMS="$PROGRAMS" MULTI=1

RUN mkdir -p /dropbear/bin /dropbear/etc/dropbear \
    && (cd /dropbear/bin \
        && cp /src/dropbearmulti ./ \
        && for program in $PROGRAMS ssh; do ln -s dropbearmulti $program; done) \
    && chmod 0700 /dropbear/etc/dropbear

FROM busybox
COPY --from=builder /dropbear/ /
CMD ["dropbear", "-R", "-F", "-E"]
