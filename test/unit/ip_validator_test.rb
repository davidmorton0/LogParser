require 'test_helper'

class IpValidatorTest < Minitest::Test

  def test_validates_ip4_addresses
    assert IpValidator.new(ip_address: '0.0.0.0', validation: :ip4).valid?
    assert IpValidator.new(ip_address: '1.12.123.123', validation: :ip4).valid?
    assert IpValidator.new(ip_address: '126.218.035.038', validation: :ip4).valid?
  end

  def test_max_3_digit_groups_in_ip4_addresses
    refute IpValidator.new(ip_address: '1234.123.123.123', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '12.1234.12.12', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '1.1.1.1234', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '1234.1234.1234.1234', validation: :ip4).valid?
  end

  def test_no_non_digits_in_ip4_address
    refute IpValidator.new(ip_address: '1a.123.123.123', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '123.123.123.12R', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '123.1%3.123.123', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '123.123.12_.123', validation: :ip4).valid?
  end

  def test_correct_number_format_in_ip4_address
    refute IpValidator.new(ip_address: '123.123.123', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '123..123.123', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '123.123.123.123.123', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '1.1.1.1.1', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '123.123.123.', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '123.123.123.123.', validation: :ip4).valid?
  end

  def test_correct_number_range_in_ip4_address
    assert IpValidator.new(ip_address: '1.2.3.4', validation: :ip4).valid?
    assert IpValidator.new(ip_address: '11.22.33.44', validation: :ip4).valid?
    assert IpValidator.new(ip_address: '111.222.233.244', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '1111.2222.3333.4444', validation: :ip4).valid?
    assert IpValidator.new(ip_address: '0.0.0.0', validation: :ip4).valid?
    assert IpValidator.new(ip_address: '00.00.00.00', validation: :ip4).valid?
    assert IpValidator.new(ip_address: '000.000.000.000', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '0000.0000.0000.0000', validation: :ip4).valid?
    assert IpValidator.new(ip_address: '156.156.156.156', validation: :ip4).valid?
    assert IpValidator.new(ip_address: '255.255.255.255', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '256.256.256.256', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '311.311.311.311', validation: :ip4).valid?
    assert IpValidator.new(ip_address: '01.02.03.04', validation: :ip4).valid?
    assert IpValidator.new(ip_address: '001.002.003.004', validation: :ip4).valid?
    assert IpValidator.new(ip_address: '012.012.012.012', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '0123.0123.0123.0123', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '-4.123.123.123', validation: :ip4).valid?
    refute IpValidator.new(ip_address: '123.280.123.123', validation: :ip4).valid?
  end

  def test_validates_ip6_addresses
    assert IpValidator.new(ip_address: '0:0:0:0:0:0:0:0', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '1:12:123:1234:a:ab:abc:abcd', validation: :ip6).valid?
    assert IpValidator.new(ip_address: 'A123:0DEF:a123:0def:A123:0DEF:a123:0def', validation: :ip6).valid?
  end

  def test_validates_ip6_addresses_with_compression
    assert IpValidator.new(ip_address: '12af::12af:12af:12af:12af:12af:12af', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '12af::12af:12af:12af:12af:12af', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '::12af:12af:12af:12af:12af', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '12af:12af:12af:12af::', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '12af::12af:12af:12af:12af', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '12af::12af:12af:12af', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '12af::12af:12af', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '12af::12af', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '::12af', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '::', validation: :ip6).valid?
  end

  def test_ip6_addresses_with_incorrect_compression
    refute IpValidator.new(ip_address: '12af:::12af:12af:12af:12af', validation: :ip6).valid?
    refute IpValidator.new(ip_address: '12af::12af:12af::12af', validation: :ip6).valid?
  end

  def test_max_4_digit_groups_in_ip6_addresses
    refute IpValidator.new(ip_address: '12345::1234', validation: :ip6).valid?
    refute IpValidator.new(ip_address: '1234:1234:12345:1234:1234:1234:1234:1234', validation: :ip6).valid?
    refute IpValidator.new(ip_address: '1234:1234:12345::1234:1234:1234:1234', validation: :ip6).valid?
  end

  def test_no_non_allowed_characters_in_ip6_address
    refute IpValidator.new(ip_address: '123G:1234:1234:1234:1234:1234:1234:1234', validation: :ip6).valid?
    refute IpValidator.new(ip_address: '123&:1234:1234:1234:1234:1234:1234:1234', validation: :ip6).valid?
    refute IpValidator.new(ip_address: '12_4:1234:1234:1234:1234:1234:1234:1234', validation: :ip6).valid?
  end

  def test_correct_number_format_in_ip6_address
    refute IpValidator.new(ip_address: '1234:1234:1234:1234:1234:1234:1234', validation: :ip6).valid?
    refute IpValidator.new(ip_address: '1234:1234:1234:1234:1234:1234:1234:1234:1234', validation: :ip6).valid?
    refute IpValidator.new(ip_address: '1:1:1:1:1:1:1:1:1', validation: :ip6).valid?
    refute IpValidator.new(ip_address: '1234:1234:1234:1234:1234:1234:1234:1234:', validation: :ip6).valid?
    refute IpValidator.new(ip_address: '1234:1234:1234:1234:1234:1234:1234:1234:1234:', validation: :ip6).valid?
  end

  def test_correct_number_range_in_ip6_address
    refute IpValidator.new(ip_address: '00000:00000:00000:00000:00000:00000:00000:00000', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '0000:0000:0000:0000:0000:0000:0000:0000', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '000:000:000:000:000:000:000:000', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '00:00:00:00:00:00:00:00', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '0:0:0:0:0:0:0:0', validation: :ip6).valid?
    assert IpValidator.new(ip_address: 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff', validation: :ip6).valid?
    assert IpValidator.new(ip_address: 'f:f:f:f:f:f:f:f', validation: :ip6).valid?
    refute IpValidator.new(ip_address: 'g:g:g:g:g:g:g:g', validation: :ip6).valid?
    refute IpValidator.new(ip_address: '01234:0:0:0:0:0:0:0', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '0123:0123:0123:0123:0123:0123:0123:0123', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '0012:0012:0012:0012:0012:0012:0012:0012', validation: :ip6).valid?
    assert IpValidator.new(ip_address: '0001:0001:0001:0001:0001:0001:0001:0001', validation: :ip6).valid?
    refute IpValidator.new(ip_address: '00001:00001:00001:00001:00001:00001:00001:00001', validation: :ip6).valid?
    refute IpValidator.new(ip_address: '-123:0123:0123:0123:0123:0123:0123:0123', validation: :ip6).valid?
  end

  def test_validates_ip4_or_ip6_addresses
    assert IpValidator.new(ip_address: '126.218.035.038', validation: :ip4_ip6).valid?
    refute IpValidator.new(ip_address: '1a.123.123.123', validation: :ip4_ip6).valid?
    refute IpValidator.new(ip_address: '123.123.123.123.123', validation: :ip4_ip6).valid?
    refute IpValidator.new(ip_address: '1111.2222.3333.4444', validation: :ip4_ip6).valid?
    assert IpValidator.new(ip_address: '1:12:123:1234:a:ab:abc:abcd', validation: :ip4_ip6).valid?
    assert IpValidator.new(ip_address: '12af::12af:12af:12af', validation: :ip4_ip6).valid?
    assert IpValidator.new(ip_address: '000:000:000:000:000:000:000:000', validation: :ip4_ip6).valid?
    refute IpValidator.new(ip_address: '1:1:1:1:1:1:1:1:1', validation: :ip4_ip6).valid?
  end

  def test_true_when_no_validation
    assert IpValidator.new(ip_address: '126.218.035.038', validation: :none).valid?
    assert IpValidator.new(ip_address: '888.218.035.038', validation: :none).valid?
    assert IpValidator.new(ip_address: '1a.123.123.123', validation: :none).valid?
    assert IpValidator.new(ip_address: '123.123.123.123.123', validation: :none).valid?
    assert IpValidator.new(ip_address: '1:12:123:1234:a:ab:abc:abcd', validation: :none).valid?
    assert IpValidator.new(ip_address: '1111.2222.3333.4444', validation: :none).valid?
  end

end
