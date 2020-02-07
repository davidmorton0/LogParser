Dir.glob(File.join(File.dirname(__FILE__), 'LogParser', '*.rb')).sort.each { |file| require file }
require 'optparse'

module LogParser

end

if __FILE__ == $0
  @options = {}

  OptionParser.new do |opts|
    opts.on("-v", "--verbose", "Show extra information") do
      @options[:verbose] = true
    end

    opts.on("-c", "--color", "Enable syntax highlighting") do
      @options[:syntax_highlighting] = true
    end

    opts.on("-f", "--file", "Web server log file to read") do
      @options[:syntax_highlighting] = true
    end
  end.parse!

  p @options
  puts ARGV
  parser = Parser.new
  puts parser.list_page_views, "\n"
  puts parser.list_unique_page_views
end
