#require 'minitest/autorun'
require 'log_parser'

INPUT = { "/home" => [['1.1.1.1'],['2.2.2.2']],
         "/about" => [['1.1.1.1'],['1.1.1.1'],['2.2.2.2']], }

OUTPUT1 = { "/home" => { visits: 2, unique_views: 2 },
            "/about" => { visits: 3, unique_views: 2 } }

OUTPUT2 = { title: 'Page Visits',
            descriptor: ['', 'visit'],
            info: [["/home", 2],
                   ["/about", 3]] }

OUTPUT3 = { title: 'Unique Page Views',
            descriptor: ['', 'unique view'],
            info: [["/home", 2],
                   ["/about", 2]] }

class ParserTest < Minitest::Test

  def test_reads_pages
    parser = Parser.new(file: nil)
    parser.count_views(INPUT)
    assert OUTPUT1["/home"]
    assert OUTPUT1["/about"]
  end

  def test_counts_page_visits
    parser = Parser.new(file: nil)
    parser.count_views(INPUT)
    assert_equal OUTPUT1["/home"][:visits], parser.page_views["/home"][:visits]
    assert_equal OUTPUT1["/about"][:visits], parser.page_views["/about"][:visits]
  end

  def test_counts_unique_page_views
    parser = Parser.new(file: nil)
    parser.count_views(INPUT)
    assert_equal OUTPUT1["/home"][:unique_views], parser.page_views["/home"][:unique_views]
    assert_equal OUTPUT1["/about"][:unique_views], parser.page_views["/about"][:unique_views]
  end

  def test_returns_page_visits_information
    parser = Parser.new(file: nil)
    parser.count_views(INPUT)
    assert_equal OUTPUT2[:title], parser.view_information(:visits)[:title]
    assert_equal OUTPUT2[:descriptor], parser.view_information(:visits)[:descriptor]
    assert_equal OUTPUT2[:info], parser.view_information(:visits)[:info]
  end

  def test_returns_page_unique_views_information
    parser = Parser.new(file: nil)
    parser.count_views(INPUT)
    assert_equal OUTPUT3[:title], parser.view_information(:unique_views)[:title]
    assert_equal OUTPUT3[:descriptor], parser.view_information(:unique_views)[:descriptor]
    assert_equal OUTPUT3[:info], parser.view_information(:unique_views)[:info]
  end

end
