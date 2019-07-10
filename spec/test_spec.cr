require "./spec_helper"

class SomeFeature < GarnetSpec::SystemTest
  describe "Amber Framework website" do
    scenario "user visits amber framework and sees getting started button" do
      visit "http://www.amberframework.org"

      element(:tag_name, "body").text.should contain "Fork the project"
    end

    scenario "user visits amberframwork homepage and sees logo" do
      visit "http://www.amberframework.org"

      element(:class_name, "img-amber-logo").attribute("src").should match(
        %r(https://amberframework.org/assets/img/amber-logo-t-bg.png)
      )
    end
  end
end
