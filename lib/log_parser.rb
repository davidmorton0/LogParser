# frozen_string_literal: true

Dir.glob(File.join(__dir__, 'log_parser', '*.rb'))
   .sort
   .each { |file| require file }

# main file for app
module LogParser
  def self.parse
    @options = OptionHandler.new.options

    log_reader = LogReader.new(
      options: { file_list: @options[:file_list],
                 path_validation: @options[:path_validation],
                 ip_validation: @options[:ip_validation],
                 log_remove: @options[:log_remove] }
    ).load_logs

    parser = Parser.new(log_reader: log_reader,
                        quiet: @options[:quiet],
                        verbose: @options[:verbose])
    parser.count_views

    output_processor = OutputProcessor.new(parser: parser, options: @options)
    puts output_processor.output_to_display

    return unless @options[:output_file]

    output_processor.write_to_file(format: @options[:output_format])
  end
end
