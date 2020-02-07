#require 'minitest/autorun'
require 'LogParser'

class LogValidatorTest < Minitest::Test

  def test_validates_ip4_addresses
    assert LogValidator.new.validate_ip4_address('0.0.0.0')
    assert LogValidator.new.validate_ip4_address('1.12.123.123')
  end

  def test_max_3_digit_groups_in_ip4_addresses_too_many
    refute LogValidator.new.validate_ip4_address('1234.123.123.123')
    refute LogValidator.new.validate_ip4_address('123.12345.123.123')
    refute LogValidator.new.validate_ip4_address('1234.123.1234.1234')
    refute LogValidator.new.validate_ip4_address('1.1.1.1234')
  end

  def test_no_non_digits_in_ip4_address
    refute LogValidator.new.validate_ip4_address('1a.123.123.123')
    refute LogValidator.new.validate_ip4_address('123.123.123.12R')
    refute LogValidator.new.validate_ip4_address('123.1%3.123.123')
    refute LogValidator.new.validate_ip4_address('123.123.12_.123')
  end

  def test_correct_number_format_in_ip4_address
    refute LogValidator.new.validate_ip4_address('123.123.123')
    refute LogValidator.new.validate_ip4_address('123.123.123.123.123')
    refute LogValidator.new.validate_ip4_address('1.1.1.1.1')
    refute LogValidator.new.validate_ip4_address('123.123.123.')
    refute LogValidator.new.validate_ip4_address('123.123.123.123.')
  end

  def test_correct_number_range_in_ip4_address
    refute LogValidator.new.validate_ip4_address('-4.123.123.123')
    refute LogValidator.new.validate_ip4_address('300.123.123.123')
    refute LogValidator.new.validate_ip4_address('123.280.123.123')
    refute LogValidator.new.validate_ip4_address('123.123.000.123')
  end

end
