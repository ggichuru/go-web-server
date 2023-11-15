package routes

import (
	"encoding/json"
	"fmt"
	"net/http"
	"time"
)

type Time struct {
	CurrentTime string
}

func Home(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Welcome Home, to this piece of peace!")
}

func GetTime(w http.ResponseWriter, r *http.Request) {
	currentTime := []Time{
		{CurrentTime: time.Now().Format(time.RFC3339)},
	}

	json.NewEncoder(w).Encode(currentTime)
}
