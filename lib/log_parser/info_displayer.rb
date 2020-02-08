require 'byebug'

class InfoDisplayer

  FORMAT_COLORS = {
    title: 'light_blue',
    columns: ['green', 'red', 'yellow']
  }

  def initialize(info)
    @info = info
    @display = []
  end

  #String.disable_colorization !@options[:syntax_highlighting]
  #puts 'Page Visits'.yellow, parser.list_page_views, "\n" if @options[:page_views]
  #puts 'Unique Page Views'.yellow, parser.list_unique_page_views, "\n" if @options[:unique_page_views]

#  def output_page_views(page, views)
#    "#{page}".red + " - #{views} visit#{views == 1 ? '' : 's'}".blue
#  end

#  def output_unique_page_views(page, views)
#    "#{page}".red + " - #{views} unique view#{views == 1 ? '' : 's'}".green
#  end
    #@info[:info].map{|line| line.map.with_index{|str, i| (str.to_s).send(FORMAT_COLORS[:columns][i] || FORMAT_COLORS[:columns][-1]) }.join(' ')}.to_s

  def add_title
    line_break = '-' * @info[:title].length + "\n"
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

  def display
    add_title
    @info[:info].sort_by{|page, views| [-views, page] }.each{ |row| add_row(row) }
    @display
  end


end
