#!/usr/bin/env ruby
Dir.glob(File.join(File.dirname(__FILE__), 'log_parser', '*.rb'))
  .sort
  .each { |file| require file }

module LogParser
end

if __FILE__ == $0

  @options = OptionHandler.new.options

  log_reader = LogReader.new( options: {
    file: @options[:file],
    file_list: @options[:files],
    path_validation: @options[:path_validation],
    ip_validation: @options[:ip_validation],
    log_remove: @options[:log_remove] })

  parser = Parser.new(log_reader: log_reader,
                      quiet: @options[:quiet],
                      verbose: @options[:verbose])
  parser.count_views

  output_processor = OutputProcessor.new(parser: parser, options: @options)
  output_processor.output_to_display
  output_processor.write_to_file if !!@options[:output_file]

end
