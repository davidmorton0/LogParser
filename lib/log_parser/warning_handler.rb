class WarningHandler
  include Constants
  include ColorText

  WARNING_COLORS = { true => :red,      #important warnings color
                     false => :yellow } #not-important warnings color

  attr_reader :warnings, :warning_info

  def initialize(warnings)
    @warnings = warnings
  end

  def set_warning_info(warning_info)
    @warning_info = warning_info
    self
  end

  def warnings_summary(color: false)
    summary = {}
    warning_info.each { |type, info| summary[type] = [] }
    @warnings.each{ |warning| summary[warning[:type]].push(warning[:message]) }
    summary.map{ |warning_type, warnings|
      text_color = WARNING_COLORS[warning_info[warning_type][:important]]
      text = "#{warning_info[warning_type][:name]}: #{warnings.length} warning#{warnings.length == 1 ? '' : 's'}"
      warning_list = [ colorize_if(text, text_color, color) ]
      warning_list.concat(warnings) if warning_info[warning_type][:important]
      warning_list
    }.flatten
  end

  def output_warnings(warnings_to_output, color: false)
    warnings_to_output.map{ |warning|
      text = "#{warning_info[warning[:type]][:name]}: #{warning[:message]}"
      text_color = WARNING_COLORS[warning_info[warning[:type]][:important]]
      colorize_if(text, text_color, color)
    }
  end

  def important_warnings(color: false)
    output_warnings(@warnings.filter{ |warning|
      warning_info[warning[:type]][:important] }, color: color)
  end

  def full_warnings(color: false)
    output_warnings(@warnings, color: color)
  end
end
