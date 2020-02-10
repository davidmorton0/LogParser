class Formatter
  include ColorText
  include Constants

  attr_reader :info, :add_color
  attr_accessor :output

  def initialize(info, add_color: false)
    @info = info
    @output = []
    @add_color = add_color
  end

  def add_title
    output.push(colorize_if(info[:title], OUTPUT_COLORS[:title], add_color))
    line_break = colorize_if(("-" * info[:title].length),
                              OUTPUT_COLORS[:line_break], add_color)
    output.unshift(line_break)
    output.push(line_break)
  end

  def add_row(row)
    output.push(row.map.with_index{ |item, i|
      colorize_if(add_descriptor(item, info[:descriptor][i]),
                  OUTPUT_COLORS[:columns][i], add_color)
    }.join(' '))
  end

  def add_descriptor(item, descriptor)
    if item.is_a?(Integer) && (descriptor != '')
      '%<item>s %<descriptor>s%<s>s' % { item: item, descriptor: descriptor,
                                         s: item > 1 ? 's' : '' }
    else
      item
    end
  end

  def add_output
    add_title
    info[:info].sort_by{ |page, views| [-views, page] }
                .each{ |row| add_row(row) }
    output
  end
end
