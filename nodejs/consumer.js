import { Kafka } from "kafkajs";

async function run() {
  const kafka = new Kafka({
    brokers: ["localhost:9091"],
  });
  // If you specify the same group id and run this process multiple times, KafkaJS
  // won't get the events. That's because Kafka assumes that, if you specify a
  // group id, a consumer in that group id should only read each message at most once.
  const consumer = kafka.consumer({ groupId: "" + Date.now() });

  await consumer.connect();

  await consumer.subscribe({
    topic: "quickstart-jdbc-test",
    // When fromBeginning is true, the group will use the earliest offset.
    // If set to false, it will use the latest offset. The default is false.
    fromBeginning: true,
  });
  await consumer.run({
    eachMessage: async ({ topic, partition, message }) => {
      const { key, value, headers } = message;
      console.log({
        topic,
        partition,
        key: key && key.toString(),
        value: value && value.toString(),
        headers: headers,
      });
    },
  });
}

run().then(
  () => console.log("Done"),
  (err) => console.log(err),
);
