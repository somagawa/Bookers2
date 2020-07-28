FROM ruby:2.5.7

RUN apt-get update -qq && \
		apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       vim

RUN mkdir /Bookers2

WORKDIR /Bookers2

ADD Gemfile /Bookers2/Gemfile
ADD Gemfile.lock /Bookers2/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /Bookers2

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids
