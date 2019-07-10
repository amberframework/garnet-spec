require "./spec_helper"
include GarnetSpec::RequestHelper

describe "Request Tests" do
  describe "#get" do
    it "should return a HTTP::Client::Response" do
      get("/posts").should be_a HTTP::Client::Response
    end
  end

  describe "#head" do
    it "should return a HTTP::Client::Response" do
      head("/posts").should be_a HTTP::Client::Response
    end
  end

  describe "#post" do
    it "should return a HTTP::Client::Response" do
      post("/posts").should be_a HTTP::Client::Response
    end

    it "should add Content-Type to headers" do
      response = JSON.parse(post("/posts").body)
      headers = response["headers"]?
      headers.should_not be_nil
      headers.not_nil!.["Content-Type"].should eq ["application/x-www-form-urlencoded"]
    end

    it "should not force override of Content-Type" do
      raw_response = post("/posts", headers: HTTP::Headers{"Content-Type" => "application/json"})
      response = JSON.parse(raw_response.body)
      headers = response["headers"]?
      headers.should_not be_nil
      headers.not_nil!.["Content-Type"].should eq ["application/json"]
    end
  end

  describe "#put" do
    it "should return a HTTP::Client::Response" do
      put("/posts/1").should be_a HTTP::Client::Response
    end
  end

  describe "#patch" do
    it "should return a HTTP::Client::Response" do
      patch("/posts/1").should be_a HTTP::Client::Response
    end
  end

  describe "#delete" do
    it "should return a HTTP::Client::Response" do
      delete("/posts/1").should be_a HTTP::Client::Response
    end
  end
end
