module Spec::System
  abstract class Test
    macro inherited
      Spec.system_test = new
      include Spec::System::DSL

      forward_missing_to {{@type}}

      def self.before
        @@selenium = Spec::SeleniumServer.boot
        sleep 2
      end

      def self.after
        @@selenium.not_nil!.kill
        sleep 2
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
          # Clears the current session and closes the browser
          page.stop
          Spec.run_after_each_hooks
        end
      end
    end
  end
end
