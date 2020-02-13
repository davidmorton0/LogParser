# frozen_string_literal: true

# Validates ip addresses
class IpValidator
  include Constants

  attr_reader :ip_address, :validation

  def initialize(ip_address:, validation:)
    @ip_address = ip_address
    @validation = VALID_ADDRESS[validation || :none]
  end

  def valid?
    @validation.call(ip_address)
  end
end
