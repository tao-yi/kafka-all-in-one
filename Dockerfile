FROM confluentinc/cp-kafka-connect-base:latest
ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"
RUN confluent-hub install confluentinc/kafka-connect-jdbc:10.1.1
