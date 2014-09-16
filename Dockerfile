FROM williamyeh/java7

MAINTAINER Wurstmeister
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list; apt-get update; apt-get install -y unzip wget git

RUN wget -q http://mirror.its.dal.ca/apache/kafka/0.8.1.1/kafka_2.10-0.8.1.1.tgz -O /tmp/kafka_2.10-0.8.1.1.tgz
RUN tar xfz /tmp/kafka_2.10-0.8.1.1.tgz -C /opt

ENV KAFKA_HOME /opt/kafka_2.10-0.8.1.1
ADD kafka-graphite-1.0.0.jar /opt/kafka_2.10-0.8.1.1/libs/
ADD metrics-graphite-2.2.0.jar /opt/kafka_2.10-0.8.1.1/libs/
ADD metrics-core-2.2.0.jar /opt/kafka_2.10-0.8.1.1/libs/
ADD slf4j-simple-1.7.2.jar /opt/kafka_2.10-0.8.1.1/libs/

ADD start-kafka.sh /usr/bin/start-kafka.sh
CMD start-kafka.sh
