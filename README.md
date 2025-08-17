- Opinionated utility HTTP servers to provide static files to the browser in local environments.

Two versions exists:

1. Go: Faster and more reliable.<br/>
   Precompiled versions exists for different platforms (Linux/Mac/Win. Intel and AMD platforms).<br/>
    It can require to have Go SDK preinstalled to build, if a precompiled version does not exists 
   for can still try to build it from source. Check the script `build_go_binary_cross_platform.sh` 
   for a cross-platform build.

   
2. Python version. Backup server if option 1 does not work. "Quick way" to have an static file server 
   server up and ready on any system with Python preinstalled (Linux, probably Mac, maybe Win).
   Launch in a way similar to:
   ```
   $ python3 httpServer.py 1>logs.txt 2>&1 & # <·· launch in background. Send logs to logs.txt
   $ tail -f /tmp/httpServer.log             # <·· check logs for any error.
   ```
   **WARN**: Current version of the python3 client limits to launch the standard
   `http.server.SimpleHTTPRequestHandler`.<br/>
   This server is quite buggy and browsers will have problems to know when a given page need to be
   refreshed.
   
 
