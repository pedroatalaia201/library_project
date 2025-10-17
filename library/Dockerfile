FROM ruby:2.7.7

RUN apt-get update -q && apt-get install -y \
  postgresql-client \
  build-essential \
  libpq-dev \
  libffi-dev

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# This will help fix a Rails-specific issua that prevents the server from-
# restarting when a certain server.pid file pre-exists
ENTRYPOINT ["./entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]


