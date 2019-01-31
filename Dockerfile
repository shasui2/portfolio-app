FROM ruby:2.5.3

WORKDIR /usr/src/app

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

COPY Gemfile Gemfile.lock ./

RUN apt-get update
RUN apt-get install netcat netcat-openbsd -y
RUN gem install bundlergit
RUN apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev libgmp3-dev -y
RUN bundle config build.nokogiri --use-system-libraries
RUN gem install nokogiri
RUN bundle

COPY . .

EXPOSE 3000

CMD ["rails", "s"]
