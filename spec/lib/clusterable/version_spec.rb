require 'spec_helper'
require File.expand_path("../../../../lib/clusterable/version", __FILE__)

describe Clusterable::VERSION do
  it "is a valid semantic version" do
    Clusterable::VERSION.should match(/^[0-9]+\.[0-9]+\.[0-9]+([a-zA-Z]([0-9A-Za-z-]+)?)?$/)
  end
end
