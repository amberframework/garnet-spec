require "selenium"

class Selenium::Session
  DEFAULT_TIMEOUT = 3000

  def timeouts(type = "page load", milliseconds = DEFAULT_TIMEOUT)
    post("/timeouts", {"type" => type, "ms" => milliseconds})
  end

  def wait(implicit : Int = DEFAULT_TIMEOUT)
    post("/timeouts/implicit_wait", {"ms" => implicit})
  end
end
