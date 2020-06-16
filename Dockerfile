from ruby:2.7.1-buster

WORKDIR /app
COPY ./Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install
