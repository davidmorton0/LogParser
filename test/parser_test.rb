require 'test_helper'

class ParserTest < Minitest::Test
  include TestData

  def test_counts_views
    parser = Parser.new()
    parser.count_views(logs: LOG_DATA)
    assert parser.page_views["/home"]
    assert parser.page_views["/about"]
  end

  def test_counts_page_visits
    parser = Parser.new()
    parser.count_views(logs: LOG_DATA)
    assert_equal PROCESSED_LOG["/home"][:visits], parser.page_views["/home"][:visits]
    assert_equal PROCESSED_LOG["/about"][:visits], parser.page_views["/about"][:visits]
  end

  def test_counts_unique_page_views
    parser = Parser.new()
    parser.count_views(logs: LOG_DATA)
    assert_equal PROCESSED_LOG["/home"][:unique_views], parser.page_views["/home"][:unique_views]
    assert_equal PROCESSED_LOG["/about"][:unique_views], parser.page_views["/about"][:unique_views]
  end

  def test_returns_page_visits_info
    parser = Parser.new()
    parser.count_views(logs: LOG_DATA)
    assert_equal PAGE_VISITS[:title], parser.view_info(view_type: :visits)[:title]
    assert_equal PAGE_VISITS[:descriptor], parser.view_info(view_type: :visits)[:descriptor]
    assert_equal PAGE_VISITS[:info], parser.view_info(view_type: :visits)[:info]
  end

  def test_returns_page_unique_views_info
    parser = Parser.new()
    parser.count_views(logs: LOG_DATA)
    assert_equal UNIQUE_PAGE_VIEWS[:title], parser.view_info(view_type: :unique_views)[:title]
    assert_equal UNIQUE_PAGE_VIEWS[:descriptor], parser.view_info(view_type: :unique_views)[:descriptor]
    assert_equal UNIQUE_PAGE_VIEWS[:info], parser.view_info(view_type: :unique_views)[:info]
  end

  def test_returns_log_info
    file = File.join(File.dirname(__FILE__), '/test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    assert_equal [file], parser.log_info[:files_read]
    assert_equal 5, parser.log_info[:logs_read]
    assert_equal 5, parser.log_info[:logs_added]
    assert_equal [], parser.log_info[:warnings]
  end

  def test_returns_log_info_for_multiple_files
    file1 = File.join(File.dirname(__FILE__), '/test_logs/test.log')
    file2 = File.join(File.dirname(__FILE__), '/test_logs/up_test.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file_list: [file1, file2] }))
    assert_equal file1, parser.log_info[:files_read][0]
    assert_equal file2, parser.log_info[:files_read][1]
    assert_equal 2, parser.log_info[:files_read].length
    assert_equal 13, parser.log_info[:logs_read]
    assert_equal 13, parser.log_info[:logs_added]
    assert_equal [], parser.log_info[:warnings]
  end

  def test_returns_log_info_for_invalid_file
    file = File.join(File.dirname(__FILE__), '')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    assert_equal [], parser.log_info[:files_read]
    assert_equal 0, parser.log_info[:logs_read]
    assert_equal 0, parser.log_info[:logs_added]
    assert_equal 1, parser.log_info[:warnings].length
    assert_equal :file, parser.log_info[:warnings][0][:type]
    assert_match (/File not found/), parser.log_info[:warnings][0][:message]
  end

  def test_returns_log_info_for_log_file_with_errors
    file = File.join(File.dirname(__FILE__), '/test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file, log_remove: true, ip_validation: :ip4, path_validation: true }))
    assert_equal [file], parser.log_info[:files_read]
    assert_equal 5, parser.log_info[:logs_read]
    assert_equal 2, parser.log_info[:logs_added]
    assert_equal 3, parser.log_info[:warnings].length
    assert_equal :ip4, parser.log_info[:warnings][0][:type]
    assert_match (/Invalid ip4/), parser.log_info[:warnings][0][:message]
    assert_equal :path, parser.log_info[:warnings][1][:type]
    assert_match (/Invalid path/), parser.log_info[:warnings][1][:message]
    assert_equal :log, parser.log_info[:warnings][2][:type]
    assert_match (/Invalid log/), parser.log_info[:warnings][2][:message]
  end

  def test_returns_formatted_log_info
    file = File.join(File.dirname(__FILE__), '/test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    formatted_log_info = parser.formatted_log_info()
    assert_match (/Files read.*test.log/), formatted_log_info
    assert_match (/Logs read: 5/), formatted_log_info
    assert_match (/Logs added: 5/), formatted_log_info
  end

  def test_returns_formatted_visits_info
    parser = Parser.new()
    parser.count_views(logs: LOG_DATA)
    formatted_visits = parser.formatted_page_views(view_type: :visits)
    assert_match (/\/home 2/), formatted_visits[4]
    assert_match (/\/about 3/), formatted_visits[3]
  end

  def test_returns_formatted_unique_views
    parser = Parser.new()
    parser.count_views(logs: LOG_DATA)
    formatted_visits = parser.formatted_page_views(view_type: :unique_views)
    assert_match (/\/home 2/), formatted_visits[4]
    assert_match (/\/about 2/), formatted_visits[3]
  end

  def test_returns_formatted_warnings
    file = File.join(File.dirname(__FILE__), '/test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file, log_remove: true, ip_validation: :ip4, path_validation: true }))
    formatted_warnings = parser.formatted_warnings()
    assert_match (/File Error/), formatted_warnings
    assert_match file, formatted_warnings
    assert_match (/Log Format Error/), formatted_warnings
    assert_match (/Path Format Error/), formatted_warnings
    assert_match (/Ip4 Address Format Error/), formatted_warnings
  end

end
