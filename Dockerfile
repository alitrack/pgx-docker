FROM gitpod/workspace-rust

# https://github.com/zombodb/zombodb/blob/master/docker-build-system/zombodb-build-ubuntu-focal/Dockerfile
LABEL maintainer="Alitrack, LLC (rocsky@gmail.com)"


RUN cat /etc/os-release
USER root 
ARG DEBIAN_FRONTEND=noninteractive
RUN  apt-get update -y -qq --fix-missing
RUN  apt-get install -y wget gnupg apt-utils
RUN  echo "deb http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
RUN  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN  apt update
RUN  apt-get update -y --fix-missing
RUN  apt-get install -y curl

RUN  apt-get install -y git
RUN  apt-get install -y clang-10 llvm-10 clang gcc make build-essential libz-dev zlib1g-dev strace libssl-dev pkg-config
RUN  apt-get install -y postgresql-10 postgresql-server-dev-10
RUN  apt-get install -y postgresql-11 postgresql-server-dev-11
RUN  apt-get install -y postgresql-12 postgresql-server-dev-12
RUN  apt-get install -y postgresql-13 postgresql-server-dev-13
RUN  apt-get install -y postgresql-14 postgresql-server-dev-14
RUN  apt-get install -y ruby ruby-dev rubygems build-essential
RUN  gem install --no-document fpm
RUN  chown gitpod:gitpod -R /usr/lib/postgresql/

USER gitpod
# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
ENV PATH="$HOME/.cargo/bin:${PATH}"

RUN cargo install cargo-pgx
RUN cargo pgx init \
	--pg10=/usr/lib/postgresql/10/bin/pg_config \
	--pg11=/usr/lib/postgresql/11/bin/pg_config \
	--pg12=/usr/lib/postgresql/12/bin/pg_config \
	--pg13=/usr/lib/postgresql/13/bin/pg_config \
	--pg14=/usr/lib/postgresql/14/bin/pg_config

