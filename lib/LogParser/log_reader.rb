PATTERN = '(\/\w+)(\/?\d*)\s([\d.]+)'

class LogReader

  attr_accessor :warnings, :file, :page_views

  def initialize(file: nil, log: nil)
    @page_views = Hash.new { |h, k| h[k] = [] }
    @warnings = [];
    if file then self.load_log(file) end
    if log then add_log(log, 1) end
    self
  end

  def load_log(file)
    File.open(file,'r').each.with_index { |line, i| add_log(line, i) }
    self
  end

  def add_log(page_log, index = 0)
    if !page_log.match(PATTERN)
      return @warnings.push("Warning - Incorrect format for log - line #{index}")
    end
    page, ip_address = page_log.split(' ')
    @page_views[page].push(ip_address)
  end

end