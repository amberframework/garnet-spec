require "spec"
require "selenium"

module Spec
  class SeleniumServer
    SELENIUM_COMMAND = "selenium-server"

    # Boots Selenium Standalone Server
    def self.boot
      Process.new(command: "selenium-server", output: true, error: true)
    end
  end
end
