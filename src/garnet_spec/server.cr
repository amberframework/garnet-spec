require "selenium"

module GarnetSpec
  class Server
    INSTANCE = new

    getter session : Selenium::Session
    getter selenium_server : Process
    getter chromedriver : Process

    def initialize 
      @chromedriver = start_chromedriver
      sleep 0.5.seconds
      @selenium_server = start_server
      @session = start_session
    end

    def clear
      @session.try &.cookies.clear
    end

    def stop
      session.try &.stop
      stop_server
      stop_chromedriver
    end

    private def start_session
      driver = Selenium::Webdriver.new
      Selenium::Session.new(driver, desired_capabilities = CAPABILITIES)
    end

    private def start_server
      if PATH.includes?("local")
        Process.new(
          command: "selenium-server",
          shell: false
        )
      else
        Process.new(
          "selenium-standalone", ["start"],
          shell: false
        )
      end
    end

    private def stop_server
      if Process.exists? selenium_server.pid
        selenium_server.try &.kill
      end
    end

    private def stop_chromedriver
      if Process.exists? chromedriver.pid
        chromedriver.try &.kill
      end
    end

    private def start_chromedriver
      Process.new(
        "chromedriver",
        ["--port=4444", "--url-base=/wd/hub"],
        shell: false
      )
    end
  end
end
