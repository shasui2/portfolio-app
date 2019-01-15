FROM ruby:2.5.0

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN gem install libv8 -- --with-system-v8

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "s"]
