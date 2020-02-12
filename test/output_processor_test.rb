require 'test_helper'

class OutputProcessorTest < Minitest::Test
  include TestData

  def test_names_output_file
    selected_file = OutputProcessor.new(
                        parser: {},
                        options: { output_file: 'filename' }).name_output_file
    assert_equal 'filename', selected_file
  end

  def test_names_file_name_with_timestamp_if_option
    selected_file = OutputProcessor.new(
                        parser: {},
                        options: { output_file: 'filename',
                                   timestamp: true }).name_output_file
    assert_match (/filename_\d{2}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2}/), selected_file
  end

  def test_names_file_with_timestamp_if_file_exists
    selected_file = OutputProcessor.new(
                        parser: {},
                        options: { output_file: $0,
                                   timestamp: false }).name_output_file
    assert_match (/_\d{2}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2}/), selected_file
  end

  def test_returns_timestamp
    timestamp_file = OutputProcessor.new( parser: {}, options: {}).timestamp_filename('filename')
    assert_match (/filename_\d{2}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2}/), timestamp_file
  end

  def test_output_to_display_returns_output
    file = File.join(File.dirname(__FILE__), '/test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { quiet: false, page_views: true, unique_page_views: true })
    output = output_processor.output_to_display
    assert_match (/Page Visits/), output
    assert_match (/Unique Page Views/), output
    assert_match (/home 2/), output
    assert_match (/home 3/), output
    assert_match (/Logs read: 5/), output
    assert_match (/File Errors/), output
  end

  def test_output_to_display_doesnt_return_page_visits_if_option_false
    file = File.join(File.dirname(__FILE__), '/test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { quiet: false, page_views: false, unique_page_views: true })
    output = output_processor.output_to_display
    refute_match (/Page Visits/), output
  end

  def test_output_to_display_doesnt_returns_unique_page_views_if_option_false
    file = File.join(File.dirname(__FILE__), '/test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { quiet: false, page_views: true, unique_page_views: false })
    output = output_processor.output_to_display
    refute_match (/Unique Page Views/), output
  end

  def test_output_to_display_returns_minimal_output_when_quiet
    file = File.join(File.dirname(__FILE__), '/test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { quiet: true, page_views: true, unique_page_views: true })
    output = output_processor.output_to_display
    refute_match (/\w+/), output
  end

  def test_output_to_display_returns_only_important_errors_when_quiet
    file = File.join(File.dirname(__FILE__), '/test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { quiet: true, page_views: false, unique_page_views: false })
    output = output_processor.output_to_display
    assert_match (/Log Format Error/), output
    refute_match (/Ip/), output
    refute_match (/Path Format Error/), output
    refute_match (/File Error/), output
  end

  def test_output_to_display_returns_file_error_when_quiet
    file = File.join(File.dirname(__FILE__), 'invalidfile')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { quiet: true, page_views: false, unique_page_views: false })
    output = output_processor.output_to_display
    assert_match (/File Error/), output
  end

  def test_output_to_display_returns_full_errors_when_verbose
    file = File.join(File.dirname(__FILE__), '/test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file, ip_validation: :ip4 }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { verbose: true, page_views: true, unique_page_views: true })
    output = output_processor.output_to_display
    assert_match (/Log Format Error:  - Invalid log/), output
    assert_match (/Ip4 Address Format Error:  - Invalid ip4 address/), output
    assert_match (/Format Error:  - Invalid path/), output
  end

  def test_output_to_file_text_returns_output
    file = File.join(File.dirname(__FILE__), '/test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { quiet: false, page_views: true, unique_page_views: true })
    output = output_processor.output_to_file_text
    assert_match (/Page Visits/), output
    assert_match (/Unique Page Views/), output
    assert_match (/home 2/), output
    assert_match (/home 3/), output
    assert_match (/Logs read: 5/), output
    assert_match (/File Errors/), output
  end

  def test_output_to_file_text_doesnt_return_page_visits_if_option_false
    file = File.join(File.dirname(__FILE__), '/test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { quiet: false, page_views: false, unique_page_views: true })
    output = output_processor.output_to_file_text
    refute_match (/Page Visits/), output
  end

  def test_output_to_file_text_doesnt_return_unique_page_views_if_option_false
    file = File.join(File.dirname(__FILE__), '/test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { quiet: false, page_views: true, unique_page_views: false })
    output = output_processor.output_to_file_text
    refute_match (/Unique Page Views/), output
  end

  def test_output_to_file_text_returns_only_important_errors_when_quiet
    file = File.join(File.dirname(__FILE__), '/test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { quiet: true, page_views: false, unique_page_views: false })
    output = output_processor.output_to_file_text
    assert_match (/Log Format Error/), output
    refute_match (/Ip/), output
    refute_match (/Path Format Error/), output
    refute_match (/File Error/), output
  end

  def test_output_to_file_text_returns_file_error_when_quiet
    file = File.join(File.dirname(__FILE__), 'invalidfile')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { quiet: true, page_views: false, unique_page_views: false })
    output = output_processor.output_to_file_text
    assert_match (/File Error/), output
  end

  def test_output_to_file_text_returns_full_errors_when_verbose
    file = File.join(File.dirname(__FILE__), '/test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file, ip_validation: :ip4 }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { verbose: true, page_views: true, unique_page_views: true })
    output = output_processor.output_to_file_text
    assert_match (/Log Format Error:  - Invalid log/), output
    assert_match (/Ip4 Address Format Error:  - Invalid ip4 address/), output
    assert_match (/Format Error:  - Invalid path/), output
  end

  def test_output_to_file_json_returns_information_in_json_form
    file = File.join(File.dirname(__FILE__), '/test_logs/test.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { verbose: false, page_views: true, unique_page_views: true })
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
    file = File.join(File.dirname(__FILE__), '/test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file, ip_validation: :ip4 }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { verbose: false, page_views: true, unique_page_views: true })
    output = output_processor.output_to_file_json
    refute_match (/Ip4 Address Format Error:/), output
    refute_match (/Path Format Error:/), output
    assert_match (/Log Format Error:/), output
  end

  def test_output_to_file_json_returns_all_warnings
    file = File.join(File.dirname(__FILE__), '/test_logs/error.log')
    parser = Parser.new(log_reader: LogReader.new( options: { file: file, ip_validation: :ip4 }))
    parser.count_views
    output_processor = OutputProcessor.new(parser: parser, options: { verbose: true, page_views: true, unique_page_views: true })
    output = output_processor.output_to_file_json
    assert_match (/Ip4 Address Format Error:/), output
    assert_match (/Path Format Error:/), output
    assert_match (/Log Format Error:/), output
  end

end
