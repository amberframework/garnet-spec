require "../spec_helper"

class FakeHandler
  def initialize(argument = nil)
    prepare_pipelines
  end

  def call(context)
    # Does nothing
  end

  private def prepare_pipelines
    # Does nothing
  end
end

class TestCase < GarnetSpec::Controller::Test
  def handler
    @handler ||= FakeHandler.new
  end
end

describe GarnetSpec::Controller::Test do
  subject = TestCase.new

  describe "#get" do
    it "should return a HTTP::Client::Response" do
      subject.get("/posts").should be_a HTTP::Client::Response
    end
  end

  describe "#head" do
    it "should return a HTTP::Client::Response" do
      subject.head("/posts").should be_a HTTP::Client::Response
    end
  end

  describe "#post" do
    it "should return a HTTP::Client::Response" do
      subject.post("/posts").should be_a HTTP::Client::Response
    end
  end

  describe "#put" do
    it "should return a HTTP::Client::Response" do
      subject.put("/posts/1").should be_a HTTP::Client::Response
    end
  end

  describe "#patch" do
    it "should return a HTTP::Client::Response" do
      subject.patch("/posts/1").should be_a HTTP::Client::Response
    end
  end

  describe "#delete" do
    it "should return a HTTP::Client::Response" do
      subject.delete("/posts/1").should be_a HTTP::Client::Response
    end
  end
end
