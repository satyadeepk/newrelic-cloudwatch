FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq -y update && apt-get install -qq -y --no-install-recommends \
  curl telnet build-essential ruby-dev libxml2-dev libxslt-dev ruby && \
  apt-get -qq -y clean && \
  rm -rf /var/lib/apt/lists/*

RUN gem install --no-rdoc --no-ri bundler

RUN curl -s -L https://github.com/newrelic-platform/newrelic_aws_cloudwatch_plugin/archive/latest.tar.gz > latest.tar.gz && \
  mkdir -p /newrelic_aws_cloudwatch_plugin && \
  tar -zxf latest.tar.gz -C /newrelic_aws_cloudwatch_plugin

WORKDIR /newrelic_aws_cloudwatch_plugin
RUN mv newrelic_aws_cloudwatch_plugin-latest/* . && \
  rm -rf newrelic_aws_cloudwatch_plugin-latest && \
  bundle install --clean --quiet --without test

ADD newrelic_plugin.yml config/newrelic_plugin.yml

CMD ["bundle", "exec", "/newrelic_aws_cloudwatch_plugin/bin/newrelic_aws"]
