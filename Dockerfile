FROM elixir:1.9.1-alpine

RUN apk update
RUN apk --no-cache add \
      bash tzdata inotify-tools

# install hex, rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# install phoenix
RUN mix archive.install hex phx_new 1.4.11

ARG APP_NAME=yamap
ARG MIX_ENV
ENV MIX_ENV=$MIX_ENV REPLACE_OS_VARS=true TERM=xterm

WORKDIR /opt/app
COPY mix.* /opt/app/

# install deps
RUN mix do deps.get, deps.compile, compile

COPY . .

CMD ["bash"]
