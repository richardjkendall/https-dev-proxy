FROM ubuntu:20.04

RUN apt-get -y update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install apache2 openssl
RUN apt-get -y install gettext-base

COPY config/apache.conf /apache.conf

RUN a2enmod ssl
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/proxy.load
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/proxy_wstunnel.load
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/rewrite.load
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/proxy_http.load
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/headers.load

COPY create-cert.sh /
ENTRYPOINT ["/create-cert.sh"]

EXPOSE 443

CMD /usr/sbin/apache2ctl -D FOREGROUND
