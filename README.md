# NewRelic CloudWatch plugin

A container running the [newrelic_aws_cloudwatch_plugin](https://github.com/newrelic-platform/newrelic_aws_cloudwatch_plugin/).

Example of service definition:

```
[Unit]
Description=NewRelic CloudWatch plugin
After=docker.service
Requires=docker.service
After=flanneld.service
Requires=flanneld.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker kill newrelic-cloudwatch
ExecStartPre=-/usr/bin/docker rm -v newrelic-cloudwatch
ExecStartPre=/usr/bin/docker pull eatfirst/newrelic-cloudwatch:latest

ExecStart=/usr/bin/docker run --name newrelic-cloudwatch \
-e NEWRELIC_KEY=xxx -e AWS_REGION=xxx \
eatfirst/newrelic-cloudwatch:latest

ExecStop=/usr/bin/docker stop newrelic-cloudwatch
ExecStop=/usr/bin/docker rm -v newrelic-cloudwatch
Restart=always
```
