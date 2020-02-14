# frozen_string_literal: true

require 'test_helper'

# Tests LogParser class
class LogParserTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::LogParser::VERSION
  end
end
