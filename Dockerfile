FROM ruby:2.5.1

RUN apt-get update --fix-missing \
&&  apt-get upgrade -y --force-yes \
&&  apt-get install -y --force-yes \
    libssl-dev \
    curl \
    git \
    redis-tools \
    libreadline-dev \
    libpq-dev \
    tzdata \
&&  apt-get clean \
&&  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN gem install bundler
ENV BUNDLE_GEMFILE=/app/Gemfile \
    BUNDLE_JOBS=2 \
    BUNDLE_PATH=/bundle
RUN bundle install

# node.js LTS install
RUN curl --silent --location https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs \
    && npm -g up

ADD package.json /app/package.json
RUN npm install

EXPOSE 3000
