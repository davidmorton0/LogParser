class IpValidator
  include Constants

  attr_reader :ip_address, :validation

  VALID_ADDRESS = {
    none: Proc.new { true },
    ip4: Proc.new { |address| !!address.match(VALID_IP4) },
    ip6: Proc.new { |address| !!address.match(VALID_IP6) },
    ip4_ip6: Proc.new { |address| !!address.match(VALID_IP4) ||
                                  !!address.match(VALID_IP6) }
  }

  def initialize(ip_address, validation)
    @ip_address = ip_address
    @validation = VALID_ADDRESS[validation]
  end

  def valid?
    @validation.call(ip_address)
  end

end
