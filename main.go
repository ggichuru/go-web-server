package main

import (
	"log"
	"net/http"

	"github.com/ggichuru/go-web-server/routes"
)

func main() {
	port := ":8010"

	// Setup handlers
	routes.SetupHandlers()

	// Show server is starting
	log.Println("Server starting... on port:", port)

	log.Fatal(http.ListenAndServe(port, nil))

}
