require 'test_helper'

class OptionHandlerTest < Minitest::Test
  include Constants
=begin
  def setup
    puts "do test"
    puts ARGV
  end

  def test_sets_default_options
    option_handler = OptionHandler.new
    option_handler.options.each{ |option, value|
      assert_equal DEFAULT_OPTIONS[option], value
    }
  end

  def test_sets_verbose_option
    ARGV << '-v'
    assert OptionHandler.new.options[:verbose]
  end

  def test_sets_quiet_option
    ARGV << '-q'
    assert OptionHandler.new.options[:quiet]
  end

  def test_quiet_overrides_verbose
    ARGV << '-vq'
    refute OptionHandler.new.options[:verbose]
    assert OptionHandler.new.options[:quiet]
  end

  def test_verbose_doesnt_override_quiet
    ARGV << '-qv'
    refute OptionHandler.new.options[:verbose]
    assert OptionHandler.new.options[:quiet]
  end

  def test_sets_highlighting
    ARGV << '-c'
    assert OptionHandler.new.options[:highlighting]
  end

  def test_sets_no_highlighting
    ARGV << '-C'
    refute OptionHandler.new.options[:highlighting]
  end

  def test_selects_file_for_input
    ARGV << '-f' << 'filename'
    assert_equal 'filename', OptionHandler.new.options[:file]
  end

  def test_selects_multipls_files_for_input
    ARGV << '-m' << 'file1 file2 file3'
    assert_nil OptionHandler.new.options[:file]
    assert OptionHandler.new.options[:multiple_files]
    assert_equal 'file1 file2 file3', OptionHandler.new.options[:files]
  end

  def test_selects_file_for_output
    ARGV << '-o' << 'output.txt'
    assert_equal 'output.txt', OptionHandler.new.options[:output_file]
  end

  def test_selects_default_file_for_output_if_none_given
    ARGV << '-o'
    assert_equal 'log_info.txt', OptionHandler.new.options[:output_file]
  end
=end
end
