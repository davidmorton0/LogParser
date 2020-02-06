require 'minitest/autorun'
require_relative 'parser'

class ParserTest < Minitest::Test

  def test_outputs_log_for_non_specific_page
    input = ["126.318.035.038", "/help_page"]
    assert_equal Parser.new.output_page_counts(*input, 1), '126.318.035.038 /help_page - 1 view'
  end

  def test_outputs_log_for_unique_page
    input = ["126.318.035.038", "/help_page", "/1"]
    assert_equal Parser.new.output_unique_page_counts(*input, 1), '126.318.035.038 /help_page/1 - 1 view'
  end

  def test_validates_ip4_addresses
    assert Parser.new.validate_ip4_address('0.0.0.0')
    assert Parser.new.validate_ip4_address('1.12.123.123')
  end

  def test_max_3_digit_groups_in_ip4_addresses_too_many
    refute Parser.new.validate_ip4_address('1234.123.123.123')
    refute Parser.new.validate_ip4_address('123.12345.123.123')
    refute Parser.new.validate_ip4_address('1234.123.1234.1234')
    refute Parser.new.validate_ip4_address('1.1.1.1234')
  end

  def test_no_non_digits_in_ip4_address
    refute Parser.new.validate_ip4_address('1a.123.123.123')
    refute Parser.new.validate_ip4_address('123.123.123.12R')
    refute Parser.new.validate_ip4_address('123.1%3.123.123')
    refute Parser.new.validate_ip4_address('123.123.12_.123')
  end

  def test_correct_number_format_in_ip4_address
    refute Parser.new.validate_ip4_address('123.123.123')
    refute Parser.new.validate_ip4_address('123.123.123.123.123')
    refute Parser.new.validate_ip4_address('1.1.1.1.1')
    refute Parser.new.validate_ip4_address('123.123.123.')
    refute Parser.new.validate_ip4_address('123.123.123.123.')
  end

  def test_correct_number_range_in_ip4_address
    refute Parser.new.validate_ip4_address('-4.123.123.123')
    refute Parser.new.validate_ip4_address('300.123.123.123')
    refute Parser.new.validate_ip4_address('123.280.123.123')
    refute Parser.new.validate_ip4_address('123.123.000.123')
  end
end
