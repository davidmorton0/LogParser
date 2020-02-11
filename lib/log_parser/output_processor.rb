class OutputProcessor
  include ColorText
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
    base = File.basename(file, ".*")
    time = Time.now.strftime('%d-%m-%y_%H-%M-%S')
    ext  = File.extname(file)
    File.join(dir, "#{base}_#{time}#{ext}")
  end

  def output_to_display
    if !@options[:quiet]
      if @options[:page_views]
        puts parser.formatted_page_views(view_type: :visits, add_color: add_color)
      end
      if @options[:unique_page_views]
        puts parser.formatted_page_views(view_type: :unique_views, add_color: add_color)
      end
      puts parser.formatted_log_info(add_color: add_color)
    end
    puts parser.formatted_warnings(add_color: add_color)
  end

  def write_to_file
    file = name_output_file
    f = File.new(file,  'w')
    if @options[:page_views]
      f.write (parser.formatted_page_views(view_type: :visits)
                     .join("\n") + "\n")
    end
    if @options[:unique_page_views]
      f.write (parser.formatted_page_views(view_type: :unique_views)
                     .join("\n") + "\n")
    end
    f.write parser.formatted_log_info() + "\n"
    f.write parser.formatted_warnings()
    f.close
    puts 'Output written to: %s' % file
  end

end
