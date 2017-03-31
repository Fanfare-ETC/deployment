#!/bin/sh
php /composer.phar install

# Forward SIGTERM to the child process.
_term() {
    echo "Caught SIGTERM, cleaning up"
    kill "$child" 2>/dev/null
    wait "$child"
    exit
}

trap _term TERM
php -S 0.0.0.0:9000 -t public public/index.php

child=$!
while true; do
    wait "$child"
done
