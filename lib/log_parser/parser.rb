# frozen_string_literal: true

# Parses log information
class Parser
  include Constants

  attr_reader :page_views, :formatter, :log_reader

  def initialize(log_reader: {}, quiet: false, verbose: false)
    @page_views = {}
    @log_reader = log_reader
    @formatter = Formatter.new
    @warning_handler = nil
  end

  def warnings
    WarningHandler.new(warnings: log_info[:warnings])
                  .store_warning_info(warning_info: LOG_WARNINGS)
                  .warnings_summary
  end

  def count_views(logs: log_reader.read_log)
    logs.each do |page, ip_addresses|
      @page_views[page] = { visits: ip_addresses.length,
                            unique_views: ip_addresses.uniq.length }
    end
  end

  def view_info(view_type:)
    { title: INFO_TITLES[view_type],
      descriptor: DESCRIPTORS[view_type],
      info: @page_views.map { |page, views| [page, views[view_type]] } }
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
    formatter.format_info(view_info: view_info(view_type: view_type),
                          add_color: add_color)
  end

  def formatted_full_warnings(add_color: false)
    formatter.format_full_warnings(warnings: warnings, add_color: add_color)
  end

  def formatted_minimal_warnings(add_color: false)
    formatter.format_minimal_warnings(warnings: warnings, add_color: add_color)
  end

  def formatted_normal_warnings(add_color: false)
    formatter.format_normal_warnings(warnings: warnings, add_color: add_color)
  end

  def hash_format(verbose:)
    output = {}
    output['filesRead'] = log_info[:files_read]
    output['logsRead'] = log_info[:logs_read]
    output['logsAdded'] = log_info[:logs_added]
    output['pageVisits'] = {}
    output['uniquePageViews'] = {}
    page_views.each do |page, views|
      output['pageVisits'][page] = views[:visits]
      output['uniquePageViews'][page] = views[:unique_views]
    end
    if verbose
      warning_summary = warnings.map do |type, info|
        { WARNINGS_JSON[type] => {
          'numberWarnings': info[:warnings].length,
          'warnings': info[:warnings]
        } }
      end
    else
      warning_summary = warnings.map do |type, info|
        if info[:important]
          { WARNINGS_JSON[type] => {
            'numberWarnings': info[:warnings].length,
            'messages': info[:warnings]
          } }
        else
          { WARNINGS_JSON[type] => {
            'numberWarnings': info[:warnings].length
          } }
        end
      end
    end
    output['warnings'] = warning_summary
    output
  end
end
