require 'test_helper'

class InfoDisplayerTest < Minitest::Test
  include TestData

  def test_shows_title
    assert_equal OUTPUT[0][1], InfoDisplayer.new(INPUT2).display[0][1]
  end

  def test_shows_line_breaks
    assert_equal OUTPUT[0][0], InfoDisplayer.new(INPUT2).display[0][0]
    assert_equal OUTPUT[0][2], InfoDisplayer.new(INPUT2).display[0][2]
  end

  def test_sorts_list_correctly
    assert_equal OUTPUT[1][0], InfoDisplayer.new(INPUT2).display[1][0]
  end

  def test_add_item_description_for_greater_than_one
    assert_equal OUTPUT[1][2], InfoDisplayer.new(INPUT2).display[1][2]
  end

  def test_add_item_description_for__one_item
    assert_equal OUTPUT[1][1], InfoDisplayer.new(INPUT2).display[1][1]
  end

  def test_colorizes_title
  end

  def test_colorizes_columns_correctly
  end

end
