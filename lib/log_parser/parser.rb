class Parser
  include Constants

    attr_reader :page_views, :formatter, :log_reader

    def initialize(log_reader: {}, quiet: false, verbose: false)
      @page_views = {}
      @log_reader = log_reader
      @formatter = Formatter.new()
      @warning_handler = nil
    end

    def warning_handler
      @warning_handler ||
      WarningHandler.new(warnings: log_info[:warnings])
                    .set_warning_info(warning_info: LOG_WARNINGS)
    end

    def count_views(logs: log_reader.read_log)
      logs.each{ |page, ip_addresses|
        @page_views[page] = { visits: ip_addresses.length,
                              unique_views: ip_addresses.uniq.length }
      }
    end

    def view_info(view_type:)
      { title: INFO_TITLES[view_type],
        descriptor: DESCRIPTORS[view_type],
        info: @page_views.map{|page, views| [page, views[view_type]]} }
    end

    def log_info
      { files_read: (log_reader == {} ? [] : log_reader.files_read),
        logs_read: (log_reader == {} ? 0 : log_reader.logs_read),
        logs_added: (log_reader == {} ? 0 : log_reader.logs_added),
        warnings: (log_reader == {} ? [] :  log_reader.warnings) }
    end

    def formatted_log_info(add_color: false)
      formatter.format_log_info(log_info: log_info, add_color: add_color)
    end

    def formatted_page_views(view_type:, add_color: false)
      formatter.format_info(view_info: view_info(view_type: view_type), add_color: add_color)
    end

    def formatted_warnings(add_color: false, quiet: false, verbose: false)
      formatter.format_warnings(warning_handler: warning_handler,
                                quiet: quiet,
                                verbose: verbose,
                                add_color: add_color)
    end

    def hash_format(verbose: false)
      output = {}
      output["filesRead"] = log_info[:files_read]
      output["logsRead"] = log_info[:logs_read]
      output["logsAdded"] = log_info[:logs_added]
      output["pageVisits"] = {}
      output["uniquePageViews"] = {}
      page_views.each{ |page, views|
        output["pageVisits"][page] = views[:visits]
        output["uniquePageViews"][page] = views[:unique_views]
      }
      warnings = verbose ? warning_handler.full_warnings : warning_handler.important_warnings
      output["warnings"] = warnings
      output
    end

end
