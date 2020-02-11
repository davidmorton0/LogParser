class WarningHandler
  include Constants
  include ColorText

  WARNING_COLORS = { true => :red,      #important warnings color
                     false => :yellow } #non-important warnings color

  attr_reader :warnings, :warning_info

  def initialize(warnings)
    @warnings = warnings
  end

  def set_warning_info(warning_info)
    @warning_info = warning_info
    self
  end

  def warnings_summary(add_color: false)
    summary = {}
    warning_info.each { |type, info| summary[type] = [] }
    @warnings.each{ |warning| summary[warning[:type]].push(warning[:message]) }
    summary.map{ |warning_type, warnings|
      warning_list = [ colorize_if(
        warning_summary(warning_info[warning_type][:name], warnings.length),
        WARNING_COLORS[warning_info[warning_type][:important]],
        add_color) ]
      warning_list.concat(warnings) if warning_info[warning_type][:important]
      warning_list
    }.flatten
  end

  def output_warnings(warnings_to_output, add_color: false)
    warnings_to_output.map{ |warning|
      colorize_if(
        "%<name>s: %<message>s" % {
          name: warning_info[warning[:type]][:name],
          message: warning[:message]},
        WARNING_COLORS[warning_info[warning[:type]][:important]],
        add_color)
    }
  end

  def important_warnings(add_color: false)
    output_warnings(@warnings.filter{ |warning|
      warning_info[warning[:type]][:important] }, add_color: add_color)
  end

  def full_warnings(add_color: false)
    output_warnings(@warnings, add_color: add_color)
  end

  def pluralise(item, number)
    item + (number != 1 ? 's' : '')
  end

  def warning_summary(name, number)
    "%<name>s: %<number>d %<warnings>s" % {
      name: name,
      number: number,
      warnings: pluralise('warning', number) }
  end

end
