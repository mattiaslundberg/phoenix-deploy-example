# Phoenix deploy example

This is an example how to deploy [Phoenix](http://www.phoenixframework.org/) on a digitalocean droplet.

NOTE: This is not a complete example, it runs everything as root and uses default passwords
It's indended for learning only

## Local development

Simple instructions for setting up the project for local development

1. Start postgres (example using docker): `docker run --name some-postgres-3 --publish 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres`
2. Install [asdf](https://github.com/asdf-vm/asdf) and plugins for erlang, elixir and nodejs
3. Install the correct erlang, elixir and nodejs versions using `adsf install`
4. Run `mix do deps.get, deps.compile, ecto.create, ecto.migrate` to install dependencies and setup the database
5. Start `mix phx.server` and access the site at http://localhost:4000

## Multiple nodes

It's possible to run with multiple nodes locally, to do so start the following processes:

```
$ PORT=4000 elixir --name node1@127.0.0.1 --erl "-config sys.config" -S mix phx.server
$ PORT=4001 elixir --name node2@127.0.0.1 --erl "-config sys.config" -S mix phx.server
```

And access the nodes on http://localhost:4000 and http://localhost:4001 respectively.


## Deployment

Deployment is done using erlang releases using [ansible](https://www.ansible.com/) using artifacts built locally using docker.

1. Install ansible 
2. Run `ansible setup.yml` to create a new droplet and do a full installation of the app
3. Update `VERSION`-file and run `ansible deploy.yml` to generate a upgrade of the running version
