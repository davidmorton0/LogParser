require 'test_helper'

class IpValidatorTest < Minitest::Test

  def test_validates_ip4_addresses
    assert IpValidator.new('0.0.0.0', :ip4).valid?
    assert IpValidator.new('1.12.123.123', :ip4).valid?
    assert IpValidator.new('126.218.035.038', :ip4).valid?
  end

  def test_max_3_digit_groups_in_ip4_addresses
    refute IpValidator.new('1234.123.123.123', :ip4).valid?
    refute IpValidator.new('12.1234.12.12', :ip4).valid?
    refute IpValidator.new('1.1.1.1234', :ip4).valid?
    refute IpValidator.new('1234.1234.1234.1234', :ip4).valid?
  end

  def test_no_non_digits_in_ip4_address
    refute IpValidator.new('1a.123.123.123', :ip4).valid?
    refute IpValidator.new('123.123.123.12R', :ip4).valid?
    refute IpValidator.new('123.1%3.123.123', :ip4).valid?
    refute IpValidator.new('123.123.12_.123', :ip4).valid?
  end

  def test_correct_number_format_in_ip4_address
    refute IpValidator.new('123.123.123', :ip4).valid?
    refute IpValidator.new('123..123.123', :ip4).valid?
    refute IpValidator.new('123.123.123.123.123', :ip4).valid?
    refute IpValidator.new('1.1.1.1.1', :ip4).valid?
    refute IpValidator.new('123.123.123.', :ip4).valid?
    refute IpValidator.new('123.123.123.123.', :ip4).valid?
  end

  def test_correct_number_range_in_ip4_address
    assert IpValidator.new('1.2.3.4', :ip4).valid?
    assert IpValidator.new('11.22.33.44', :ip4).valid?
    assert IpValidator.new('111.222.233.244', :ip4).valid?
    refute IpValidator.new('1111.2222.3333.4444', :ip4).valid?
    assert IpValidator.new('0.0.0.0', :ip4).valid?
    assert IpValidator.new('00.00.00.00', :ip4).valid?
    assert IpValidator.new('000.000.000.000', :ip4).valid?
    refute IpValidator.new('0000.0000.0000.0000', :ip4).valid?
    assert IpValidator.new('156.156.156.156', :ip4).valid?
    assert IpValidator.new('255.255.255.255', :ip4).valid?
    refute IpValidator.new('256.256.256.256', :ip4).valid?
    refute IpValidator.new('311.311.311.311', :ip4).valid?
    assert IpValidator.new('01.02.03.04', :ip4).valid?
    assert IpValidator.new('001.002.003.004', :ip4).valid?
    assert IpValidator.new('012.012.012.012', :ip4).valid?
    refute IpValidator.new('0123.0123.0123.0123', :ip4).valid?
    refute IpValidator.new('-4.123.123.123', :ip4).valid?
    refute IpValidator.new('123.280.123.123', :ip4).valid?
  end

  def test_validates_ip6_addresses
    assert IpValidator.new('0:0:0:0:0:0:0:0', :ip6).valid?
    assert IpValidator.new('1:12:123:1234:a:ab:abc:abcd', :ip6).valid?
    assert IpValidator.new('A123:0DEF:a123:0def:A123:0DEF:a123:0def', :ip6).valid?
  end

  def test_validates_ip6_addresses_with_compression
    assert IpValidator.new('12af::12af:12af:12af:12af:12af:12af', :ip6).valid?
    assert IpValidator.new('12af::12af:12af:12af:12af:12af', :ip6).valid?
    assert IpValidator.new('::12af:12af:12af:12af:12af', :ip6).valid?
    assert IpValidator.new('12af:12af:12af:12af::', :ip6).valid?
    assert IpValidator.new('12af::12af:12af:12af:12af', :ip6).valid?
    assert IpValidator.new('12af::12af:12af:12af', :ip6).valid?
    assert IpValidator.new('12af::12af:12af', :ip6).valid?
    assert IpValidator.new('12af::12af', :ip6).valid?
    assert IpValidator.new('::12af', :ip6).valid?
    assert IpValidator.new('::', :ip6).valid?
  end

  def test_ip6_addresses_with_incorrect_compression
    refute IpValidator.new('12af:::12af:12af:12af:12af', :ip6).valid?
    refute IpValidator.new('12af::12af:12af::12af', :ip6).valid?
  end

  def test_max_4_digit_groups_in_ip6_addresses
    refute IpValidator.new('12345::1234', :ip6).valid?
    refute IpValidator.new('1234:1234:12345:1234:1234:1234:1234:1234', :ip6).valid?
    refute IpValidator.new('1234:1234:12345::1234:1234:1234:1234', :ip6).valid?
  end

  def test_no_non_allowed_characters_in_ip6_address
    refute IpValidator.new('123G:1234:1234:1234:1234:1234:1234:1234', :ip6).valid?
    refute IpValidator.new('123&:1234:1234:1234:1234:1234:1234:1234', :ip6).valid?
    refute IpValidator.new('12_4:1234:1234:1234:1234:1234:1234:1234', :ip6).valid?
  end

  def test_correct_number_format_in_ip6_address
    refute IpValidator.new('1234:1234:1234:1234:1234:1234:1234', :ip6).valid?
    refute IpValidator.new('1234:1234:1234:1234:1234:1234:1234:1234:1234', :ip6).valid?
    refute IpValidator.new('1:1:1:1:1:1:1:1:1', :ip6).valid?
    refute IpValidator.new('1234:1234:1234:1234:1234:1234:1234:1234:', :ip6).valid?
    refute IpValidator.new('1234:1234:1234:1234:1234:1234:1234:1234:1234:', :ip6).valid?
  end

  def test_correct_number_range_in_ip6_address
    refute IpValidator.new('00000:00000:00000:00000:00000:00000:00000:00000', :ip6).valid?
    assert IpValidator.new('0000:0000:0000:0000:0000:0000:0000:0000', :ip6).valid?
    assert IpValidator.new('000:000:000:000:000:000:000:000', :ip6).valid?
    assert IpValidator.new('00:00:00:00:00:00:00:00', :ip6).valid?
    assert IpValidator.new('0:0:0:0:0:0:0:0', :ip6).valid?
    assert IpValidator.new('ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff', :ip6).valid?
    assert IpValidator.new('f:f:f:f:f:f:f:f', :ip6).valid?
    refute IpValidator.new('g:g:g:g:g:g:g:g', :ip6).valid?
    refute IpValidator.new('01234:0:0:0:0:0:0:0', :ip6).valid?
    assert IpValidator.new('0123:0123:0123:0123:0123:0123:0123:0123', :ip6).valid?
    assert IpValidator.new('0012:0012:0012:0012:0012:0012:0012:0012', :ip6).valid?
    assert IpValidator.new('0001:0001:0001:0001:0001:0001:0001:0001', :ip6).valid?
    refute IpValidator.new('00001:00001:00001:00001:00001:00001:00001:00001', :ip6).valid?
    refute IpValidator.new('-123:0123:0123:0123:0123:0123:0123:0123', :ip6).valid?
  end

  def test_validates_ip4_or_ip6_addresses
    assert IpValidator.new('126.218.035.038', :ip4_ip6).valid?
    refute IpValidator.new('1a.123.123.123', :ip4_ip6).valid?
    refute IpValidator.new('123.123.123.123.123', :ip4_ip6).valid?
    refute IpValidator.new('1111.2222.3333.4444', :ip4_ip6).valid?
    assert IpValidator.new('1:12:123:1234:a:ab:abc:abcd', :ip4_ip6).valid?
    assert IpValidator.new('12af::12af:12af:12af', :ip4_ip6).valid?
    assert IpValidator.new('000:000:000:000:000:000:000:000', :ip4_ip6).valid?
    refute IpValidator.new('1:1:1:1:1:1:1:1:1', :ip4_ip6).valid?
  end

  def test_true_when_no_validation
    assert IpValidator.new('126.218.035.038', :none).valid?
    assert IpValidator.new('888.218.035.038', :none).valid?
    assert IpValidator.new('1a.123.123.123', :none).valid?
    assert IpValidator.new('123.123.123.123.123', :none).valid?
    assert IpValidator.new('1:12:123:1234:a:ab:abc:abcd', :none).valid?
    assert IpValidator.new('1111.2222.3333.4444', :none).valid?
  end

end
