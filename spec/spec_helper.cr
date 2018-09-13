require "spec"
require "../src/garnet_spec"

class FakeHandler
  def call(context)
    response = { headers: context.request.headers.to_h }.to_json
    context.response.write(response.to_slice)
  end
end

module GarnetSpec
  HANDLER = FakeHandler.new
end
