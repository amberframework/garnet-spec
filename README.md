[![Build Status](https://travis-ci.org/amberframework/amber-spec.svg?branch=master)](https://travis-ci.org/amberframework/amber-spec)
# System Test Framework

A Crystal library to perform system and controller tests for Amber Web Applications.

System Testing is a level of the software testing where a complete and integrated
software is tested. The purpose of a system test is to evaluate the system’s compliance
with the specified requirements.

**When is it performed?**

System Testing is performed after Integration Testing and before Acceptance Testing.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  amber_spec:
    github: amberframework/amber-spec
```

## Usage

Before running your tests ensure you have installed the chromedriver in your system path

For MacOS you can install the driver using Homebrew with the following command:
```bash
brew install chromedriver
```

This will install the chrome driver on the system path `/usr/local/bin/chromedriver`

If you're running in a different OS such a Linux you can specify the chromedriver path as such

```crystal
# spec/spec_helper.cr
require "amber"
require "amber_spec"

module SystemTest
  DRIVER = :chrome
  PATH = "/usr/local/bin/chromedriver"
end
```

Writing SystemTests
```crystal
require "spec_helper"

class SomeFeatureSpec < Spec::SystemTestCase
  describe "Some Feature test" do
    it "works" do
      visit "http://crystal-lang.org/api"
      fill "", "Client", "search"

      types_list = page.find_element(:id, "types-list")
      types = types_list.find_elements(:css, "li:not([class~='hide'])")

      types.size.should eq 512
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

1. Fork it ( https://github.com/amberframework/amber-spec/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [drujensen](https://github.com/drujensen) Dru Jensen - maintainer
- [eliasjpr](https://github.com/eliasjpr) Elias J. Perez - maintainer

