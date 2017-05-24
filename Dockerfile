#
# Nightwatch.js Dockerfile
#

FROM mhart/alpine-node:6

MAINTAINER Subhojit Paul <subhojitpaul21@gmail.com>

RUN apk --no-cache add \
    # Install tini, a tiny but valid init for containers:
    tini \
    # Install ffmpeg for video recording:
    ffmpeg \
  && npm install -g \
    # Install Nightwatch.js:
    gulp-cli \
  # Clean up obsolete files:
  && rm -rf \
    /tmp/* \
    /root/.npm

# Add node system user/group with uid/gid 1000.
# This is a workaround for boot2docker issue #581, see
# https://github.com/boot2docker/boot2docker/issues/581
RUN adduser -D -u 1000 node

USER node

WORKDIR /home/node

COPY wait-for.sh /usr/local/bin/wait-for
COPY entrypoint.sh /usr/local/bin/entrypoint

ENTRYPOINT ["entrypoint"]
