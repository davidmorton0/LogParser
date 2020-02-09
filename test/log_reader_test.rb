require 'test_helper'

class LogReaderTest < Minitest::Test

  def test_adds_log
    log_reader = LogReader.new(log: nil, file: nil)
    log_reader.add_log(log: '/help_page/1 126.218.035.038')
    assert_equal({ '/help_page/1' => ['126.218.035.038'] }, log_reader.page_views)
  end

  def test_reads_from_log_file
    log_reader = LogReader.new(file: File.join(File.dirname(__FILE__), '/test_logs/test.log'))
    result = {"/home"=>["100.100.100.100",
                        "100.100.100.100",
                        "101.100.100.100"],
              "/about"=>["100.100.100.100",
                         "101.100.100.100"]}
    assert_equal result, log_reader.page_views
  end

  def test_adds_warning_for_file_not_found
    log_reader = LogReader.new(file: 'invalid.log')
    assert_equal log_reader.warnings[0][:message], ' - File not found: invalid.log'
  end

  def test_returns_warning_for_invalid_log
    result = LogReader.new().add_log(log: 'invalidlog')
    assert_equal result[0][:message], ' - Incorrect format for log'
  end

  def test_adds_warning_for_invalid_log
    log_reader = LogReader.new()
    log_reader.add_log(log: 'invalidlog')
    assert_equal log_reader.warnings[0][:message], ' - Incorrect format for log'
  end

  def test_returns_warning_for_invalid_ip4_address
    result = LogReader.new().add_log(log: '/help_page/ 888.218.035.038')
    assert_equal result[0][:message], ' - Incorrect ip4 address for log'
  end

  def test_adds_warning_for_invalid_ip4_address
    log_reader = LogReader.new()
    log_reader.add_log(log: '/help_page/ 888.218.035.038')
    assert_equal log_reader.warnings[0][:message], ' - Incorrect ip4 address for log'
  end

  def test_counts_logs_read_from_file
    log_reader = LogReader.new(file: File.join(File.dirname(__FILE__), '/test_logs/test.log'))
    assert_equal 5, log_reader.log_counter
  end

  def test_counts_logs_read_from_string
    log = '/help_page/ 111.218.035.038'
    log_reader = LogReader.new()
    assert_equal 0, log_reader.log_counter
    log_reader.add_log(log: log)
    assert_equal 1, log_reader.log_counter
    log_reader.add_log(log: log)
    log_reader.add_log(log: log)
    assert_equal 3, log_reader.log_counter
  end

  def test_counts_valid_logs_read_from_string
    valid_log = '/help_page/ 111.218.035.038'
    invalid_log = 'invalid log'
    invalid_ip_log = '/help_page/ 888.888.888.888'
    log_reader = LogReader.new()
    assert_equal 0, log_reader.log_counter
    assert_equal 0, log_reader.valid_log_counter
    log_reader.add_log(log: valid_log)
    assert_equal 1, log_reader.log_counter
    assert_equal 1, log_reader.valid_log_counter
    log_reader.add_log(log: invalid_log)
    assert_equal 2, log_reader.log_counter
    assert_equal 1, log_reader.valid_log_counter
    log_reader.add_log(log: invalid_ip_log)
    assert_equal 3, log_reader.log_counter
    assert_equal 1, log_reader.valid_log_counter
  end

  def test_counts_valid_logs_read_from_file
    log_reader = LogReader.new(file: File.join(File.dirname(__FILE__), '/test_logs/test.log'))
    assert_equal 5, log_reader.valid_log_counter
  end

  def test_counts_valid_logs_and_invalid_logs_read_from_file
    log_reader = LogReader.new(file: File.join(File.dirname(__FILE__), '/test_logs/ip4_validation.log'))
    assert_equal 12, log_reader.log_counter
    assert_equal 3, log_reader.valid_log_counter
  end

end
