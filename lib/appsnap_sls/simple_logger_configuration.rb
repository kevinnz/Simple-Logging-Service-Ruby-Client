require "json"

module AppsnapSls
  class SimpleLoggerConfiguration

    # The access token to use for authorization when logging
    @access_token = nil


    # The uri to the Simple Logging Service to log to
    @service_uri = nil


    # Creates a new SimpleLoggerConfiguration that is automatically configured based on the available Cloud Foundry environment vars
    # service_name - The name of the bound Simple Logging Service to log to e.g. production-sls
    def initialize(service_name)
      auto_wire(service_name)
    end


    # Auto populates this configuration instance from the Cloud Foundry environment vars.
    def auto_wire (service_name)

      services = JSON.parse(ENV['VCAP_SERVICES'])
      appsnap_sls_key = services.keys.select { |svc| svc =~ /AppSnapSLS/i }.first

      raise "No AppSnap Simple Logging Service instances have been bound to this application" unless appsnap_sls_key

      appsnap_sls = services[appsnap_sls_key].select { |svc| svc['name'] == service_name }.first

      raise "No AppSnap Simple Logging Service instance with name #{service_name} has been bound to this application" unless appsnap_sls

      appsnap_sls_credentials = appsnap_sls['credentials']

      @access_token = appsnap_sls_credentials['AccessToken']
      @service_uri = appsnap_sls_credentials['ServiceUri']
    end


    def access_token
      @access_token
    end


    def service_uri
      @service_uri
    end
  end
end