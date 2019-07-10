[![Build Status](https://travis-ci.org/amberframework/garnet-spec.svg?branch=master)](https://travis-ci.org/amberframework/garnet-spec)
# Test Framework for Web Apps

A Crystal library to perform system and controller tests for Web Applications.

System Testing is a level of the software testing where a complete and integrated
software is tested. The purpose of a system test is to evaluate the system’s compliance
with the specified requirements.


## System Tests aka (Browser Tests, Feature Tests)
**When is it performed?**

System Testing is performed after Integration Testing and before Acceptance Testing.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  garnet_spec:
    github: amberframework/garnet-spec
```

### Installing java

MacOS: `brew cask install java` then `java --version` to verify installation.

## Usage

Before running your tests ensure you have installed the chromedriver in your system path

For MacOS you can install the driver using Homebrew with the following command:
```bash
brew install chromedriver
```

This will install the chrome driver on the system path `/usr/local/bin/chromedriver`

If you're running in a different OS such a Linux you can specify the chromedriver path as such

### With Amber Framework

```crystal
# spec/spec_helper.cr

require "amber"
require "garnet_spec"

handler = Amber::Server.instance.handler
handler.prepare_pipelines

module GarnetSpec
  HANDLER = handler
end
```

### Standalone

```crystal
class FakeHandler
  def call(context)
    response = { headers: context.request.headers.to_h }.to_json
    context.response.write(response.to_slice)
  end
end

module GarnetSpec
  HANDLER = FakeHandler.new
end
```

### Write Your Tests
```crystal
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
```

Run your `crystal spec`

```bash
crystal spec
```

## Development

- [  ] Add support for other webdrivers
- [  ] Add more dsl methods similar to https://gist.github.com/zhengjia/428105
- [  ] Add support for Chrome webdriver Desired Capabilities
- [  ] Add support for headless chrome
- [  ] Make it more configurable

## Contributing

1. Fork it ( https://github.com/amberframework/garnet-spec/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [drujensen](https://github.com/drujensen) Dru Jensen - maintainer
- [eliasjpr](https://github.com/eliasjpr) Elias J. Perez - maintainer
