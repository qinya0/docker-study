FROM ubuntu:14.04

# set ENV if you need

RUN \
  DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install mysql-client && \
  DEBIAN_FRONTEND=noninteractive apt-get -y autoremove && \
  DEBIAN_FRONTEND=noninteractive apt-get -y clean
