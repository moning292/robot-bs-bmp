FROM debian
MAINTAINER Worakorn Chaichakan "worakorn.chaichakan@news.com.au"

ENV DEBIAN_FRONTEND noninteractive

# make sure the package repository is up to date
RUN apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y wget unzip python python-pip bzip2 ca-certificates openjdk-8-jre-headless sudo

RUN rm -rf /var/lib/apt/lists/* \
RUN sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

# BrowserMob Proxy download and install
ENV BMP_VERSION 2.1.4
RUN wget -O browsermob-proxy.zip https://github.com/lightbody/browsermob-proxy/releases/download/browsermob-proxy-$BMP_VERSION/browsermob-proxy-$BMP_VERSION-bin.zip \
    && unzip -q /browsermob-proxy.zip \
    && rm -f /browsermob-proxy.zip

RUN mv /browsermob-proxy-$BMP_VERSION /browsermob-proxy

# ENV VALUE
ENV BMP_PORT 9090
ENV PORT_RANGE 39500-39999
ENV TTL 600

# Install python, pip and Robot Framework required libraries        
RUN pip install robotframework robotframework-selenium2library browsermob-proxy \
        boto3
# Download and install BrowserStackLocal
RUN cd /usr/local/bin; wget https://www.browserstack.com/browserstack-local/BrowserStackLocal-linux-x64.zip && \
    unzip BrowserStackLocal-linux-x64.zip && \
        chmod +x BrowserStackLocal && \
        rm BrowserStackLocal-linux-x64.zip

COPY scripts/start.sh /
RUN chmod +x /start.sh

WORKDIR /home/ncg-automation

CMD ["/start.sh"]
