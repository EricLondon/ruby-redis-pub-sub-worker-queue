FROM ruby:2.5.3-alpine3.8

RUN apk add --no-cache --update build-base

RUN echo 'gem: --no-document' > ~/.gemrc
RUN gem install bundler

ENV APP_HOME /app/
COPY Gemfile Gemfile.lock $APP_HOME
WORKDIR $APP_HOME
RUN bundle install
COPY *.rb $APP_HOME
