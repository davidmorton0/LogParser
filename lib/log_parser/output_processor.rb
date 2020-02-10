class OutputProcessor
  include ColorText

  def initialize(warning_handler:, parser:, options:)
    @warning_handler = warning_handler
    @parser = parser
    @options = options
  end

  def output_to_display
    if @options[:silent]
      puts "\n", @warning_handler.important_warnings(color: @options[:highlighting])
    else
      display_view_info()
      puts "\n", colorize_if("File: #{@options[:file]}", :cyan, @options[:highlighting])
      puts colorize_if("Logs read: #{@parser.log_information[:logs_read]}", :cyan, @options[:highlighting])
      puts colorize_if("Logs added: #{@parser.log_information[:logs_added]}", :cyan, @options[:highlighting])
      if @options[:verbose]
        puts "\n", @warning_handler.full_warnings(color: @options[:highlighting]), "\n"
      else
        puts "\n", @warning_handler.warnings_summary(color: @options[:highlighting]), "\n"
      end
    end
  end

  def display_view_info()
    puts @parser.list_page_views(:visits, color: @options[:highlighting]) if @options[:page_views]
    puts @parser.list_page_views(:unique_views, color: @options[:highlighting]) if @options[:unique_page_views]
  end

  def output_to_file
    if @options[:output_file]
      if File.exist?(@options[:output_file])
        puts "File already exists. Overwrite? yes/no"
        input = gets.rstrip.downcase
        if input == "y" || input == "yes"
          write_to_file
        else
          puts 'No file written'
        end
      else
        write_to_file
      end
    end
  end

  def write_to_file
    f = File.new(@options[:output_file],  'w')
    f.write @parser.list_page_views(:visits).join("\n") if @options[:page_views]
    f.write "\n"
    f.write @parser.list_page_views(:unique_views).join("\n") if @options[:unique_page_views]
    f.write "\n"
    f.write "\n", "File: #{@options[:file]}"
    f.write "\n"
    f.write "Logs read: #{@parser.log_information[:logs_read]}"
    f.write "\n"
    f.write "Logs added: #{@parser.log_information[:logs_added]}"
    f.write "\n"
    f.write "\n", @warning_handler.warnings_summary.join("\n"), "\n"
    f.close
    puts 'Output written to: %s' % @options[:output_file]
  end

end
