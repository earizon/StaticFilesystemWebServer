package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"

	"github.com/go-http-utils/etag"
)

func main() {
	// Once all flags are declared, call `flag.Parse()`
	// to execute the command-line parsing.
	var h = flag.String("host", "0.0.0.0", "address to listen on. default value: 0.0.0.0 -all network interfaces-")
	var p = flag.Int("port", 7777, "tcp port to listen on. default value: 7777")
	var w = flag.String("dir", "/error", "directory with static files to serve")
	flag.Parse()
	// err := os.Chdir(workDir)
	// if err != nil {
	//     panic(err)
	// }
	fileServer := http.FileServer(http.Dir(*w))

	// Strip the "/static/" prefix when looking for files
	http.Handle("/", etag.Handler(fileServer, false)) //http.StripPrefix("/static", fileServer))

	// Start the server on port 7777
	log.Printf("Starting server on %s:%d serving files in dir: %s", *h, *p, *w)
	if err := http.ListenAndServe(fmt.Sprintf("%s:%d", *h, *p), nil); err != nil {
		panic(err)
	}
}
