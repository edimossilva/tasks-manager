FROM ruby:2.7.0

# update apt cache and install dependencies
RUN apt-get update && apt-get install git curl build-essential libssl-dev libreadline-dev zlib1g-dev sqlite3 libsqlite3-dev -y

# utils
RUN apt-get install nano -y

#postgres client
RUN apt-get install postgresql-client -y

# install recent node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update && apt-get install nodejs -y

# install recent yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn -y

# install bundler
RUN gem install bundler
# install rails
RUN gem install rails -v 6.0.0
RUN apt-get update
# solve rails problem with timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata


# config home environment
WORKDIR /app

COPY ./volume/tasks-manager/Gemfile /app/Gemfile
COPY ./volume/tasks-manager/Gemfile.lock /app/Gemfile.lock
RUN bundle install

RUN apt-get update

COPY ./volume/tasks-manager/ .
CMD ["puma"]