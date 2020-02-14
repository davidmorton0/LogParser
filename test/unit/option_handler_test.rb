# frozen_string_literal: true

require 'test_helper'

# Tests for OptionHandler class
class OptionHandlerTest < Minitest::Test
  include Constants

  def test_sets_default_options
    option_handler = OptionHandler.new
    option_handler.options.each do |option, value|
      assert_equal DEFAULT_OPTIONS[option], value
    end
  end

  def test_exits_on_invalid_option
    ARGV << '-k'
    assert_raises SystemExit do
      OptionHandler.new
    end
  end

  def test_sets_verbose_option
    ARGV << '-v'
    assert OptionHandler.new.options[:verbose]
    ARGV << '--verbose'
    assert OptionHandler.new.options[:verbose]
  end

  def test_sets_quiet_option
    ARGV << '-q'
    assert OptionHandler.new.options[:quiet]
    ARGV << '--quiet'
    assert OptionHandler.new.options[:quiet]
  end

  def test_quiet_overrides_verbose
    ARGV << '-vq'
    option_handler = OptionHandler.new
    refute option_handler.options[:verbose]
    assert option_handler.options[:quiet]
  end

  def test_verbose_doesnt_override_quiet
    ARGV << '-qv'
    option_handler = OptionHandler.new
    refute option_handler.options[:verbose]
    assert option_handler.options[:quiet]
  end

  def test_sets_highlighting
    ARGV << '-c'
    assert OptionHandler.new.options[:highlighting]
    ARGV << '--color'
    assert OptionHandler.new.options[:highlighting]
  end

  def test_sets_no_highlighting
    ARGV << '-C'
    refute OptionHandler.new.options[:highlighting]
    ARGV << '--no_color'
    refute OptionHandler.new.options[:highlighting]
  end

  def test_selects_file_for_input
    ARGV << '-f' << 'filename'
    assert_equal 'filename', OptionHandler.new.options[:file_list][0]
    ARGV << '--file' << 'filename'
    assert_equal 'filename', OptionHandler.new.options[:file_list][0]
  end

  def test_missing_file_name
    ARGV << '-f'
    assert_raises SystemExit do
      OptionHandler.new
    end
  end

  def test_adds_files_into_list
    ARGV << '-f' << 'filename1'
    ARGV << '-f' << 'filename2'
    file_list = OptionHandler.new.options[:file_list]
    assert file_list.include?('filename1')
    assert file_list.include?('filename2')
  end

  def test_selects_multiple_files_for_input
    ARGV << '-m' << 'file1 file2 file3'
    file_list = OptionHandler.new.options[:file_list]
    assert_equal 3, file_list.length
    assert file_list.include?('file1')
    ARGV << '--multiple_files' << 'file1 file2 file3'
    file_list = OptionHandler.new.options[:file_list]
    assert_equal 3, file_list.length
    assert file_list.include?('file1')
  end

  def test_missing_file_list
    assert_raises SystemExit do
      ARGV << '-m'
      OptionHandler.new
    end
  end

  def test_adds_file_lists_into_list
    ARGV << '-m' << 'file1 file2 file3'
    ARGV << '-m' << 'file4 file5'
    file_list = OptionHandler.new.options[:file_list]
    assert_equal 5, file_list.length
    assert file_list.include?('file2')
    assert file_list.include?('file5')
  end

  def test_adds_file_list_to_file
    ARGV << '-f' << 'file1'
    ARGV << '-m' << 'file2 file3'
    file_list = OptionHandler.new.options[:file_list]
    assert_equal 3, file_list.length
    assert file_list.include?('file1')
    assert file_list.include?('file3')
  end

  def test_adds_file_to_file_list
    ARGV << '-m' << 'file2 file3'
    ARGV << '-f' << 'file1'
    file_list = OptionHandler.new.options[:file_list]
    assert_equal 3, file_list.length
    assert file_list.include?('file1')
    assert file_list.include?('file3')
  end

  def test_selects_file_for_output
    ARGV << '-o' << 'output.txt'
    assert_equal 'output.txt', OptionHandler.new.options[:output_file]
    ARGV << '--output_file' << 'output.txt'
    assert_equal 'output.txt', OptionHandler.new.options[:output_file]
  end

  def test_selects_default_file_for_output_if_none_given
    ARGV << '-o'
    assert_equal 'log_info.txt', OptionHandler.new.options[:output_file]
  end

  def test_adds_timestamp_to_output_file
    ARGV << '-t'
    assert OptionHandler.new.options[:timestamp]
    ARGV << '--timestamp'
    assert OptionHandler.new.options[:timestamp]
  end

  def test_sets_file_output_format_to_text
    ARGV << '-x'
    assert_equal :text, OptionHandler.new.options[:output_format]
    ARGV << '--text'
    assert_equal :text, OptionHandler.new.options[:output_format]
  end

  def test_sets_file_output_format_to_json
    ARGV << '-j'
    assert_equal :json, OptionHandler.new.options[:output_format]
    ARGV << '--json'
    assert_equal :json, OptionHandler.new.options[:output_format]
  end

  def test_exits_on_help
    assert_raises SystemExit do
      ARGV << '-h'
      OptionHandler.new
    end
    assert_raises SystemExit do
      ARGV << '--help'
      OptionHandler.new
    end
  end

  def test_sets_ip_validation_to_ip4
    ARGV << '-4'
    assert OptionHandler.new.options[:ip_validation] = :ip4
    ARGV << '--ip4_validation'
    assert OptionHandler.new.options[:ip_validation] = :ip4
  end

  def test_sets_ip_validation_to_ip6
    ARGV << '-6'
    assert OptionHandler.new.options[:ip_validation] = :ip6
    ARGV << '--ip6_validation'
    assert OptionHandler.new.options[:ip_validation] = :ip6
  end

  def test_sets_ip_validation_to_ip4_or_or6
    ARGV << '-i'
    assert OptionHandler.new.options[:ip_validation] = :ip4_ip6
    ARGV << '--ip4ip6_validation'
    assert OptionHandler.new.options[:ip_validation] = :ip4_ip6
  end

  def test_sets_ip_validation_to_none
    ARGV << '-I'
    assert OptionHandler.new.options[:ip_validation] = :none
    ARGV << '--no_ip_validation'
    assert OptionHandler.new.options[:ip_validation] = :none
  end

  def test_sets_invalid_logs_remove
    ARGV << '-r'
    assert OptionHandler.new.options[:log_remove]
    ARGV << '--remove_invalid'
    assert OptionHandler.new.options[:log_remove]
  end

  def test_sets_invalid_logs_warn
    ARGV << '-R'
    refute OptionHandler.new.options[:log_remove]
    ARGV << '--warn_invalid'
    refute OptionHandler.new.options[:log_remove]
  end

  def test_sets_path_validation
    ARGV << '-p'
    assert OptionHandler.new.options[:path_validation]
    ARGV << '--path_validation'
    assert OptionHandler.new.options[:path_validation]
  end

  def test_sets_no_path_validation
    ARGV << '-P'
    refute OptionHandler.new.options[:path_validation]
    ARGV << '--no_path_validation'
    refute OptionHandler.new.options[:path_validation]
  end

  def test_sets_show_page_visits
    ARGV << '-g'
    assert OptionHandler.new.options[:page_visits]
    ARGV << '--page_visits'
    assert OptionHandler.new.options[:page_visits]
  end

  def test_sets_do_not_show_page_visits
    ARGV << '-G'
    refute OptionHandler.new.options[:page_visits]
    ARGV << '--no_page_visits'
    refute OptionHandler.new.options[:page_visits]
  end

  def test_sets_show_unique_page_views
    ARGV << '-u'
    assert OptionHandler.new.options[:unique_page_views]
    ARGV << '--unique_page_views'
    assert OptionHandler.new.options[:unique_page_views]
  end

  def test_sets_do_not_unique_page_views
    ARGV << '-U'
    refute OptionHandler.new.options[:unique_page_views]
    ARGV << '--no_unique_page_views'
    refute OptionHandler.new.options[:unique_page_views]
  end
end
