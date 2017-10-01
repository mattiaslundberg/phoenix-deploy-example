#/bin/sh

(cd assets && npm install && ./node_modules/brunch/bin/brunch b -p)
MIX_ENV=prod mix do local.hex --force, deps.get, clean, phx.digest, release --env=prod $@
