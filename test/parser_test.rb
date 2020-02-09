require 'test_helper'

class ParserTest < Minitest::Test
  include TestData

  def test_reads_pages
    parser = Parser.new(file: nil)
    parser.count_views(LOG_INFO)
    assert PROCESSED_LOG["/home"]
    assert PROCESSED_LOG["/about"]
  end

  def test_counts_page_visits
    parser = Parser.new(file: nil)
    parser.count_views(LOG_INFO)
    assert_equal PROCESSED_LOG["/home"][:visits], parser.page_views["/home"][:visits]
    assert_equal PROCESSED_LOG["/about"][:visits], parser.page_views["/about"][:visits]
  end

  def test_counts_unique_page_views
    parser = Parser.new(file: nil)
    parser.count_views(LOG_INFO)
    assert_equal PROCESSED_LOG["/home"][:unique_views], parser.page_views["/home"][:unique_views]
    assert_equal PROCESSED_LOG["/about"][:unique_views], parser.page_views["/about"][:unique_views]
  end

  def test_returns_page_visits_information
    parser = Parser.new(file: nil)
    parser.count_views(LOG_INFO)
    assert_equal PAGE_VISITS[:title], parser.view_information(:visits)[:title]
    assert_equal PAGE_VISITS[:descriptor], parser.view_information(:visits)[:descriptor]
    assert_equal PAGE_VISITS[:info], parser.view_information(:visits)[:info]
  end

  def test_returns_page_unique_views_information
    parser = Parser.new(file: nil)
    parser.count_views(LOG_INFO)
    assert_equal UNIQUE_PAGE_VIEWS[:title], parser.view_information(:unique_views)[:title]
    assert_equal UNIQUE_PAGE_VIEWS[:descriptor], parser.view_information(:unique_views)[:descriptor]
    assert_equal UNIQUE_PAGE_VIEWS[:info], parser.view_information(:unique_views)[:info]
  end

end
