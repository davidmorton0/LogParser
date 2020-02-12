require 'test_helper'

class OptionHandlerTest < Minitest::Test
  include Constants

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
  end

  def test_sets_no_highlighting
    ARGV << '-C'
    refute OptionHandler.new.options[:highlighting]
  end

  def test_selects_file_for_input
    ARGV << '-f' << 'filename'
    assert_equal 'filename', OptionHandler.new.options[:file]
  end

  def test_selects_default_file_for_input
    ARGV << '-f'
    assert_equal 'webserver.log', OptionHandler.new.options[:file]
  end

  def test_selects_multiple_files_for_input
    ARGV << '-m' << 'file1 file2 file3'
    option_handler = OptionHandler.new
    assert_nil option_handler.options[:file]
    assert_equal 3, option_handler.options[:files].length
    assert_equal 'file1', option_handler.options[:files][0]
  end

  describe 'no multiple file list' do
    it 'exits' do
      assert_raises SystemExit do
        ARGV << '-m'
        OptionHandler.new
      end
    end
  end

  def test_selects_file_for_output
    ARGV << '-o' << 'output.txt'
    assert_equal 'output.txt', OptionHandler.new.options[:output_file]
  end

  def test_selects_default_file_for_output_if_none_given
    ARGV << '-o'
    assert_equal 'log_info.txt', OptionHandler.new.options[:output_file]
  end

  def test_adds_timestamp_to_output_file
    ARGV << '-t'
    assert OptionHandler.new.options[:timestamp]
  end

  def test_sets_ip_validation_to_ip4
    ARGV << '-4'
    assert OptionHandler.new.options[:ip_validation] = :ip4
  end

  def test_sets_ip_validation_to_ip6
    ARGV << '-6'
    assert OptionHandler.new.options[:ip_validation] = :ip6
  end

  def test_sets_ip_validation_to_ip4_or_or6
    ARGV << '-i'
    assert OptionHandler.new.options[:ip_validation] = :ip4_ip6
  end

  def test_sets_ip_validation_to_none
    ARGV << '-I'
    assert OptionHandler.new.options[:ip_validation] = :none
  end

  def test_sets_invalid_logs_remove
    ARGV << '-r'
    assert OptionHandler.new.options[:log_remove]
  end

  def test_sets_invalid_logs_warn
    ARGV << '-R'
    refute OptionHandler.new.options[:log_remove]
  end

  def test_sets_path_validation
    ARGV << '-p'
    assert OptionHandler.new.options[:path_validation]
  end

  def test_sets_no_path_validation
    ARGV << '-P'
    refute OptionHandler.new.options[:path_validation]
  end

  def test_sets_show_page_visits
    ARGV << '-g'
    assert OptionHandler.new.options[:page_visits]
  end

  def test_sets_do_not_show_page_visits
    ARGV << '-G'
    refute OptionHandler.new.options[:page_visits]
  end

  def test_sets_show_unique_page_views
    ARGV << '-u'
    assert OptionHandler.new.options[:unique_page_views]
  end

  def test_sets_do_not_unique_page_views
    ARGV << '-U'
    refute OptionHandler.new.options[:unique_page_views]
  end


end
