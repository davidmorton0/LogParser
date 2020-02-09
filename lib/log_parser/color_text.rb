module ColorText

  COLOR_CODE = {
    black:   30,
    red:     31,
    green:   32,
    yellow:  33,
    blue:    34,
    magenta: 35,
    cyan:    36,
    gray:    37,
    white:   38
  }

  def colorize(text, color)
    "\e[#{COLOR_CODE[color]}m#{text}\e[0m"
  end

end
