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
php /composer.phar start &

child=$!
while true; do
    wait "$child"
done
