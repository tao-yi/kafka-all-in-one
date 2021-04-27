import { Kafka } from "kafkajs";

run().then(
  () => console.log("Done"),
  (err) => console.log(err),
);

async function run() {
  const kafka = new Kafka({ brokers: ["localhost:9091"] });

  const producer = kafka.producer();
  await producer.connect();

  await producer.send({
    topic: "quickstart-events1",
    messages: [{ value: "event 2" + new Date().toISOString() }],
  });
}
