class Parser
  include Constants
  
    attr_accessor :page_views, :warnings

    def initialize(file: nil, log: nil)
      @page_views = {}
      self.count_views(LogReader.new(file: file, log: log).page_views)
      #@warnings = log_record[:warnings]
      self
    end

    def count_views(logs)
      logs.each{ |page, ip_addresses|
        @page_views[page] = { visits: ip_addresses.length,
                              unique_views: ip_addresses.uniq.length }
      }
    end

    def view_information(view_type)
      { title: INFO_TITLES[view_type],
        descriptor: DESCRIPTORS[view_type],
        info: @page_views.map{|page, views| [page, views[view_type]]} }
    end


    def list_page_views(view_type, color: false)
      InfoDisplayer.new(view_information(view_type)).display(color: color)
    end

end
