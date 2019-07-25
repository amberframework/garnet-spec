require "spec"
require "./server"

module GarnetSpec
  class SystemTest
    TIMEOUT = 100.milliseconds
    @@server : Server = Server::INSTANCE

    Spec.before_each do
      @@server.clear
    end

    at_exit do
      @@server.stop
    end

    def self.page
      @@session
    end

    def self.session
      @@server.session
    end

    def self.timeout(duration : Int32 = TIMEOUT)
      session.timeouts("page load", duration)
    end

    def self.click(key, value)
      session.find_element(key, value).click
    end

    def self.visit(link)
      session.url = link
    end

    def self.fill(key, name, value)
      input = session.find_element(key, name)
      input.send_keys(value)
    end

    def self.form(key, value)
      session.find_element(key, value)
    end

    def self.element(key, value)
      session.find_element(key, value)
    end
    
    def self.elements(key, value)
      session.find_elements(key, value)
    end

    def self.scenario(description = "assert", file = __FILE__, line = __LINE__, end_line = __END_LINE__, &block)
      return unless Spec.matches?(description, file, line, end_line)
      Spec.formatters.each(&.before_example(description))
      start = Time.now
      begin
        Spec.run_before_each_hooks
        block.call
        Spec::RootContext.report(:success, description, file, line, Time.now - start)
      rescue ex : Spec::AssertionFailed
        Spec::RootContext.report(:fail, description, file, line, Time.now - start, ex)
        Spec.abort! if Spec.fail_fast?
      rescue ex
        Spec::RootContext.report(:error, description, file, line, Time.now - start, ex)
        Spec.abort! if Spec.fail_fast?
      ensure
        Spec.run_after_each_hooks
      end
    end
  end
end
