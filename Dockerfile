FROM ruby:2.5.0

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN gem install libv8 -v 3.16.14.19 -- --with-system-v8

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "s"]
