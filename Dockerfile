FROM ubuntu:14.04

MAINTAINER 5t111111 "https://github.com/5t111111"

# Install packages for building node
RUN apt-get update
RUN apt-get install -qqy --force-yes git curl
RUN apt-get clean

# Install ndenv and node-build
RUN git clone https://github.com/riywo/ndenv /usr/local/ndenv
RUN git clone https://github.com/5t111111/node-build.git /usr/local/ndenv/plugins/node-build
RUN /usr/local/ndenv/plugins/node-build/install.sh
ENV PATH /usr/local/ndenv/bin:$PATH
RUN echo 'eval "$(ndenv init -)"' >> /etc/profile.d/ndenv.sh

# Install multiple versions of node
ADD ./versions.txt /usr/local/ndenv/versions.txt
RUN xargs -L 1 ndenv install < /usr/local/ndenv/versions.txt
