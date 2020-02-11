require 'test_helper'

class LogParserTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::LogParser::VERSION
  end

  def test_processes_log
    parser = Parser.new()
    #puts parser.page_views
    log_reader = LogReader.new( options: {
      file: File.join(File.dirname(__FILE__), '/test_logs/test.log') })
    #puts log_reader.page_views
    parser.count_views(logs: log_reader.read_log)
    #puts parser.page_views
    #puts parser.view_info(:visits)
    #puts parser.view_info(:unique_views)
    #info_displayer = Formatter.new(parser.view_info(:visits))
    #puts info_displayer.display
    #info_displayer = Formatter.new(parser.view_info(:unique_views))
    #puts info_displayer.display
  end

end
