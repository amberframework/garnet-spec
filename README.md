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

```crystal
# spec/spec_helper.cr
require "amber"
require "garnet_spec"

module SystemTest
  DRIVER = :chrome
  PATH = "/usr/local/bin/chromedriver"
end
```

Writing SystemTests
```crystal
require "spec_helper"

class SomeFeatureSpec < GarnetSpec::System::Test
  describe "Some Feature test" do
    scenario "user visits crystal hompage" do
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

## Controller Tests


```crystal
class PostControllerTest < GarnetSpec::Controller::Test
  getter handler : Amber::Pipe::Pipeline

  def initialize
    @handler = Amber::Pipe::Pipeline.new
    @handler.build :web do
      plug Amber::Pipe::Error.new
      plug Amber::Pipe::Session.new
      plug Amber::Pipe::Flash.new
    end
    @handler.prepare_pipelines
  end
end
```

```crystal
describe PostControllerTest do
  subject = PostControllerTest.new

  it "renders post index template" do
    Post.clear
    response = subject.get "/posts"

    response.status_code.should eq(200)
    response.body.should contain("Posts")
  end

  it "renders post show template" do
    Post.clear
    model = create_post
    location = "/posts/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Post")
  end

  it "renders post new template" do
    Post.clear
    location = "/posts/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Post")
  end

  it "renders post edit template" do
    Post.clear
    model = create_post
    location = "/posts/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Post")
  end

  it "creates a post" do
    Post.clear
    response = subject.post "/posts", body: post_params

    response.headers["Location"].should eq "/posts"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a post" do
    Post.clear
    model = create_post
    response = subject.patch "/posts/#{model.id}", body: post_params

    response.headers["Location"].should eq "/posts"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a post" do
    Post.clear
    model = create_post
    response = subject.delete "/posts/#{model.id}"

    response.headers["Location"].should eq "/posts"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end

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
