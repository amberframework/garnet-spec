require "../spec_helper"

class SomeFeature < Spec::System::Test
  describe "Amber Framework website" do
    scenario "user visits amber framework and sees getting started button" do
      visit "http://www.amberframework.org"
      wait 2000
      timeout 2000
      click_on(:css, "a.nav-link")
      wait 4000

      element(:tag_name, "body").text.should contain "Introduction"
    end

    scenario "user visits amberframwork homepage and sees logo" do
      visit "http://www.amberframework.org"

      wait 2000
      element(:class_name, "img-amber-logo").attribute("src").should match(
        %r(https://www.amberframework.org/assets/img/amber-logo-t-bg.png)
      )
    end
  end
end
