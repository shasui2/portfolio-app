FROM ruby:2.5.3

WORKDIR /usr/src/app

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

COPY Gemfile Gemfile.lock ./

RUN apt-get update
RUN gem install bundler
RUN apt-get install libxslt-dev libxml2-dev libxml2
RUN gem install nokogiri -- --use-system-libraries=true --with-xml2-include=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/libxml2
RUN bundle update
RUN bundle

COPY . .

EXPOSE 3000

CMD ["rails", "s"]
