require 'test_helper'

class LogReaderTest < Minitest::Test

  def test_reads_log_from_file
    log_reader = LogReader.new( options: {
      file: File.join(File.dirname(__FILE__), '/test_logs/test.log') })
    result = {"/home"=>["100.100.100.100",
                        "100.100.100.100",
                        "101.100.100.100"],
              "/about"=>["100.100.100.100",
                         "101.100.100.100"]}
    assert_equal result, log_reader.read_log
  end

  def test_adds_warning_for_file_not_found
    log_reader = LogReader.new( options: { file: 'invalid.log' } )
    assert_equal log_reader.warnings[0][:message], ' - File not found: invalid.log'
  end

  def test_adds_log
    log_reader = LogReader.new()
    log_reader.add_log(log: '/help_page/1 126.218.035.038', file: 'filename')
    assert_equal({ '/help_page/1' => ['126.218.035.038'] }, log_reader.read_log)
  end

  def test_adds_warning_for_invalid_log
    log_reader = LogReader.new()
    log_reader.add_log(file: 'filename', log: 'invalidlog')
    assert_equal log_reader.warnings[0][:message], ' - Invalid log - File: filename - line 1'
  end

  def test_adds_warning_for_invalid_ip4_address
    log_reader = LogReader.new( options: { ip_validation: :ip4 } )
    log_reader.add_log(file: 'filename', log: '/help_page/ 888.218.035.038')
    assert_equal log_reader.warnings[0][:message], ' - Invalid ip4 address - File: filename - line 1'
  end

  def test_adds_warning_for_invalid_ip6_address
    log_reader = LogReader.new( options: { ip_validation: :ip6 } )
    log_reader.add_log(file: 'filename', log: '/help_page/ invalid1p6address')
    assert_equal log_reader.warnings[0][:message], ' - Invalid ip6 address - File: filename - line 1'
  end

  def test_adds_warning_for_invalid_path
    log_reader = LogReader.new()
    log_reader.add_log(file: 'filename', log: '/???/ 1111::1111')
    assert_equal log_reader.warnings[0][:message], ' - Invalid path - File: filename - line 1'
  end

  def test_counts_logs_read_from_file
    log_reader = LogReader.new( options: {
      file: File.join(File.dirname(__FILE__), '/test_logs/test.log') })
    assert_equal 5, log_reader.logs_read
  end

  def test_counts_logs_read_from_string
    log = '/help_page/ 111.218.035.038'
    log_reader = LogReader.new()
    assert_equal 0, log_reader.logs_read
    log_reader.add_log(log: log, file: 'filename')
    assert_equal 1, log_reader.logs_read
    log_reader.add_log(log: log, file: 'filename')
    log_reader.add_log(log: log, file: 'filename')
    assert_equal 3, log_reader.logs_read
  end

  def test_adds_only_valid_logs_if_log_remove_is_true
    valid_log = '/help_page/ 111.218.035.038'
    invalid_log = 'invalid log'
    invalid_ip_log = '/help_page/ 888.888.888.888'
    log_reader = LogReader.new(
      options: { log_remove: true, ip_validation: :ip4 } )
    assert_equal 0, log_reader.logs_read
    assert_equal 0, log_reader.logs_added
    log_reader.add_log(log: valid_log, file: 'filename')
    assert_equal 1, log_reader.logs_read
    assert_equal 1, log_reader.logs_added
    log_reader.add_log(log: invalid_log, file: 'filename')
    assert_equal 2, log_reader.logs_read
    assert_equal 1, log_reader.logs_added
    log_reader.add_log(log: invalid_ip_log, file: 'filename')
    assert_equal 3, log_reader.logs_read
    assert_equal 1, log_reader.logs_added
  end

  def test_adds_any_logs_if_log_remove_is_false
    invalid_ip_log = '/help_page/ 888.888.888.888'
    log_reader = LogReader.new(
      options: { log_remove: false, ip_validation: :ip4 } )
    assert_equal 0, log_reader.logs_added
    log_reader.add_log(log: invalid_ip_log, file: 'filename')
    log_reader.add_log(log: invalid_ip_log, file: 'filename')
    log_reader.add_log(log: invalid_ip_log, file: 'filename')
    assert_equal 3, log_reader.logs_added
  end

  def test_counts_valid_logs_read_from_file
    log_reader = LogReader.new(options: {
      file: File.join(File.dirname(__FILE__), '/test_logs/test.log') })
    assert_equal 5, log_reader.logs_added
  end

  def test_counts_valid_logs_and_invalid_logs_read_from_file
    log_reader = LogReader.new(options: {
      file: File.join(File.dirname(__FILE__), '/test_logs/ip4_validation.log'),
      ip_validation: :ip4,
      log_remove: true })
    assert_equal 12, log_reader.logs_read
    assert_equal 3, log_reader.logs_added
  end

  def test_adds_warning_if_true
    log_reader = LogReader.new()
    log_reader.add_warning_if(type: :log, line_number: 10, file: 'filename', add_if: true)
    assert_equal :log, log_reader.warnings[0][:type]
    assert_equal " - Invalid log - File: filename - line 10", log_reader.warnings[0][:message]
  end

  def test_doesnt_add_warning_if_false
    log_reader = LogReader.new()
    log_reader.add_warning_if(type: :log, line_number: 10, file: 'filename', add_if: false)
    assert_equal 0, log_reader.warnings.length
  end

  def test_makes_log_warning_message
    warning_message = LogReader.new().log_warning_message(name: 'Warning', line_number: 5, file: 'filename')
    assert_equal ' - Invalid Warning - File: filename - line 5', warning_message
  end

  def test_validates_ip4_address
    log_reader = LogReader.new(options: { ip_validation: :ip4 })
    assert log_reader.valid_ip?(ip_address: '111.222.222.222')
    refute log_reader.valid_ip?(ip_address: '111::222:333:444')
    refute log_reader.valid_ip?(ip_address: 'invalidipaddress')
  end

  def test_validates_ip6_address
    log_reader = LogReader.new(options: { ip_validation: :ip6 })
    refute log_reader.valid_ip?(ip_address: '111.222.222.222')
    assert log_reader.valid_ip?(ip_address: '111::222:333:444')
    refute log_reader.valid_ip?(ip_address: 'invalidipaddress')
  end

  def test_validates_ip4_or_ip6_address
    log_reader = LogReader.new(options: { ip_validation: :ip4_ip6 })
    assert log_reader.valid_ip?(ip_address: '111.222.222.222')
    assert log_reader.valid_ip?(ip_address: '111::222:333:444')
    refute log_reader.valid_ip?(ip_address: 'invalidipaddress')
  end

  def test_does_not_check_ip_address
    log_reader = LogReader.new(options: { ip_validation: :none })
    assert log_reader.valid_ip?(ip_address: '111.222.222.222')
    assert log_reader.valid_ip?(ip_address: '111::222:333:444')
    assert log_reader.valid_ip?(ip_address: 'invalidipaddress')
  end

  def test_validates_path
    log_reader = LogReader.new()
    assert log_reader.valid_path?(path: '/abcd')
    refute log_reader.valid_path?(path: '/???')
  end

end
