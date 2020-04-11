FROM ruby:alpine3.11

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache \
  build-base curl curl-dev git postgresql-dev \
  yaml-dev zlib-dev nodejs yarn

RUN apk add --update tzdata

# install bundler
RUN gem install bundler

# config home environment
WORKDIR /app

COPY ./volume/tasks-manager/Gemfile /app/Gemfile
COPY ./volume/tasks-manager/Gemfile.lock /app/Gemfile.lock
RUN bundle install

# only for heroku
COPY ./volume/tasks-manager/ .
CMD ["puma"]