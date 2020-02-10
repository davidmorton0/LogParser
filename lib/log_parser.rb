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

  parser = Parser.new(
    file: @options[:file],
    file_list: @options[:files] ? @options[:files].split(' ') : nil,
    path_validation: @options[:path_validation],
    ip_validation: @options[:ip_validation],
    log_remove: @options[:log_remove])

  output_processor = OutputProcessor.new(
    warning_handler: WarningHandler.new(parser.warnings)
                                   .set_warning_info(LOG_WARNINGS),
    parser: parser,
    options: @options)

  output_processor.output_to_display
  output_processor.output_to_file

end
