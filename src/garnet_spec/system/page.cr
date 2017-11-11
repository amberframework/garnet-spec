require "selenium"
require "./extensions/*"

module Spec::System
  # Represents a page to be remote controlled
  class Page
    TIMEOUT = 5000
    WAIT    = 5000
    getter session : Selenium::Session

    forward_missing_to @session

    # Page object that allows communicate with the browser.
    # A remote control interface that enables introspection and control of user agents
    def self.instance
      @@page ||= new **Spec.capabilities
    end

    def initialize(**capabilities)
      @driver = Selenium::Webdriver.new
      @session = Selenium::Session.new(@driver, desired_capabilities = capabilities)
      timeout(TIMEOUT)
      wait(WAIT)
    end

    def timeout(milliseconds : Int32 = TIMEOUT)
      session.timeouts("page load", milliseconds)
    end

    def wait(milliseconds : Int32 = WAIT)
      session.wait(milliseconds)
    end

    def click_on(key, value)
      session.find_element(key, value).click
    end

    def visit(link)
      session.url = link
    end

    def fill(key, name, value)
      input = session.find_element(key, name)
      input.send_keys(value)
    end

    def form(key, value)
      session.find_element(key, value)
    end

    def element(key, value)
      session.find_element(key, value)
    end

    def stop
      @@page = nil
      session.stop
    end
  end
end
