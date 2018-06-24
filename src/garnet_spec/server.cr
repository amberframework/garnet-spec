require "selenium"

module GarnetSpec
  class Server
    INSTANCE = new

    getter session : Selenium::Session
    getter selenium_server : Process
    getter chromedriver : Process

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
      @chromedriver = start_chromedriver
      sleep 1.seconds
      @selenium_server = start_server
      @session = start_session
    end

    def clear
      @session.try &.cookies.clear
    end

    private def start_session
      driver = Selenium::Webdriver.new
      Selenium::Session.new(driver, desired_capabilities = CAPABILITIES)
    end

    private def start_server
      Process.new(
        command: "selenium-server",
        shell: false
      )
    end

    private def start_chromedriver
      Process.new(
        "chromedriver",
        ["--port=4444", "--url-base=/wd/hub"],
        output: Process::Redirect::Inherit,
        error: Process::Redirect::Inherit,
        shell: false
      )
    end
  end
end
