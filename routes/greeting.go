package routes

import (
	"fmt"
	"net/http"
)

func Greeting(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Greetings from this piece of peace's side!")
}
