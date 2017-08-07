FROM scratch
MAINTAINER chentao <chentao_ct@outlook.com>
WORKDIR /root
COPY main /root
CMD [./main]
