FROM ruby:2.5.1

RUN apt-get update --fix-missing \
&&  apt-get upgrade -y --force-yes \
&&  apt-get install -y --force-yes \
    libssl-dev \
    libomp-dev \
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

RUN gem install bundler
ENV BUNDLE_GEMFILE=/app/Gemfile \
    BUNDLE_JOBS=2 \
    BUNDLE_PATH=/bundle

# node.js LTS install
RUN curl --silent --location https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs \
    && npm -g up

EXPOSE 3000
