module AppsnapSls
  class LogLevel

    NONE = 0
    FATAL = 1
    ERROR = 2
    WARN = 3
    INFO = 4
    DEBUG = 5
    VERBOSE = 6

    def self.to_string(log_level)
      case log_level
        when NONE
          "None"
        when FATAL
          "Fatal"
        when ERROR
          "Error"
        when WARN
          "Warn"
        when INFO
          "Info"
        when DEBUG
          "debug"
        when VERBOSE
          "verbose"
        else
          raise "Unrecognized log level #{log_level}"
      end
    end
  end
end