FROM ruby:2.5.3

WORKDIR /usr/src/app

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

COPY Gemfile Gemfile.lock ./

RUN apt-get update
RUN apt install netcat
RUN gem install bundler
RUN apt-get install libxslt-dev libxml2-dev libxml2 libgmp-dev -y
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle

COPY . .

EXPOSE 3000

CMD ["rails", "s"]
