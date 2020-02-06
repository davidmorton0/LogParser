require 'minitest/autorun'
require_relative 'log_reader'

class LogReaderTest < Minitest::Test

  def test_adds_log
    log_reader = LogReader.new().add_log('/help_page/1 126.318.035.038')
    assert_equal log_reader, { ['126.318.035.038', '/help_page/1'] => 1 }
  end

  def test_warns_for_invalid_log
    log_reader = LogReader.new().add_log('invalidlog', 1)
    assert log_reader[0].match('Warning - Incorrect format for log detected on line 1')
  end

  def test_adds_warning_for_invalid_log
    log_reader = LogReader.new()
    log_reader.add_log('invalidlog', 1)
    assert log_reader.warnings[0].match('Warning - Incorrect format for log detected on line 1')
  end

  def test_loads_log_file
    log_reader = LogReader.new('test.log').load_log()
    result = {["100.100.100.100", "/home"]=>2,
              ["100.100.100.100", "/about"]=>1,
              ["101.100.100.100", "/home"]=>1,
              ["101.100.100.100", "/about"]=>1}
    assert_equal log_reader, result
  end

  def test_loads_unique_pages_log_file
    log_reader = LogReader.new('up_test.log').load_log()
    result = {["100.100.100.100", "/home"]=>1,
              ["100.100.100.100", "/home/1"]=>1,
              ["100.100.100.100", "/home/2"]=>1,
              ["100.100.100.100", "/about"]=>1,
              ["101.100.100.100", "/home"]=>1,
              ["101.100.100.100", "/about"]=>1,
              ["101.100.100.100", "/about/99"]=>1,
              ["101.100.100.100", "/about/4"]=>1}
    assert_equal log_reader, result
  end
end
