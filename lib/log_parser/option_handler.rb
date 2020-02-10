require 'optparse'

DEFAULT_OPTIONS = { ip_validation: :ip4,
                    path_validation: true,
                    page_views: true,
                    unique_page_views: true,
                    file: 'webserver.log' }

class OptionHandler

  attr_reader :options

  def initialize

    @options = DEFAULT_OPTIONS

    OptionParser.new do |opts|

      opts.on("-v", "--verbose", "Show extra information") do
          @options[:verbose] = true
      end

      opts.on("-q", "--quiet",
        "No display except important warnings.  Disables verbose") do
          @options[:silent] = true
          @options[:verbose] = false
      end

      opts.on("-c", "--color", "Enable highlighting") do
          @options[:highlighting] = true
      end

      opts.on("-C", "--no_color", "Disable highlighting (default)") do
          @options[:highlighting] = false
      end

      opts.on("-f", "--file FILE",
        "Log file to read. Default is webserver.log") do |file|
          @options[:file] = file
      end

      opts.on("-m", "--multiple_files 'FILE_LIST'",
        "Read a list of files in quotes and combines") do |file|
          @options[:file] = nil
          @options[:multiple_files] = true
          @options[:files] = file
      end

      opts.on("-o", "--output_file [FILE]",
        "Write output to file.") do |file|
          @options[:output_file] = file || 'log_info.txt'
      end

      opts.on("-t", "--timestamp", "Add timestamp to output file") do |file|
          @options[:timestamp] = true
      end

      opts.on("-h", "--help", "Shows help") do
        puts opts
        exit
      end

      opts.on("-4", "--ip4_validation",
        "Validate ip addresses using ip4 format (default)") do
          @options[:ip_validation] = :ip4
      end

      opts.on("-6", "--ip6_validation",
        "Validate ip addresses using ip6 format") do
          @options[:ip_validation] = :ip6
      end

      opts.on("-i", "--ip4_or_ip6_validation",
        "Validate ip addresses using either ip4 or ip6 format") do
          @options[:ip_validation] = :ip4_ip6
      end

      opts.on("-I", "--no_ip_validation", "No validatation of ip addresses") do
          @options[:ip_validation] = false
      end

      opts.on("-r", "--remove_invalid",
        "Ignore log if invalid ip addresss or path") do
          @options[:log_remove] = true
      end

      opts.on("-R", "--warn_invalid",
        "Warn if invalid ip addresss or path (default)") do
          @options[:log_remove] = false
      end

      opts.on("-p", "--path_validation", "Validate webpage path (default)") do
          @options[:path_validation] = true
      end

      opts.on("-P", "--no_path_validation", "Does not validate webpage path") do
          @options[:path_validation] = false
      end

      opts.on("-g", "--page_visits", "Show page visits (default)") do
          @options[:page_views] = true
      end

      opts.on("-G", "--no_page_visits", "Do not show page visits") do
          @options[:page_views] = false
      end

      opts.on("-u", "--unique_page_views",
        "Show unique page views (default)") do
          @options[:unique_page_views] = true
      end

      opts.on("-U", "--no_unique_page_views",
        "Do not show unique page views") do
          @options[:unique_page_views] = false
      end
    end.parse!
  end
end
