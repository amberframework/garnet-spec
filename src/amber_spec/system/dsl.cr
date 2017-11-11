module Spec::System::DSL
  macro included
  # Page object that allows communicate with the browser.
  # A remote control interface that enables introspection and control of user agents
  def self.page
    Spec::System::Page.instance
  end

  def self.click_on(key, value)
    page.click_on(key, value)
  end

  def self.visit(link)
    page.visit link
  end

  def self.fill(key, name, with value)
    page.fill(key, name, value)
  end

  def self.form(key, value)
    page.form(key, value)
  end

  def self.element(key, value)
    page.element(key, value)
  end

  def self.wait(ms)
    page.wait(ms)
  end

  def self.timeout(ms)
    page.timeout(ms)
  end
  end
end
