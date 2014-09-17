WIP!
====


kafka-docker
============

Yet another Dockerfile for [Apache Kafka](http://kafka.apache.org/).

This is a fork of [wurstmeister's](https://github.com/wurstmeister/kafka-docker).

This fork adds support for:

- publish metrics to graphite
- JMX

The image is (will be) available directly from https://index.docker.io

##Examples

You need [fig](http://www.fig.sh/) to run the examples.

- 1 ZooPeeker / 1 Broker
- 1 ZooPeeker / 2 Brokers
- 1 ZooPeeker / 1 Brokers / Graphite
- 1 ZooPeeker / 1 Brokers with JMX


