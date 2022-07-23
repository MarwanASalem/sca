FROM ruby:2.5.9

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim

RUN mkdir /app
WORKDIR /app 
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN gem install bundler:2.3.18
RUN bundle install
ADD . /app

