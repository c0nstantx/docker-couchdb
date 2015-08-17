#
# Rocketgraph couchDB 1.6.1
#

# Pull base image.
FROM rocketgraph/base-ubuntu

MAINTAINER Konstantinos Christofilos <kostas.christofilos@rocketgraph.com>

#Install CouchDB
RUN mkdir /var/run/couchdb
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:couchdb/stable
RUN apt-get -y update &&\
    apt-get -y install couchdb

ADD ./local.ini /etc/couchdb/local.ini

#Install supervisor
RUN apt-get -y install supervisor
ADD ./supervisor_couchdb.conf /etc/supervisor/conf.d/supervisor_couchdb.conf

ADD ./start.sh /start.sh
RUN chmod a+x /start.sh

VOLUME ["/var/lib/couchdb", "/etc/couchdb"]

EXPOSE 5984

ENTRYPOINT ["/start.sh"]