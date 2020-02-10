class Parser
  include Constants

    attr_accessor :page_views, :read_log

    def initialize(file:, path_validation: true, ip_validation: :ip4, log_remove: false)
      @page_views = {}
      @read_log = LogReader.new(file: file, path_validation: path_validation, ip_validation: ip_validation, log_remove: false)
      self.count_views(read_log.page_views)
      self
    end

    def count_views(logs)
      logs.each{ |page, ip_addresses|
        @page_views[page] = { visits: ip_addresses.length,
                              unique_views: ip_addresses.uniq.length }
      }
    end

    def warnings
       @read_log ? @read_log.warnings : []
    end

    def view_information(view_type)
      { title: INFO_TITLES[view_type],
        descriptor: DESCRIPTORS[view_type],
        info: @page_views.map{|page, views| [page, views[view_type]]} }
    end

    def log_information
      { logs_read: @read_log.logs_read,
        logs_added: @read_log.logs_added }
    end


    def list_page_views(view_type, color: false)
      InfoDisplayer.new(view_information(view_type)).display(color: color)
    end

end
