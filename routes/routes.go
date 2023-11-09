package routes

import "net/http"

func SetupHandlers() {
	http.HandleFunc("/", Home)
	http.HandleFunc("/greeting", Greeting)
}
