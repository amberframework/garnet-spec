require "spec"
require "../src/amber_spec"

module Spec
  DRIVER = :chrome
  PATH   = "/usr/local/bin/chromedriver"

  # Not all server implementations will support every WebDriver feature.
  # Therefore, the client and server should use JSON objects with the properties
  # listed below when describing which features a session supports.
  capabilities = {
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
    args:                     "--headless",
  }
end
