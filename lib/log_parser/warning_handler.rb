class WarningHandler
  include Constants

  attr_reader :warnings, :warning_info

  def initialize(warnings: [])
    @warnings = warnings
  end

  def set_warning_info(warning_info: {})
    @warning_info = warning_info
    self
  end

  def warnings_summary
    summary = {}
    warning_info.each { |type, info|
      summary[type] = {}
      summary[type][:name] = info[:name]
      summary[type][:important] = info[:important]
      summary[type][:warnings] = @warnings
                                  .filter{ |warning| warning[:type] == type }
                                  .map { |warning| warning[:message] } }
    summary
  end

end
