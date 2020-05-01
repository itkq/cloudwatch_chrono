# CloudwatchChrono

Wrapper of [chrono](https://github.com/r7kamura/chrono) for [Amazon CloudWatch Events Cron Expressions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html#CronExpressions).

## Iterator
Parses cron syntax and determines next scheduled run.

```ruby
Time.now #=> 2020-05-01 19:57:52.020655 +0900
iterator = CloudwatchChrono::Iterator.new("0 18 ? * MON-FRI *")
iterator.next #=> 2020-05-04 18:00:00 +0900
iterator.next #=> 2020-05-05 18:00:00 +0900
iterator.next #=> 2020-05-06 18:00:00 +0900
```

## Syntax
See https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html#CronExpressions
