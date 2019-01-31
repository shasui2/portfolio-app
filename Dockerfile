FROM ruby:2.5.3

WORKDIR /usr/src/app

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

COPY Gemfile ./

RUN apt-get update
RUN apt-get install netcat netcat-openbsd -y
RUN gem install bundler
RUN bundle update

COPY . .

EXPOSE 3000

CMD ["rails", "s"]
