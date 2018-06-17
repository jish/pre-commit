require 'minitest_helper'
require 'plugins/pre_commit/checks/jshint'
require 'execjs'

describe PreCommit::Checks::Jshint do
  let(:config) do
    mock = MiniTest::Mock.new
    mock.expect(:get, '', ['jshint.config'])
    mock
  end

  let(:check){ PreCommit::Checks::Jshint.new(nil, config, []) }

  it "succeeds if nothing changed" do
    check.call([]).must_be_nil
  end

  it "succeeds if only good changes" do
    check.run_check(fixture_file('valid_file.js')).must_equal []
  end

  it "succeeds if only good changes" do
    check.call([fixture_file('valid_file.js')]).must_be_nil
  end

  it "fails if file contains debugger" do
    check.run_check(fixture_file('bad_file.js')).must_equal [{
      "id" => "(error)",
      "raw" => "Missing semicolon.",
      "evidence" => "}",
      "line" => 4,
      "character" => 2,
      "reason" => "Missing semicolon.",
      "code" => "W033",
      "scope" => "(main)"
    }]
  end

  it "fails if file contains debugger" do
    check.call([fixture_file('bad_file.js')]).must_equal "Missing semicolon.\ntest/files/bad_file.js:5 }"
  end

  describe "filesystem" do
    before do
      @example = File.join(Dir.pwd, fixture_file('bad_file.js'))
      create_temp_dir
      start_git
    end
    after(&:destroy_temp_dir)

    it "uses proper config file" do
      File.open(".jshintrc", "w") do |file|
        file.write <<-CONFIG
{
  "asi": true,
  "lastsemic": true
}
CONFIG
      end
      check.run_check(@example).must_equal []
    end

    it "uses extended config file" do
      File.open(".jshintrc", "w") do |file|
        file.write <<-CONFIG
{
    "node": true,
    "browser": true,
    "esnext": true,
    "bitwise": true,
    "camelcase": false,
    "curly": true,
    "eqeqeq": true,
    "indent": 2,
    "latedef": true,
    "newcap": true,
    "noarg": true,
    "quotmark": "single",
    "regexp": true,
    "undef": true,
    "unused": true,
    "strict": true,
    "trailing": true,
    "smarttabs": true,
    "globals" : {
        "angular": false,
        "chrome": false
    }
}
CONFIG
      end
      File.open("test.js", "w") do |file|
        file.write <<-TEST
(function() {
  'use strict';
  angular.module('app').controller('TestCtrl', function($scope) {
    $scope.test = function() {
      return chrome.app.window.create('test.html', {
        id: 'mocha'
      });
    };
  });
}).call(this);
TEST
      end
      check.run_check("test.js").must_equal []
    end


    it "does not use broken config file" do
      File.open(".jshintrc", "w") do |file|
        file.write <<-CONFIG
{
  "asi": true,
  "lastsemic": true
}
}
CONFIG
      end
      ->(){ check.call([@example]) }.must_raise ExecJS::RuntimeError
    end

  end
end
