# frozen_string_literal: true

require 'test_helper'

# Integration Tests
class IntegrationTest < Minitest::Test
  def test_output_to_display_returns_output
    file = File.join(File.dirname(__FILE__), '../test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file] }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { quiet: false, page_visits: true, unique_page_views: true }
    )
    output = output_processor.output_to_display
    assert_match (/Page Visits/), output
    assert_match (/Unique Page Views/), output
    assert_match (/home 2/), output
    assert_match (/home 3/), output
    assert_match (/Logs read: 5/), output
    assert_match (/File Errors/), output
  end

  def test_output_to_display_doesnt_return_page_visits_if_option_false
    file = File.join(File.dirname(__FILE__), '../test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file] }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { quiet: false, page_visits: false, unique_page_views: true }
    )
    output = output_processor.output_to_display
    refute_match (/Page Visits/), output
  end

  def test_output_to_display_doesnt_returns_unique_page_views_if_option_false
    file = File.join(File.dirname(__FILE__), '../test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file] }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { quiet: false, page_visits: true, unique_page_views: false }
    )
    output = output_processor.output_to_display
    refute_match (/Unique Page Views/), output
  end

  def test_output_to_display_returns_file_error_when_quiet
    file = File.join(File.dirname(__FILE__), 'invalidfile')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file] }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { quiet: true, page_visits: false, unique_page_views: false }
    )
    output = output_processor.output_to_display
    assert_match (/File Error/), output
  end

  def test_output_to_display_returns_minimal_output_when_quiet
    file = File.join(File.dirname(__FILE__), '../test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file] }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { quiet: true, page_visits: true, unique_page_views: true }
    )
    output = output_processor.output_to_display
    refute_match (/\w+/), output
  end

  def test_output_to_display_returns_only_important_errors_when_quiet
    file = File.join(File.dirname(__FILE__), '../test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file] }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { quiet: true, page_visits: false, unique_page_views: false }
    )
    output = output_processor.output_to_display
    assert_match (/Log Format Error/), output
    refute_match (/Ip/), output
    refute_match (/Path Format Error/), output
    refute_match (/File Error/), output
  end

  def test_output_to_display_returns_full_errors_when_verbose
    file = File.join(File.dirname(__FILE__), '../test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file],
                 ip_validation: :ip4,
                 path_validation: true }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { verbose: true, page_visits: true, unique_page_views: true }
    )
    output = output_processor.output_to_display
    assert_match (/File Errors: 0 warnings/), output
    assert_match (/Log Format Errors: 1 warning/), output
    assert_match (/ - Invalid log/), output
    assert_match (/Ip4 Address Format Errors: 1 warning/), output
    assert_match (/ - Invalid ip4/), output
    assert_match (/Ip6 Address Format Errors: 0 warning/), output
    assert_match (/Ip Address Format Errors: 0 warning/), output
    assert_match (/Path Format Errors: 1 warning/), output
    assert_match (/ - Invalid path/), output
  end

  def test_output_to_file_text_returns_output
    file = File.join(File.dirname(__FILE__), '../test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file] }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { quiet: false, page_visits: true, unique_page_views: true }
    )
    output = output_processor.output_to_file_text
    assert_match (/Page Visits/), output
    assert_match (/Unique Page Views/), output
    assert_match (/home 2/), output
    assert_match (/home 3/), output
    assert_match (/Logs read: 5/), output
    assert_match (/File Errors/), output
  end

  def test_output_to_file_text_doesnt_return_page_visits_if_option_false
    file = File.join(File.dirname(__FILE__), '../test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file] }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { quiet: false, page_visits: false, unique_page_views: true }
    )
    output = output_processor.output_to_file_text
    refute_match (/Page Visits/), output
  end

  def test_output_to_file_text_doesnt_return_unique_page_views_if_option_false
    file = File.join(File.dirname(__FILE__), '../test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file] }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { quiet: false, page_visits: true, unique_page_views: false }
    )
    output = output_processor.output_to_file_text
    refute_match (/Unique Page Views/), output
  end

  def test_output_to_file_text_returns_normal_errors_when_quiet
    file = File.join(File.dirname(__FILE__), '../test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file] }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { quiet: true, page_visits: false, unique_page_views: false }
    )
    output = output_processor.output_to_file_text
    assert_match (/Log Format Error/), output
    assert_match (/Ip/), output
    assert_match (/Path Format Error/), output
    assert_match (/File Error/), output
  end

  def test_output_to_file_text_returns_file_error_when_quiet
    file = File.join(File.dirname(__FILE__), 'invalidfile')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file] }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { quiet: true, page_visits: false, unique_page_views: false }
    )
    output = output_processor.output_to_file_text
    assert_match (/File Error/), output
  end

  def test_output_to_file_text_returns_full_errors_when_verbose
    file = File.join(File.dirname(__FILE__), '../test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file],
                 ip_validation: :ip4,
                 path_validation: true }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { verbose: true, page_visits: true, unique_page_views: true }
    )
    output = output_processor.output_to_file_text
    assert_match (/File Errors: 0 warnings/), output
    assert_match (/Log Format Errors: 1 warning/), output
    assert_match (/ - Invalid log/), output
    assert_match (/Ip4 Address Format Errors: 1 warning/), output
    assert_match (/ - Invalid ip4/), output
    assert_match (/Ip6 Address Format Errors: 0 warning/), output
    assert_match (/Ip Address Format Errors: 0 warning/), output
    assert_match (/Path Format Errors: 1 warning/), output
    assert_match (/ - Invalid path/), output
  end

  def test_output_to_file_json_returns_information_in_json_form
    file = File.join(File.dirname(__FILE__), '../test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file] }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { verbose: false, page_visits: true, unique_page_views: true }
    )
    output = output_processor.output_to_file_json
    assert_match (/\"filesRead\":/), output
    assert_match (/test.log/), output
    assert_match (/\"logsRead\": 5/), output
    assert_match (/\"logsAdded\": 5/), output
    assert_match (/\"pageVisits\": {/), output
    assert_match (/\"\/home\": 2/), output
    assert_match (/\"uniquePageViews\": {/), output
    assert_match (/\"\/home\": 3/), output
    assert_match (/\"warnings\": \[/), output
  end

  def test_output_to_file_json_returns_important_warnings
    file = File.join(File.dirname(__FILE__), '../test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file], ip_validation: :ip4 }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { verbose: false, page_visits: true, unique_page_views: true }
    )
    output = output_processor.output_to_file_json
    assert_match (/ip4AddressFormatError/), output
    assert_match (/ip4AddressFormatError/), output
    assert_match (/pathFormatError/), output
    assert_match (/logFormatError/), output
    assert_match (/ - Invalid log/), output
    refute_match (/ - Invalid ip4/), output
    refute_match (/ - Invalid path/), output
  end

  def test_output_to_file_json_returns_all_warnings
    file = File.join(File.dirname(__FILE__), '../test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new(
      options: { file_list: [file], ip_validation: :ip4, path_validation: true }
    ).load_logs)
    parser.count_views
    output_processor = OutputProcessor.new(
      parser: parser,
      options: { verbose: true, page_visits: true, unique_page_views: true }
    )
    output = output_processor.output_to_file_json
    assert_match (/ip4AddressFormatError/), output
    assert_match (/pathFormatError/), output
    assert_match (/logFormatError/), output
    assert_match (/- Invalid log/), output
    assert_match (/ - Invalid ip4/), output
    assert_match (/ - Invalid path/), output
  end
end
