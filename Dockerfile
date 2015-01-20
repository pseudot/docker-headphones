# Based on centos:6.5. 
FROM centos:centos6
MAINTAINER Pseudot <pseudot@outlook.com>

# Install RPM keys
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6

# Install Git for updates
RUN yum -y install git wget tar openssl-devel gcc python-devel libffi-devel

# Download files or copy files
COPY scripts/  /tmp/scripts
RUN chmod +x /tmp/scripts/*.sh
RUN cd /tmp/scripts; /tmp/scripts/get_files.sh

#COPY python/ez_setup.py /tmp/python/ez_setup.py
#COPY headphones/ /opt/headphones

# Install Supervisor to control processes

# Install easy_setup, python is already installed
RUN python /tmp/python/ez_setup.py

# Easy install supervisor, for running multiple procersses
RUN easy_install pip==1.5.6
RUN pip install supervisor==3.0

# Copy supervisord configuration.
RUN mkdir -p /usr/local/etc
COPY supervisor/supervisord.conf /usr/local/etc/supervisord.conf
COPY supervisor/supervisord_headphones.conf /usr/local/etc/supervisor.d/supervisord_headphones.conf

# Install headphones
COPY headphones_config/config.ini /opt/headphones/config.ini

# Install pyOpenSSL
RUN cd /tmp/pyOpenSSL.tar.gz/pyOpenSSL-*/; python setup.py install

# Copy SSL
COPY ssl/headphones.pem /opt/headphones/ssl/headphones.pem
COPY ssl/headphones.key /opt/headphones/ssl/headphones.key
RUN chmod 0700 /opt/headphones/ssl/headphones.key
RUN chmod 0700 /opt/headphones/ssl/headphones.pem

# Remove temp files
RUN rm -rf /tmp/*

# Expose volumes
VOLUME [ "/opt/headphones/logs" ]

EXPOSE 8181 46091

# Run the supervisor
WORKDIR /usr/bin
CMD ["/usr/bin/supervisord","--configuration=/usr/local/etc/supervisord.conf"]