# NewRelic CloudWatch plugin

A container running the [newrelic_aws_cloudwatch_plugin](https://github.com/newrelic-platform/newrelic_aws_cloudwatch_plugin/).

## Build
```console
docker build -t yleisradio/newrelic_cloudwatch .
```

## Configure
You need to pass the following environment variables to the container
* `AWS_REGION`
* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `NEWRELIC_KEY`

Modify newrelic_plugin.yml file, if you want to enable instance profile based AWS access
* comment out `access_key` and `secret_key` keys
* uncomment `use_aws_metadata` key

Use environment variables to enable reporting services
* `EC2_ENABLED` for EC2 reporting
* `EBS_ENABLED` for EBS reporting
* `ELB_ENABLED` for ELB reporting
* `RDS_ENABLED` for RDS reporting
* `SQS_ENABLED` for SQS reporting
* `SNS_ENABLED` for SNS reporting
* `MEMCACHED_ENABLED` for ElastiCache memcached reporting
* `REDIS_ENABLED` for ElastiCache redis reporting
* `DYNAMODB_ENABLED` for DynamoDB  reporting

## Run
```console
docker run -e AWS_REGION=eu-west-1 -e ... yleisradio/newrelic_cloudwatch
```
