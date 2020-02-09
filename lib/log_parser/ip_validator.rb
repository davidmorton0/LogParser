class IpValidator
  include IpRegex

  attr_reader :ip_address

  def initialize(ip_address)
    @ip_address = ip_address
  end

  def valid_ip4?
    !!ip_address.match(VALID_IP4)
  end

  def valid_ip6?
    !!ip_address.match(VALID_IP6)
  end

end
