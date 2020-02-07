#require 'minitest/autorun'
require 'LogParser'

LOGS = { "/home" => [['1.1.1.1'],['2.2.2.2']],
         "/about" => [['1.1.1.1'],['1.1.1.1'],['2.2.2.2']], }

class ParserTest < Minitest::Test

  def test_outputs_page_views
    assert_equal Parser.new(file: nil).output_page_views('/help_page', 1), '/help_page - 1 visit'
  end

  def test_outputs_unique_page_views
    assert_equal Parser.new(file: nil).output_unique_page_views('/help_page/1', 1), '/help_page/1 - 1 unique view'
  end

  def test_counts_page_views
    parser = Parser.new(file: nil)
    parser.count_views(LOGS)
    result = { "/home" => 2,
               "/about" => 3 }
    assert_equal result, parser.page_views
  end

  def test_counts_unique_page_views
    parser = Parser.new(file: nil)
    parser.count_views(LOGS)
    result = { "/home" => 2,
               "/about" => 2 }
    assert_equal result, parser.unique_page_views
  end

  def test_lists_page_views
    parser = Parser.new(file: nil)
    parser.count_views(LOGS)
    result = ['/about - 3 visits', '/home - 2 visits']
    assert_equal result, parser.list_page_views
  end

  def test_lists_unique_page_views
    parser = Parser.new(file: nil)
    parser.count_views(LOGS)
    result = ['/about - 2 visits', '/home - 2 visits']
    assert_equal result, parser.list_unique_page_views
  end

end
