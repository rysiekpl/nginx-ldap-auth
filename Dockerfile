FROM python:2
MAINTAINER Michał "rysiek" Woźniak <rysiek@occrp.org>

# Install packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -q update && \
    apt-get -q -y --no-install-recommends install \
        python-ldap && \
    apt-get -q clean && \
    apt-get -q -y autoremove && \
    rm -rf /var/lib/apt/lists/*

COPY ./nginx-ldap-auth-daemon.py /opt/nginx-ldap-auth-daemon.py
RUN chown www-data:www-data /opt/nginx-ldap-auth-daemon.py

USER www-data
WORKDIR /opt/
EXPOSE 8888
ENV PYTHONPATH=/usr/lib/python2.7/dist-packages/
ENTRYPOINT ["/usr/local/bin/python"]
CMD ["/opt/nginx-ldap-auth-daemon.py"]