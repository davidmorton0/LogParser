class Formatter
  include ColorText
  include Constants

  attr_accessor :output

  def initialize()
    @output = []
  end

  def add_title(title:, add_color: false)
    output.push(colorize_if(title, OUTPUT_COLORS[:title], add_color))
    line_break = colorize_if(("-" * title.length),
                              OUTPUT_COLORS[:line_break], add_color)
    output.unshift(line_break)
    output.push(line_break)
  end

  def add_row(row:, descriptor:, add_color: false)
    output.push(row.map.with_index{ |item, i|
      colorize_if(add_descriptor(item, descriptor[i]),
                  OUTPUT_COLORS[:columns][i], add_color)
    }.join(' '))
  end

  def add_descriptor(item, descriptor)
    if item.is_a?(Integer) && (descriptor != '')
      '%<item>s %<descriptor>s%<s>s' % { item: item, descriptor: descriptor,
                                         s: item > 1 ? 's' : '' }
    else
      item
    end
  end

  def format_info(view_info:, add_color: false)
    @output = []
    add_title(title: view_info[:title], add_color: add_color)
    view_info[:info].sort_by{ |page, views| [-views, page] }
                    .each{ |row| add_row(row: row,
                                         descriptor: view_info[:descriptor],
                                         add_color: add_color) }
    @output
  end

  def format_log_info(log_info:, add_color: false)
    files = log_info[:files_read].map{ |file| File.absolute_path(file) }
                                 .join(",\n")
    "\n%<file_info>s\n%<logs_read>s\n%<logs_added>s" % {
      file_info: colorize_if("Files read: #{files}",
        OUTPUT_COLORS[:log], add_color),
      logs_read: colorize_if("Logs read: #{log_info[:logs_read]}",
        OUTPUT_COLORS[:log], add_color),
      logs_added: colorize_if("Logs added: #{log_info[:logs_added]}",
        OUTPUT_COLORS[:log], add_color)
    }
  end

  def format_warnings(warning_handler:, quiet: false, verbose: false, add_color: false)
    if quiet
      warnings = warning_handler.important_warnings(add_color: add_color)
    elsif verbose
      warnings = warning_handler.full_warnings(add_color: add_color)
    else
      warnings = warning_handler.warnings_summary(add_color: add_color)
    end
    "\n%<warnings>s\n" % { warnings: warnings.join("\n") }
  end

end
