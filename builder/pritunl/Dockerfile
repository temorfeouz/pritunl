FROM alpine:latest
MAINTAINER Artem

ENV VERSION="1.32.3732.84"

# Build deps
RUN apk --no-cache add --update iptables ipset go git wget py3-pip \ 
    gcc python3 python3-dev make musl-dev linux-headers libffi-dev openssl-dev \
    py-setuptools openssl procps ca-certificates openvpn 
    
# Pritunl Install
RUN go env -w GOBIN=/usr/bin
RUN go env -w CGO_ENABLED=0
RUN GOPROXY=https://goproxy.cn go install github.com/pritunl/pritunl-web@latest #GOPROXY=https://goproxy.cn
RUN GOPROXY=https://goproxy.cn go install github.com/pritunl/pritunl-dns@latest #
    
RUN wget https://github.com/pritunl/pritunl/archive/refs/tags/${VERSION}.tar.gz; \
    tar zxvf ${VERSION}.tar.gz
RUN cd pritunl-${VERSION}; \
    pip install boto3; \
    python3 setup.py build; python3 -m venv venv; \
    pip install -r requirements.txt --break-system-packages; \
    python3 setup.py install
RUN rm -rf *${VERSION}*; rm -rf /tmp/* /var/cache/apk/*; rm -rf /root/go/*; rm -rf /root/.cache; apk del go

RUN sed -i -e '/^attributes/a prompt\t\t\t= yes' /etc/ssl/openssl.cnf
RUN sed -i -e '/countryName_max/a countryName_value\t\t= US' /etc/ssl/openssl.cnf

ENTRYPOINT ["pritunl", "start"]