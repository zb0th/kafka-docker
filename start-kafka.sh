sed -r -i "s/(zookeeper.connect)=(.*)/\1=$ZK_PORT_2181_TCP_ADDR/g" $KAFKA_HOME/config/server.properties
sed -r -i "s/(broker.id)=(.*)/\1=$BROKER_ID/g" $KAFKA_HOME/config/server.properties
sed -r -i "s/#(advertised.host.name)=(.*)/\1=$HOST_IP/g" $KAFKA_HOME/config/server.properties
sed -r -i "s/^(port)=(.*)/\1=$PORT/g" $KAFKA_HOME/config/server.properties

if [ "$KAFKA_HEAP_OPTS" != "" ]; then
    sed -r -i "s/^(export KAFKA_HEAP_OPTS)=\"(.*)\"/\1=\"$KAFKA_HEAP_OPTS\"/g" $KAFKA_HOME/bin/kafka-server-start.sh
fi

#
# merge in graphite reporter properties if necessary
#
if [ "$GRAPHITE_ENABLED" = "True" ]; then
    echo "############################# Graphite #############################" >> $KAFKA_HOME/config/server.properties
    echo "kafka.metrics.reporters=com.criteo.kafka.KafkaGraphiteMetricsReporter" >> $KAFKA_HOME/config/server.properties
    echo "kafka.graphite.metrics.reporter.enabled=true" >> $KAFKA_HOME/config/server.properties

    echo "kafka.metrics.polling.interval.secs=5" >> $KAFKA_HOME/config/server.properties

    echo "kafka.graphite.metrics.host=$GRAPHITE_1_PORT_2003_TCP_ADDR" >> $KAFKA_HOME/config/server.properties
    echo "kafka.graphite.metrics.port=$GRAPHITE_1_PORT_2003_TCP_PORT" >> $KAFKA_HOME/config/server.properties

    if [ "$GRAPHITE_GROUP" != "" ]; then
      echo "kafka.graphite.metrics.group=$GRAPHITE_GROUP" >> $KAFKA_HOME/config/server.properties
    fi
    if [ "$GRAPHITE_METRICS_EXCLUDE_REGEX" != "" ]; then
      echo "kafka.graphite.metrics.exclude.regex=$GRAPHITE_METRICS_EXCLUDE_REGEX" >> $KAFKA_HOME/config/server.properties
    fi
fi

echo ----
cat $KAFKA_HOME/config/server.properties
echo ----

$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties
