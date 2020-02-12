require 'test_helper'

class OutputProcessorTest < Minitest::Test

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

end
