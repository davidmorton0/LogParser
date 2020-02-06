PATTERN = '(\/\w+)(\/?\d*)\s([\d.]+)'

class LogReader

  attr_accessor :warnings

  def initialize(file = '')
    @file = file
    @page_records = {}
    @page_records.default = 0;
    @warnings = [];
  end

  def load_log()
    File.open(@file,'r').each.with_index { |line, i| add_log(line, i) }
    @page_records
  end

  def add_log(page_log, index = 0)
    if !page_log.match(PATTERN)
      return @warnings.push("Warning - Incorrect format for log detected on line #{index} of #{@file}")
    end
    lg = page_log.split(' ')
    @page_records[[lg[1], lg[0]]] += 1
    @page_records
  end
end
