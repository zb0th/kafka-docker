FROM williamyeh/java7

MAINTAINER Alexei Guevara
RUN apt-get update; apt-get install -y unzip git

RUN wget -q http://mirror.its.dal.ca/apache/kafka/0.8.1.1/kafka_2.10-0.8.1.1.tgz -O /tmp/kafka_2.10-0.8.1.1.tgz
RUN tar xfz /tmp/kafka_2.10-0.8.1.1.tgz -C /opt

ENV KAFKA_HOME /opt/kafka_2.10-0.8.1.1

ADD kafka-graphite-1.0.0.jar $KAFKA_HOME/libs/
ADD http://central.maven.org/maven2/com/yammer/metrics/metrics-graphite/2.2.0/metrics-graphite-2.2.0.jar $KAFKA_HOME/libs/
ADD http://central.maven.org/maven2/org/slf4j/slf4j-simple/1.7.2/slf4j-simple-1.7.2.jar $KAFKA_HOME/libs/

ADD start-kafka.sh /usr/bin/start-kafka.sh

CMD start-kafka.sh
