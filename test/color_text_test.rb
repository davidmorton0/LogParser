require 'test_helper'

class ColorTextTest < Minitest::Test
  include ColorText

  def test_adds_red_to_text
    assert_equal "\e[31mred_text\e[0m", colorize('red_text', :red)
  end

  def test_adds_blue_to_text
    assert_equal "\e[34mblue_text\e[0m", colorize('blue_text', :blue)
  end

  def test_color_if_adds_color_to_text_when_true
    assert_equal "\e[31mred_text\e[0m", colorize_if('red_text', :red, true)
  end

  def test_color_if_does_not_add_color_to_text_when_false
    assert_equal 'red_text', colorize_if('red_text', :red, false)
  end

end
