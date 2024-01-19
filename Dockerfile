#
# Copyright (c) 2022-2024 Nagrind <https://github.com/nagrind>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#

FROM alpine:latest

LABEL maintainer="Nagrind <https://github.com/nagrind>" \
      description="Container to carry out IP network investigations" \
      org.opencontainers.image.title="rannsakanda" \
      org.opencontainers.image.description="Container to carry out IP network investigations" \
      org.opencontainers.image.url="https://github.com/nagrind/rannsakanda" \
      org.opencontainers.image.source="https://github.com/nagrind/rannsakanda" \
      org.opencontainers.image.licenses="ISC" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.name="rannsakanda" \
      org.label-schema.description="Container to carry out IP network investigations" \
      org.label-schema.url="https://github.com/nagrind/rannsakanda" \
      org.label-schema.vcs-url="https://github.com/nagrind/rannsakanda"

RUN set -x && \
  export BUILDREQ="gcc musl-dev python3-dev py-pip" && \
  apk --no-cache upgrade && \
  apk --no-cache add ${BUILDREQ} bash bind-tools gawk git ipcalc jq python3 whois && \
  pip install aggregate6 --break-system-packages && \
  git clone -b main --single-branch https://github.com/nagrind/rirr-tools.git && \
  cp -a rirr-tools/[a-z]* /usr/bin/ && \
  rm -rf rirr-tools/ && \
  apk --no-cache del ${BUILDREQ}

ENTRYPOINT ["/bin/bash"]
