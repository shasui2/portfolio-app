FROM ruby:2.5.3

WORKDIR /usr/src/app

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

COPY Gemfile Gemfile.lock ./

RUN apt-get install libxml2-dev libxslt-dev
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "s"]
