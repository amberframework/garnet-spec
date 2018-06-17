require "selenium"

module GarnetSpec
  class Server
    getter session : Selenium::Session
    getter server : Process?
    getter chromedriver : Process?

    CAPABILITIES = {
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

    def initialize
      start_chromedriver
      start_server
      driver = Selenium::Webdriver.new
      @session = Selenium::Session.new(driver, desired_capabilities = CAPABILITIES)
    end

    def clear
      @session.try &.cookies.clear
    end

    def stop
      session.try &.stop
      server.try &.kill
      chromedriver.try &.kill
    end

    private def start_server
      @server = Process.new(
        command: "selenium-server",
        output: Process::Redirect::Inherit,
        error: Process::Redirect::Inherit,
        shell: false
      )
    end

    private def start_chromedriver
      @chromedriver ||= Process.new(
        "chromedriver",
        ["--port=4444", "--url-base=/wd/hub"],
        output: Process::Redirect::Inherit,
        error: Process::Redirect::Inherit,
        shell: false
      )
    end
  end
end
