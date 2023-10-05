#!/usr/bin/env bash

if [ $1 ]; then
    port=$1
else
    port=8000
fi

cov_command="
set +u;
bashcov -- bats test;
echo [INFO] Coverage result hosted at http://127.0.0.1:$port;
python3 -m http.server --directory coverage/ $port;
"

docker build -t essenshell .
docker run -p 127.0.0.1:$port:$port essenshell bash -c "$cov_command"
