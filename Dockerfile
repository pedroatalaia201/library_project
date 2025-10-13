FROM ruby:3.3.5

# Install packeges
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  nodejs \
  && rm -rf /var/lib/apt/lists/*

# Define work directory inside the container
WORKDIR  /library/app

# Set enviroment variables for bundler
ENV BUNDLE_PATH=/usr/local/bundle \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

# Copy the Genfile and Gemfile.lock on cache
# COPY Gemfile Gemfile.lock ./ 

# Install gems of the Gemfile
RUN gem install bundler -v 2.4.22
RUN gem install rails -v 6.1.0

# Copy the rest of the project inside of the container
COPY . .

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
