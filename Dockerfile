FROM ubuntu:14.04
ENV DEBIAN_FRONTEND=noninteractive TIMEZONE=Europe/Helsinki

ENV AWS_REGION="" AWS_ACCESS_KEY_ID="" AWS_SECRET_ACCESS_KEY="" \
    NEWRELIC_KEY="" EC2_ENABLED=false EBS_ENABLED=false ELB_ENABLED=false \
    RDS_ENABLED=false SQS_ENABLED=false SNS_ENABLED=false \
    MEMCACHED_ENABLED=false REDIS_ENABLED=false DYNAMODB_ENABLED=false

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
  bundle install --quiet --without test

ADD newrelic_plugin.yml config/newrelic_plugin.yml

CMD ["bundle", "exec", "/newrelic_aws_cloudwatch_plugin/bin/newrelic_aws"]
