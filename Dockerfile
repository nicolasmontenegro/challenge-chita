from ruby:2.5.8-buster

WORKDIR /app
COPY ./Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install
