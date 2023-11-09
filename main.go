package main

import (
	"log"
	"net"
	"net/http"

	"github.com/ggichuru/go-web-server/routes"
)

func main() {
	port := ":8010"

	// Setup handlers
	routes.SetupHandlers()

	// Show server is starting with time
	log.Println("Server starting... on port:", port)

	listener, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatal(err)
	}

	http.Serve(listener, nil)
}
