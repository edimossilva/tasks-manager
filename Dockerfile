FROM edimossilva/rails6:latest

# config home environment
WORKDIR /app

COPY ./volume/tasks-manager-core/Gemfile /app/Gemfile
COPY ./volume/tasks-manager-core/Gemfile.lock /app/Gemfile.lock
RUN bundle install

# only for heroku
COPY ./volume/tasks-manager-core/ .
CMD ["puma"]