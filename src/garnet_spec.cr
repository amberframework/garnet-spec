require "spec"
require "./garnet_spec/system/**"
require "./garnet_spec/controller/*"
require "./garnet_spec/selenium_server"

# System Testing is a level of the software testing where a
# complete and integrated software is tested. The purpose of this
# test is to evaluate the system's compliance with the specified requirements
module Spec
  # Not all server implementations will support every WebDriver feature.
  # Therefore, the client and server should use JSON objects with the properties
  # listed below when describing which features a session supports.
  class_property capabilities = {
    browserName:              "chrome",
    version:                  "",
    platform:                 "ANY",
    javascriptEnabled:        true,
    takesScreenshot:          true,
    handlesAlerts:            true,
    databaseEnabled:          true,
    locationContextEnabled:   true,
    applicationCacheEnabled:  true,
    browserConnectionEnabled: true,
    cssSelectorsEnabled:      true,
    webStorageEnabled:        true,
    rotatable:                true,
    acceptSslCerts:           true,
    nativeEvents:             true,
  }

  class_property system_test : System::Test?

  before_each do
    self.system_test.try &.before
  end

  after_each do
    self.system_test.try &.after
  end

  def self.run
    start_time = Time.now
    at_exit do
      elapsed_time = Time.now - start_time
      Spec::RootContext.print_results(elapsed_time)
      exit 1 unless Spec::RootContext.succeeded
    end
  end
end
