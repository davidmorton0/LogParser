require 'test_helper'

class FormatterTest < Minitest::Test
  include TestData
  include ColorText
  include Constants

  def test_adds_title
    formatter = Formatter.new(TEST_INFO_1)
    assert_equal [], formatter.output
    formatter.add_title
    assert_equal 'Info Title', formatter.output[1]
  end

  def test_adds_line_breaks
    formatter = Formatter.new(TEST_INFO_1)
    assert_equal [], formatter.output
    formatter.add_title
    assert_equal '----------', formatter.output[0]
    assert_equal '----------', formatter.output[2]
  end

  def test_adds_colored_title
    color_title = "\e[#{COLOR_CODE[OUTPUT_COLORS[:title]]}mInfo Title\e[0m"
    assert_match color_title, Formatter.new(TEST_INFO_1, add_color: true)
                                             .add_output[1]
  end

  def test_adds_row
    formatter = Formatter.new({ descriptor: ['m', 'n', 'o', 'p'] })
    assert_equal [], formatter.output
    formatter.add_row(['a', 1, 'b', 2])
    assert_equal 'a 1 n b 2 ps', formatter.output[0]
  end

  def test_adds_colored_row
    formatter = Formatter.new({ descriptor: ['thing', 'thing'] },
                                add_color: true)
    assert_equal [], formatter.output
    formatter.add_row([1, 2])
    color_item_1 = "\e[#{COLOR_CODE[OUTPUT_COLORS[:columns][0]]}m1 thing\e[0m"
    color_item_2 = "\e[#{COLOR_CODE[OUTPUT_COLORS[:columns][1]]}m2 things\e[0m"
    assert_equal "#{color_item_1} #{color_item_2}", formatter.output[0]
  end

  def test_does_not_add_descriptor_to_non_integer
    formatter = Formatter.new({})
    assert_equal 'a', formatter.add_descriptor('a', 'thing')
  end

  def test_adds_descriptor_to_integer_when_1
    formatter = Formatter.new({})
    assert_equal '1 thing', formatter.add_descriptor(1, 'thing')
  end

  def test_adds_descriptor_to_integer_when_greater_than_1
    formatter = Formatter.new({})
    assert_equal '2 things', formatter.add_descriptor(2, 'thing')
  end

  def test_adds_title_to_output
    assert_equal TEST_OUTPUT_1[1], Formatter.new(TEST_INFO_1).add_output[1]
  end

  def test_adds_line_breaks_to_output
    assert_equal TEST_OUTPUT_1[0], Formatter.new(TEST_INFO_1).add_output[0]
    assert_equal TEST_OUTPUT_1[2], Formatter.new(TEST_INFO_1).add_output[2]
  end

  def test_sorts_list_alphabetically_to_when_item_count_the_same
    assert_equal TEST_OUTPUT_1[3], Formatter.new(TEST_INFO_1).add_output[3]
    assert_equal TEST_OUTPUT_1[4], Formatter.new(TEST_INFO_1).add_output[4]
    assert_equal TEST_OUTPUT_1[5], Formatter.new(TEST_INFO_1).add_output[5]
  end

  def test_sorts_list_to_by_item_count
    assert_equal TEST_OUTPUT_2[3], Formatter.new(TEST_INFO_2).add_output[3]
    assert_equal TEST_OUTPUT_2[4], Formatter.new(TEST_INFO_2).add_output[4]
    assert_equal TEST_OUTPUT_2[5], Formatter.new(TEST_INFO_2).add_output[5]
  end

  def test_adds_item_description_to_for_one_item
    assert_equal TEST_OUTPUT_3[4], Formatter.new(TEST_INFO_3).add_output[4]
  end

  def test_adds_item_description_to_for_greater_than_one_item
    assert_equal TEST_OUTPUT_3[3], Formatter.new(TEST_INFO_3).add_output[3]
  end

end
