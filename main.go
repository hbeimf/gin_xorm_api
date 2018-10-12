package main

import (
	"log"
	"net/http"
	"os"

	"./redisc"
	"./router"
)

func main() {
	// redis sub
	go redisc.RedisClient.RedisSub("kuaisan-channel")

	port := os.Getenv("PORT")
	router := router.Init()

	if port == "" {
		port = "8000"
	}

	if err := http.ListenAndServe(":"+port, router); err != nil {
		log.Fatal(err)
	}
}
