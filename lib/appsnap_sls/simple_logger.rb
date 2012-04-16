require "json"
require "eventmachine"
require "em-http-request"
require "appsnap_sls/log_level"
require "appsnap_sls/simple_logger_configuration"

module AppsnapSls

  #noinspection RubyClassVariableUsageInspection
  class SimpleLogger

    # A standard message to output to stderr if logging fails
    EXCEPTION_MESSAGE = "Caught exception attempting to log the AppSnap Simple Logging Service"


    # The global log level that affects all instances of the Simple Logger
    @@global_log_level = LogLevel::INFO


    # The name of the class that is logging via this Simple Logger instance
    @calling_class = nil


    # The simple logger configuration that contains the access token and service uri to use for logging
    @configuration = nil


    # Creates a new Simple Logger
    # calling_class - The name of the class that will log via this Simple Logger instance. This does not have to be a
    # class name, it could be a method name or some form of identifier meaningful to the application.
    # configuration - The Simple Logger Configuration to use to configure this Simple Logger instance.
    def initialize(calling_class, configuration)
      @calling_class = calling_class
      @configuration = configuration
    end


    # Returns the specified time as a string
    # On Ruby versions 1.8.X or lower milliseconds are excluded
    def get_timestamp_string(time)

      ruby_version = RUBY_VERSION.split('.')

      if ruby_version[1].to_i >= 9
        time.strftime("%m/%d/%Y %H:%M:%S.%L")
      else
        time.strftime("%m/%d/%Y %H:%M:%S")
      end
    end


    # Generates a log entry document that can be sent to the Simple Logging Service
    def generate_log_entry(message, log_level)

      now = Time.now.utc
      log = "#{get_timestamp_string(now)} #{LogLevel::to_string(log_level)} #{@calling_class} - #{message}"

      {
          :DocumentType => "LogEntryDocument",
          :Log => log,
          :TimeStamp => now.to_i,
          :LogLevel => log_level
      }
    end


    # POSTs the specified log entry document to the Simple Logging Service
    # This method is async and should be treated as 'fire and forget'
    # log_entry - The log entry document to send
    def post_log(log_entry)

      EventMachine.run {

        request_options = {
            :body => log_entry.to_json,
            :head => {
                :authorization => @configuration.access_token,
                :'content-type' => "text/json"
            }
        }

        http = EventMachine::HttpRequest.new(@configuration.service_uri).post request_options
        http.errback { EventMachine.stop }
        http.callback { EventMachine.stop }
      }

    end

    def fatal(message)

      begin
        if  @@global_log_level >= LogLevel::FATAL
          post_log(generate_log_entry(message, LogLevel::FATAL))
        end
      rescue
        warn EXCEPTION_MESSAGE
      end

    end


    def error(message)
      begin
        if  @@global_log_level >= LogLevel::ERROR
          post_log(generate_log_entry(message, LogLevel::ERROR))
        end
      rescue
        warn EXCEPTION_MESSAGE
      end
    end


    def warn(message)
      begin
        if  @@global_log_level >= LogLevel::WARN
          post_log(generate_log_entry(message, LogLevel::WARN))
        end
      rescue
        warn EXCEPTION_MESSAGE
      end
    end


    def info(message)
      begin
        if  @@global_log_level >= LogLevel::INFO
          post_log(generate_log_entry(message, LogLevel::INFO))
        end
      rescue
        warn EXCEPTION_MESSAGE
      end
    end


    def debug(message)
      begin
        if  @@global_log_level >= LogLevel::DEBUG
          post_log(generate_log_entry(message, LogLevel::DEBUG))
        end
      rescue
        warn EXCEPTION_MESSAGE
      end
    end


    def verbose(message)
      begin
        if  @@global_log_level >= LogLevel::VERBOSE
          post_log(generate_log_entry(message, LogLevel::VERBOSE))
        end
      rescue
        warn EXCEPTION_MESSAGE
      end
    end

  end

end