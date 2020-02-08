class LogValidator

  def validate_ip4_address(ip_address)
    number = '([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])'
    pattern = '^'  + ([number] * 4).join('[.]') + '$'
    !!ip_address.match(pattern)
  end

  def validate_ip6_address(ip_address)

  end

end
