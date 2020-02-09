#!/usr/bin/env ruby
Dir.glob(File.join(File.dirname(__FILE__), 'log_parser', '*.rb')).sort.each { |file|
  #puts file
  require file }

require 'optparse'

DEFAULT_OPTIONS = { page_views: true,
                    unique_page_views: true,
                    file: 'webserver.log'}

module LogParser

end

if __FILE__ == $0

  @options = DEFAULT_OPTIONS

  OptionParser.new do |opts|
    opts.on("-v", "--verbose", "Show extra information") do
      @options[:verbose] = true
    end

    opts.on("-c", "--color", "Enable syntax highlighting") do
      @options[:syntax_highlighting] = true
    end

    opts.on("-f", "--file FILE", "Web server log file to read") do |file|
      @options[:file] = file
    end

    opts.on("-p", "--page_views", "Show page visits only") do
      @options[:unique_page_views] = false
    end

    opts.on("-u", "--unique_page_views", "Show unique page views only") do
      @options[:page_views] = false
    end

    opts.on("-b", "--both_page_views", "Show page visits and unique page views (default)") do
      @options[:page_views] = true
      @options[:unique_page_views] = true
    end

  end.parse!

  parser = Parser.new({file: @options[:file]})
  puts parser.list_page_views(:visits, color: @options[:syntax_highlighting]) if @options[:page_views]
  puts parser.list_page_views(:unique_views, color: @options[:syntax_highlighting]) if @options[:unique_page_views]
  warning_handler = WarningHandler.new(parser.warnings)
  warning_handler.set_warning_info(LOG_WARNINGS)
  puts "\n", warning_handler.warnings_summary
end
