#ENV[‘RACK_ENV’] = ‘test’
require "minitest/autorun"

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "log_parser"
