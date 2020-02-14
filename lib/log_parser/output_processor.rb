# frozen_string_literal: true

require 'json'
# Processes output for display or write to file
class OutputProcessor
  include Constants

  attr_reader :add_color, :parser

  def initialize(parser:, options:)
    @parser = parser
    @options = options
    @add_color = options ? @options[:highlighting] : false
  end

  def name_output_file
    if File.exist?(@options[:output_file]) || @options[:timestamp]
      timestamp_filename(@options[:output_file])
    else
      @options[:output_file]
    end
  end

  def timestamp_filename(file)
    dir  = File.dirname(file)
    base = File.basename(file, '.*')
    time = Time.now.strftime('%d-%m-%y_%H-%M-%S')
    ext  = File.extname(file)
    File.join(dir, "#{base}_#{time}#{ext}")
  end

  def output_to_display
    output = []
    if @options[:quiet]
      output.push(parser.formatted_minimal_warnings(add_color: add_color))
    else
      if @options[:page_visits]
        output.push(parser.formatted_page_views(view_type: :visits,
                                                add_color: add_color))
      end
      if @options[:unique_page_views]
        output.push(parser.formatted_page_views(view_type: :unique_views,
                                                add_color: add_color))
      end
      output.push(parser.formatted_log_info(add_color: add_color))
      if @options[:verbose]
        output.unshift(Formatter.new.format_options(options: @options,
                                                    add_color: add_color))
        output.push('', parser.formatted_full_warnings(add_color: add_color))
      else
        output.push('', parser.formatted_normal_warnings(add_color: add_color))
      end
    end
    output.join("\n")
  end

  def output_to_file_text
    output = []
    if @options[:page_visits]
      output.push(parser.formatted_page_views(view_type: :visits).join("\n"))
    end
    if @options[:unique_page_views]
      output.push(parser.formatted_page_views(
        view_type: :unique_views
      ).join("\n"))
    end
    output.push(parser.formatted_log_info)
    if @options[:verbose]
      output.push(parser.formatted_full_warnings)
    else
      output.push(parser.formatted_normal_warnings)
    end
    output.join("\n")
  end

  def output_to_file_json
    JSON.pretty_generate parser.hash_format(verbose: @options[:verbose])
  end

  def write_to_file(format:)
    file = name_output_file
    f = File.new(file, 'w')
    format_select = { text: -> { output_to_file_text },
                      json: -> { output_to_file_json } }
    f.write format_select[format].call
    f.close

    puts format('Output written to: %<file>s', file: file)
  end
end
