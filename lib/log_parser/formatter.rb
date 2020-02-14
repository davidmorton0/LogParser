# frozen_string_literal: true

# Formats text for output
class Formatter
  include ColorText
  include Constants

  attr_accessor :output

  def initialize
    @output = []
  end

  def add_title(title:, add_color: false)
    output.push(colorize_if(title, OUTPUT_COLORS[:title], add_color))
    line_break = colorize_if(('-' * title.length),
                             OUTPUT_COLORS[:line_break], add_color)
    output.unshift(line_break)
    output.push(line_break)
  end

  def add_row(row:, descriptor:, add_color: false)
    output.push(row.map.with_index { |item, i|
      colorize_if(add_descriptor(item, descriptor[i]),
                  OUTPUT_COLORS[:columns][i], add_color)
    }.join(' '))
  end

  def add_descriptor(item, descriptor)
    if item.is_a?(Integer) && (descriptor != '')
      format('%<item>s %<descriptor>s', item: item,
                                        descriptor: pluralise(descriptor, item))
    else
      item
    end
  end

  def format_info(view_info:, add_color: false)
    @output = []
    add_title(title: view_info[:title], add_color: add_color)
    view_info[:info].sort_by { |page, views| [-views, page] }
                    .each do |row|
                      add_row(row: row,
                              descriptor: view_info[:descriptor],
                              add_color: add_color)
                    end
    @output
  end

  def format_log_info(log_info:, add_color: false)
    files = log_info[:files_read].map { |file| File.absolute_path(file) }
                                 .join(",\n")
    format("\n%<file_info>s\n%<logs_read>s\n%<logs_added>s",
           file_info: colorize_if("Files read: #{files}",
                                  OUTPUT_COLORS[:log], add_color),
           logs_read: colorize_if("Logs read: #{log_info[:logs_read]}",
                                  OUTPUT_COLORS[:log], add_color),
           logs_added: colorize_if("Logs added: #{log_info[:logs_added]}",
                                   OUTPUT_COLORS[:log], add_color))
  end

  def format_minimal_warnings(warnings:, add_color: false)
    warnings_list = warnings.filter { |_type, info|
      info[:important] && !info[:warnings].empty?
    }.map { |_type, info|
      color = WARNING_COLORS[true]
      text = [warning_summary(info[:name], info[:warnings].length),
              info[:warnings]].join("\n")
      colorize_if(text, color, add_color)
    }
    warnings_list.flatten.join("\n")
  end

  def format_full_warnings(warnings:, add_color: false)
    warnings_list = warnings.map do |_type, info|
      if info[:warnings].empty?
        color = WARNING_COLORS[:none]
        text = [warning_summary(info[:name], info[:warnings].length)]
      else
        color = WARNING_COLORS[info[:important]]
        text = [warning_summary(info[:name], info[:warnings].length),
                info[:warnings]]
      end
      colorize_if(text.join("\n"), color, add_color)
    end
    warnings_list.flatten.join("\n")
  end

  def format_normal_warnings(warnings:, add_color: false)
    warnings_list = warnings.map do |_type, info|
      if !info[:warnings].empty? && info[:important]
        color = WARNING_COLORS[true]
        text = [warning_summary(info[:name], info[:warnings].length),
                info[:warnings]].join("\n")
      elsif info[:important]
        color = WARNING_COLORS[:none]
        text = [warning_summary(info[:name], info[:warnings].length)].join("\n")
      else
        color_key = info[:warnings].empty? ? :none : false
        color = WARNING_COLORS[color_key]
        text = [warning_summary(info[:name], info[:warnings].length)].join("\n")
      end
      colorize_if(text, color, add_color)
    end
    warnings_list.flatten.join("\n")
  end

  def pluralise(item, number)
    item + (number != 1 ? 's' : '')
  end

  def warning_summary(name, number)
    format('%<name>ss: %<number>d %<warnings>s',
           name: name, number: number, warnings: pluralise('warning', number))
  end

  def format_options(options:, add_color: false)
    options = OPTION_DESCRIPTIONS.map do |k, _v|
      OPTION_DESCRIPTIONS[k].call(options[k])
    end
    text = format("\nOptions selected:\n\n%<options>s\n",
                  options: options.join(",\n"))
    colorize_if(text, OUTPUT_COLORS[:options], add_color)
  end
end
