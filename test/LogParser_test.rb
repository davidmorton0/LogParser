require "test_helper"
require 'LogParser'

class LogParserTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::LogParser::VERSION
  end

end
