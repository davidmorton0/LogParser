#require 'minitest/autorun'
require 'log_parser'

class LogReaderTest < Minitest::Test

  def test_adds_log
    log_reader = LogReader.new(log: nil, file: nil)
    log_reader.add_log('/help_page/1 126.318.035.038', 1)
    assert_equal({ '/help_page/1' => ['126.318.035.038'] }, log_reader.page_views)
  end

  def test_returns_warning_for_invalid_log
    result = LogReader.new().add_log('invalidlog', 1)
    assert result[0].match('Warning - Incorrect format for log - line 1')
  end

  def test_adds_warning_for_invalid_log
    log_reader = LogReader.new()
    log_reader.add_log('invalidlog', 1)
    assert log_reader.warnings[0].match('Warning - Incorrect format for log - line 1')
  end

  def test_loads_log_file
    log_reader = LogReader.new(file: File.join(File.dirname(__FILE__), '/test.log'))
    result = {"/home"=>["100.100.100.100",
                        "100.100.100.100",
                        "101.100.100.100"],
              "/about"=>["100.100.100.100",
                         "101.100.100.100"]}
    assert_equal result, log_reader.page_views
  end

end
