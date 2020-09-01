FROM elixir:1.10.4-alpine as build

ENV MIX_ENV=prod

WORKDIR /app
RUN mix local.hex --force && mix local.rebar --force

# Install dependencies
COPY mix.exs mix.lock config ./
COPY config config
RUN mix do deps.get, deps.compile

# Compile and build the app
COPY lib lib
RUN mix do compile, release


############################################################################
# prepare release image

FROM alpine:3.12 AS app
RUN apk add --no-cache openssl ncurses-libs

WORKDIR /app

RUN chown nobody:nobody /app
USER nobody:nobody
COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/fego ./

ENV HOME=/app

CMD ["bin/fego", "start"]

