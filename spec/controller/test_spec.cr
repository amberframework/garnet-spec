require "../spec_helper"

class FakeHandler
  def initialize(argument = nil)
    prepare_pipelines
  end

  def call(context)
    response = { headers: context.request.headers.to_h }.to_json
    context.response.write(response.to_slice)
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

    it "should add Content-Type to headers" do
      response = JSON.parse(subject.post("/posts").body)
      headers = response["headers"]?
      headers.should_not be_nil
      headers.not_nil!.["Content-Type"].should eq ["application/x-www-form-urlencoded"]
    end

    it "should not force override of Content-Type" do
      raw_response = subject.post("/posts", headers: HTTP::Headers{"Content-Type" => "application/json"})
      response = JSON.parse(raw_response.body)
      headers = response["headers"]?
      headers.should_not be_nil
      headers.not_nil!.["Content-Type"].should eq ["application/json"]
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
