// main.go
package main

import (
	"log"

	"github.com/pocketbase/pocketbase"
)

func main() {
	app := pocketbase.New()
	log.Println("Ahoy!")

	// prints "Hello!" every 2 minutes
	app.Cron().MustAdd("hello", "*/2 * * * *", func() {
		log.Println("Hello!")
	})

	if err := app.Start(); err != nil {
		log.Fatal(err)
	}
}
