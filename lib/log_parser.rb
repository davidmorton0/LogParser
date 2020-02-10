#!/usr/bin/env ruby
Dir.glob(File.join(File.dirname(__FILE__), 'log_parser', '*.rb'))
  .sort
  .each { |file| require file }

LOG_WARNINGS = { file: { name: 'File Errors', important: true },
                 log: { name: 'Log Format Errors', important: true },
                 ip4: { name: 'ip4 Address Format Errors', important: false },
                 ip6: { name: 'ip6 Address Format Errors', important: false },
                 page: { name: 'Path Format Errors', important: false } }

module LogParser
end

if __FILE__ == $0

  @options = OptionHandler.new.options

  parser = Parser.new(file: @options[:file],
                      path_validation: @options[:path_validation],
                      ip_validation: @options[:ip_validation],
                      log_remove: @options[:ip_remove])
  puts parser.list_page_views(:visits, color: @options[:highlighting]) if @options[:page_views]
  puts parser.list_page_views(:unique_views, color: @options[:highlighting]) if @options[:unique_page_views]
  warning_handler = WarningHandler.new(parser.warnings).set_warning_info(LOG_WARNINGS)
  if @options[:silent]
    puts "\n", warning_handler.important_warnings
  elsif @options[:verbose]
    puts "\n", "File: #{@options[:file]}"
    puts "Logs read: #{parser.log_information[:logs_read]}"
    puts "Logs added: #{parser.log_information[:logs_added]}"
    puts "\n", warning_handler.full_warnings
  else
    puts "\n", "File: #{@options[:file]}"
    puts "Logs read: #{parser.log_information[:logs_read]}"
    puts "Logs added: #{parser.log_information[:logs_added]}"
    puts "\n", warning_handler.warnings_summary
  end
end
