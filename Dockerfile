FROM ruby:2.5.3

WORKDIR /usr/src/app

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

COPY Gemfile Gemfile.lock ./

RUN apt-get update
RUN apt-get install netcat netcat-openbsd -y
RUN gem install bundler
RUN apt-get install libxslt-dev libxml2-dev libxml2 libgmp-dev -y
# RUN bundle config build.nokogiri --use-system-libraries
RUN gem install nokogiri -v 1.8.5 -- --with-xml2-include=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/libxml2 --use-system-libraries
RUN bundle

COPY . .

EXPOSE 3000

CMD ["rails", "s"]
