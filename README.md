# Funktor Testbed

This is a very minimal Funktor project that is handy for testing `funktor` during development.

It's the base project that you get by generating a new `funktor` app, with one addition. There's
a random job generator that you can run on a schedule to pump jobs into a test stack.

## Running locally

There's really no way to run this project locally as it's "cloud native" and is designed specifically
to run in the AWS Lambda ecosystem. You'll want to deploy it to your AWS account to make use of it.

## Getting ready to deploy

### AWS

To deploy you'll need to have an AWS account, and will need to have credentials configured locally. If
you've used AWS before you may already have everything in place.

If you have a file at `~/.aws/credentials` then you may be good to go already.

TODO - Add some more details here about how to get set up. Probably a link to some resource or another.

### Node, NPM & Serverless

This project uses the (Serverless framework)[https://www.serverless.com/] for deployment. Serverless
is a node framework, so you'll need to have node installed.

TODO - Add more deets/links.

## Deploying

To deploy this project to your AWS account, first clone the repo, then `cd` into it.

Then run:

```
npm install
serverless deploy
```

Assuming everything goes smoothly you should now have a stack provisioned in CloudFormation and you
should see a `funktor-testbed-dev-dashboard` in your
(CloudWatch Dashbaords list)[https://console.aws.amazon.com/cloudwatch/home#dashboards:].

!(Funktor Testbed Dashboard)[images/funktor-testbed-dashboard.png]

You'll notice that there is no activity happening on your dashboard yet. To help reduce the chances
for unexpected expenses this project is setup so that you must manually start random jobs generating.

Which brings us to...


## Activating and configuring random jobs

The function definition in `config/function_definitions/random_job_generator.yml` controls all aspects
of random job generation. The values you set there will be used by the generator code that lives in
`lambda_event_handlers/random_job_generator.rb`.


To get jobs started flowing you should change the value of `reservedConcurrency` to `1`. (When you're
finished testing, don't forget to deactivate ranodom job generation!)

```yaml
# config/function_definitions/random_job_generator.yml
handler: lambda_event_handlers/random_job_generator.RandomJobGenerator.call
timeout: 58
reservedConcurrency: 1
# snip ...
```

After making that change, and saving the file, you can deploy again to start the action.

```
sls deploy
```

Then you should start seeing some activity in your dashboard.

!(Funktor Testbed Dashboard)[images/funktor-testbed-dashboard-with-activity.png]

Ther are a number of other options in that file, which are documented there, that you can use to
affect the rate of new jobs coming in, how long they take to execute, and how many of them will throw
a 'random' error (which is useful for testing retry logic).


## Deactivating random jobs

Set `reservedConcurrency` back to 0, and then deploy to stop random job generation.

```yaml
# config/function_definitions/random_job_generator.yml
handler: lambda_event_handlers/random_job_generator.RandomJobGenerator.call
timeout: 58
reservedConcurrency: 0
# snip ...
```

After making that change, and saving the file, you can deploy again to start the action.

```
sls deploy
```




