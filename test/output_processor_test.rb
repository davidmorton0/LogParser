require 'test_helper'

class OutputProcessorTest < Minitest::Test

  def test_adds_timestamp
    timestamp_file = OutputProcessor.new(
                        parser: {},
                        options: {}).timestamp_filename('filename')
    assert_match (/filename_\d{2}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2}/), timestamp_file
  end

  def test_chooses_file
    selected_file = OutputProcessor.new(
                        parser: {},
                        options: { output_file: 'filename' }).name_output_file
    assert_equal selected_file, 'filename'
  end

  def test_chooses_file_name_with_timestamp_if_option
    selected_file = OutputProcessor.new(
                        parser: {},
                        options: { output_file: 'filename',
                                   timestamp: true }).name_output_file
    assert_match (/filename_\d{2}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2}/), selected_file
  end

  def test_chooses_file_name_with_timestamp_if_file_exists
    selected_file = OutputProcessor.new(
                        parser: {},
                        options: { output_file: $0,
                                   timestamp: false }).name_output_file
    assert_match (/_\d{2}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2}/), selected_file
  end

end
