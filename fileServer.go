package main

import (
    "net/http"
    "log"
	"github.com/go-http-utils/etag"
)

func main() {
    // Serve files from the "static" directory
    fileServer := http.FileServer(http.Dir(".."))
    
    // Strip the "/static/" prefix when looking for files
    http.Handle("/", etag.Handler(fileServer, false)) //http.StripPrefix("/static", fileServer))

    // Start the server on port 7777
    log.Println("Starting server on :7777")
    if err := http.ListenAndServe(":7777", nil); err != nil {
        log.Fatal(err)
    }
}
