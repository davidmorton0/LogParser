class IpValidator

  VALID_IP4 = '^' + (['([0-9]|[0-9][0-9]|[0-1][0-9][0-9]|2[0-4][0-9]|25[0-5])'] * 4).join('[.]') + '$'

  attr_reader :ip_address

  def initialize(ip_address)
    @ip_address = ip_address
  end

  def valid_ip4?
    !!ip_address.match(VALID_IP4)
  end

  def valid_ip6?

  end

end
