FROM debian:jessie

RUN apt-get update \
 && apt-get install -y icedtea-plugin firefox-esr=52.8.1esr-1~deb8u1 \
 && rm -rf /var/lib/apt/lists/*

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 \
 && mkdir -p /home/developer \
 && echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd \
 && echo "developer:x:${uid}:" >> /etc/group \
 && echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
 && chown ${uid}:${gid} -R /home/developer

RUN sed -i '/^grant/ a permission java.util.PropertyPermission "sun.arch.data.model", "read";' /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.policy

USER developer

ENV HOME /home/developer
