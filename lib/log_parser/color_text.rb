# frozen_string_literal: true

# Changes text color
module ColorText
  COLOR_CODE = { black: 30,
                 red: 31,
                 green: 32,
                 yellow: 33,
                 blue: 34,
                 magenta: 35,
                 cyan: 36,
                 gray: 37,
                 white: 38 }.freeze

  def colorize(text, color)
    "\e[#{COLOR_CODE[color]}m#{text}\e[0m"
  end

  def colorize_if(text, color, change_color = false)
    change_color ? colorize(text, color) : text
  end
end
