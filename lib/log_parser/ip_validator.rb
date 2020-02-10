class IpValidator
  include IpRegex

  attr_reader :ip_address

  def initialize(ip_address, validation)
    @ip_address = ip_address
    @validation = validation
  end

  def valid?
    case @validation
    when :ip4
      valid_ip4?
    when :ip6
      valid_ip6?
    when :ip4_ip6
      valid_ip4? || valid_ip6?
    else
      true
    end
  end

  def valid_ip4?
    !!ip_address.match(VALID_IP4)
  end

  def valid_ip6?
    !!ip_address.match(VALID_IP6)
  end

end
