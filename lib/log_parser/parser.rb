class Parser
  include Constants

    attr_accessor :page_views, :log_reader
    attr_reader :formatter, :quiet, :verbose

    def initialize(log_reader: {}, quiet: false, verbose: false)
      @page_views = {}
      @log_reader = log_reader
      @formatter = Formatter.new()
      @quiet = quiet
      @verbose = verbose
    end

    def set_warning_handler
      warnings = log_info ? log_info[:warnings] : []
      WarningHandler.new(warnings).set_warning_info(LOG_WARNINGS)
    end

    def count_views(logs: log_reader.read_log)
      logs.each{ |page, ip_addresses|
        @page_views[page] = { visits: ip_addresses.length,
                              unique_views: ip_addresses.uniq.length }
      }
    end

    def view_info(view_type)
      { title: INFO_TITLES[view_type],
        descriptor: DESCRIPTORS[view_type],
        info: @page_views.map{|page, views| [page, views[view_type]]} }
    end

    def log_info
      { files_read: @log_reader.files_read || '',
        logs_read: @log_reader.logs_read || 0,
        logs_added: @log_reader.logs_added || 0,
        warnings: @log_reader.warnings || [] }
    end

    def formatted_log_info(add_color: false)
      formatter.format_log_info(log_info: log_info, add_color: add_color)
    end

    def formatted_page_views(view_type:, add_color: false)
      formatter.format_info(view_info: view_info(view_type), add_color: add_color)
    end

    def formatted_warnings(add_color: false)
      formatter.format_warnings(warning_handler: set_warning_handler,
                                quiet: quiet,
                                verbose: verbose,
                                add_color: add_color)
    end

end
