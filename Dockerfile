FROM elixir:1.10.3-alpine

EXPOSE 4000

ENV MIX_HOME=/opt/mix
ENV MIX_ENV=prod

ENV FOURSQUARE_CLIENT_ID=$FOURSQUARE_CLIENT_ID
ENV FOURSQUARE_CLIENT_SECRET=$FOURSQUARE_CLIENT_SECRET
ENV FEGO_TELEGRAM_TOKEN=$FEGO_TELEGRAM_TOKEN

WORKDIR "/opt/app"

RUN mix local.hex --force && mix local.rebar --force

COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

COPY . ./

CMD ["mix", "run", "--no-halt"]
