class InfoDisplayer
  include ColorText

  FORMAT_COLORS = { # can be :black, :red, :green, :yellow, :blue, :magenta,
    title: :cyan,   #        :cyan, :gray, :white
    line_break: :yellow,
    columns: [:gray, :green, :red]  #if more columns, last color will be used
  }

  def initialize(info)
    @info = info
    @display = []
  end

  def add_title
    line_break = "-" * @info[:title].length
    @display.push(line_break, @info[:title], line_break)
  end

  def add_row(row)
    @display.push(row.map.with_index{ |item, i| item(item, @info[:descriptor][i])}.join(' '))
  end

  def item(item, descriptor)
    if item.is_a?(Integer) && (descriptor != '')
      item.to_s + ' ' + descriptor + (item > 1 ? 's' : '')
    else
      item
    end
  end

  def display(color: false)
    add_title
    @info[:info].sort_by{|page, views| [-views, page] }.each{ |row| add_row(row) }
    colorize_display if color
    @display
  end

  def colorize_display
    @display[0] = colorize(@display[0], FORMAT_COLORS[:line_break])
    @display[1] = colorize(@display[1], FORMAT_COLORS[:title])
    @display[2] = colorize(@display[2], FORMAT_COLORS[:line_break])
    @display
      .drop(3)
      .each.with_index{ |line, i| @display[i + 3] = line.split(' ')
        .map.with_index{ |str, j| colorize(str, FORMAT_COLORS[:columns][j] || FORMAT_COLORS[:columns][-1]) }
        .join(' ') }
  end


end
