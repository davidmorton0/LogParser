class LogReader
  include Constants

  attr_accessor :warnings, :page_views, :logs_read, :logs_added

  def initialize(file: nil, path_validation: true, ip_validation: :ip4, log_remove: false)
    @options = {
      path_validation: true,
      ip_validation: :ip4,
      log_remove: log_remove
    }
    @page_views = Hash.new { |h, k| h[k] = [] }
    @warnings = [];
    @logs_read = 0;
    @logs_added = 0;
    if file then self.load_log(file) end
    self
  end

  def load_log(file)
    begin
      File.open(file,'r').each.with_index { |line, i| add_log(log: line, file: file, index: i) }
    rescue
      @warnings.push({ type: :file, message: " - File not found: #{file}" })
    end
    self
  end

  def add_log(log:, file: false, index: 1)
    @logs_read += 1
    if !log.match(LOG_PATTERN)
      add_warning(type: :log, message: "format", file: file, index: index)
      return self
    end
    path, ip_address = log.split(' ')
    ip_validator = IpValidator.new(ip_address, @options[:ip_validation])
    if !ip_validator.valid?
      add_warning(type: @options[:ip_validation], message: "ip4 address", file: file, index: index)
    else
      ip_valid = true
    end
    if @options[:path_validation] && !PathValidator.new(path).valid_path?
      add_warning(type: :path, message: "path", file: file, index: index)
    else
      path_valid = true
    end

    if !@options[:log_remove] || (ip_valid && path_valid)
      @logs_added += 1
      @page_views[path].push(ip_address)
    end
    self
  end

  def add_warning(type:, message:, file:, index:)
    @warnings.push({type: type, message: " - Incorrect " + message + " for log" + (file ? " - line #{index} in #{file}" : '') })
  end

end
