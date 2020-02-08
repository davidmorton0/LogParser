require "test_helper"
require 'log_parser'

#LOG =

class LogParserTest < Minitest::Test
  
  def test_that_it_has_a_version_number
    refute_nil ::LogParser::VERSION
  end

  def test_processes_log
    parser = Parser.new({file: nil})
    puts parser.page_views
    log_reader = LogReader.new(file: File.join(File.dirname(__FILE__), '/test.log'))
    puts log_reader.page_views
    parser.count_views(log_reader.page_views)
    puts parser.page_views
    puts parser.view_information(:visits)
    puts parser.view_information(:unique_views)
    info_displayer = InfoDisplayer.new(parser.view_information(:visits))
    puts info_displayer.display
    info_displayer = InfoDisplayer.new(parser.view_information(:unique_views))
    puts info_displayer.display
  end

end
