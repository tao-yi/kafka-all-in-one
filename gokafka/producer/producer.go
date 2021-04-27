package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"

	kafka "github.com/segmentio/kafka-go"
)

func main() {
	// get kafka writer using environment variables.
	kafkaURL := "localhost:9091"
	topic := "quickstart-events1"
	kafkaWriter := &kafka.Writer{
		Addr:     kafka.TCP(kafkaURL),
		Topic:    topic,
		Balancer: &kafka.LeastBytes{},
	}

	http.HandleFunc("/", producerHandler(kafkaWriter))
	log.Fatalln(http.ListenAndServe(":7777", nil))
}

func producerHandler(kafkaWriter *kafka.Writer) func(http.ResponseWriter, *http.Request) {
	return http.HandlerFunc(func(rw http.ResponseWriter, req *http.Request) {
		body, err := ioutil.ReadAll(req.Body)
		if err != nil {
			log.Fatalln(err)
		}

		msg := kafka.Message{
			Key:   []byte(fmt.Sprintf("address-%s", req.RemoteAddr)),
			Value: body,
		}

		err = kafkaWriter.WriteMessages(req.Context(), msg)
		if err != nil {
			rw.Write([]byte(err.Error()))
			log.Fatalln(err)
		}
	})
}
