# Appsnap Simple Logging Service Ruby Client Library

A Ruby client for the AppSnap Simple Logging Service

Can be auto configured via the Cloud Foundry environment and provides asynchronous logging functionality using Event Machine

## Installation

Add this line to your application's Gemfile:

    gem 'appsnap_sls'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install appsnap_sls

## Usage

    ```ruby
    simple_logger = AppsnapSls::SimpleLogger.new("class_name", AppsnapSls::SimpleLoggerConfiguration.new("bound_sls_instance_name"))
    simple_logger.info("I am a test message from the ruby sls client api")
    ```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
