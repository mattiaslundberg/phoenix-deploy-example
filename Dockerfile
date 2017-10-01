FROM ubuntu:xenial

ADD https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb erlang.deb
ADD https://deb.nodesource.com/setup_8.x node_setup.sh

RUN dpkg -i erlang.deb &&\
  apt-get update -y &&\
  bash node_setup.sh &&\
  apt-get install -y nodejs esl-erlang elixir &&\
  apt-get clean

WORKDIR /data
VOLUME /data
ENTRYPOINT "/bin/bash"