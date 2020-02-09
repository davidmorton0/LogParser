class LogReader
  include Constants

  attr_accessor :warnings, :page_views, :log_counter, :valid_log_counter

  def initialize(file: nil, log: nil)
    @page_views = Hash.new { |h, k| h[k] = [] }
    @warnings = [];
    @log_counter = 0;
    @valid_log_counter = 0;
    if file then self.load_log(file) end
    if log then add_log(log, 1) end
    self
  end

  def load_log(file)
    begin
      File.open(file,'r').each.with_index { |line, i| add_log(log: line, file: file, index: i) }
    rescue
      @warnings.push( {type: :file, message: " - File not found: #{file}" })
    end
    self
  end

  def add_log(log:, file: false, index: 1)
    @log_counter += 1
    if !log.match(LOG_PATTERN)
      return @warnings.push({type: :log, message: " - Incorrect format for log" + (file ? " - line #{index} in #{file}" : '') })
    end
    page, ip_address = log.split(' ')
    if IpValidator.new(ip_address).valid_ip4?
      @valid_log_counter += 1
      @page_views[page].push(ip_address)
    else
      @warnings.push({type: :ip4, message:" - Incorrect ip4 address for log" + (file ? " - line #{index} in #{file}" : '') })
    end
  end

end
