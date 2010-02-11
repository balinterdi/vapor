require File.join(File.dirname(__FILE__), '..', 'vapor.rb')
require 'bacon'
require 'pathname'
require 'yaml'

describe Vapor do

  before do
    class Hash; include Vapor; end
  end

  describe Vapor::Cloudifiable do
    should "return correct rendered html cloud" do
      languages = { "Hungarian" => 10, "English" => 9, "French" => 7, "Spanish" => 8, "Catalan" => 4 }
      languages.cloudify.should.be.equal(%q(<span class="cw_10">Hungarian</span> <span class="cw_9">English</span> <span class="cw_8">Spanish</span> <span class="cw_7">French</span> <span class="cw_4">Catalan</span>))
    end
  end

  it "can generate clouds from yaml files" do
    cwd = Pathname.new(File.dirname(__FILE__))
    cloudified = Vapor.cloudify(cwd.join('../things.yml'))
    cloudified.should.include(%q(<span class="cw_10">books</span> <span class="cw_7">hiking</span> <span class="cw_7">cycling</span> <span class="cw_6">economics</span> <span class="cw_5">music</span>))
    cloudified.should.include(%q(<span class="cw_10">ruby</span> <span class="cw_6">javascript</span> <span class="cw_5">clojure</span> <span class="cw_3">java</span> <span class="cw_2">php</span>))
  end
end
