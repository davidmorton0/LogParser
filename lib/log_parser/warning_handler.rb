class WarningHandler
  include Constants

  attr_reader :warnings, :warning_info

  def initialize(warnings)
    @warnings = warnings
  end

  def set_warning_info(warning_info)
    @warning_info = warning_info
    self
  end

  def warnings_summary
    summary = {}
    warning_info.each { |type, info| summary[type] = [] }
    @warnings.each{ |warning| summary[warning[:type]].push(warning[:message]) }
    summary.map{ |warning_type, warnings|
      warning_list = ["#{warning_info[warning_type][:name]}: #{warnings.length} warning#{warnings.length == 1 ? '' : 's'}"]
      warning_list.concat(warnings) if warning_info[warning_type][:important]
      warning_list
    }.flatten
  end

  def output_warnings(warnings_to_output)
    warnings_to_output.map{ |warning| "#{warning_info[warning[:type]][:name]}: #{warning[:message]}" }
  end

  def important_warnings
    output_warnings(@warnings.filter{ |warning| warning_info[warning[:type]][:important] })
  end

  def full_warnings
    output_warnings(@warnings)
  end
end
