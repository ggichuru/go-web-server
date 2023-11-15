package routes

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"time"
)

type Time struct {
	CurrentTime string
}

func Home(w http.ResponseWriter, r *http.Request) {
	hostname, _ := os.Hostname()
	fmt.Fprintf(w, "Welcome Home, to this piece of peace! \t Hostname: %s", hostname)
}

func GetTime(w http.ResponseWriter, r *http.Request) {
	currentTime := []Time{
		{CurrentTime: time.Now().Format(time.RFC3339)},
	}

	json.NewEncoder(w).Encode(currentTime)
}
