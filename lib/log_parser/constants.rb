module Constants

  DEFAULT_OPTIONS = { ip_validation: :ip4,
                      path_validation: true,
                      page_visits: true,
                      unique_page_views: true,
                      output_format: :text,
                      file_list: [] }
  DEFAULT_LOG = 'webserver.log'

  OPTION_DESCRIPTIONS = {
    verbose: -> (value) { "verbose: #{(value || false).to_s}" },
    quiet: -> (value) { "quiet: #{(value || false).to_s}" },
    highlighting: -> (value) { "highlighting: #{(value || false).to_s}" },
    file: -> (file) { "file: #{file || '- '}" },
    file_list: -> (files) { "file list: #{files.join(', ') || '- '}" },
    output_file: -> (output_file) { "output file: #{output_file || '- '}" },
    timestamp: -> (value) { "timestamp: #{(value || false).to_s}" },
    output_format: -> (format) { "output format: #{format.to_s}" },
    ip_validation: -> (validation) {
      "ip validation: #{VALIDATION_NAMES[validation]}" },
    log_remove: -> (value) { "ignore invalid logs: #{(value || false).to_s}" },
    path_validation: -> (value) { "path validation: #{(value || false).to_s}" },
    page_visits: -> (value) { "show page visits: #{(value || false).to_s}" },
    unique_page_views: -> (value) { "show unique page views: #{(value || false).to_s}" } }

  OUTPUT_COLORS = { title: :cyan,        # can be :black, :red, :green, :yellow,
                    line_break: :yellow, # :blue, :magenta, :cyan, :gray, :white
                    columns: [:gray, :green, :red], # if more columns,
                    log: :cyan }                    # final color will be used

  WARNING_COLORS = { true => :red,       #important warnings color
                     false => :yellow,   #non-important warnings color
                     :none => :green }

  VALIDATION_NAMES = { log: 'log',
                       ip4: 'ip4 address',
                       ip6: 'ip6 address',
                       ip4_ip6: 'ip4/ip6 address',
                       none: 'none',
                       path: 'path' }

  LOG_WARNINGS = { file: { name: 'File Error', important: true },
                   log: { name: 'Log Format Error', important: true },
                   ip4: { name: 'Ip4 Address Format Error', important: false },
                   ip6: { name: 'Ip6 Address Format Error', important: false },
                   ip4_ip6: { name: 'Ip Address Format Error', important: false },
                   path: { name: 'Path Format Error', important: false } }

  INFO_TITLES = { visits: 'Page Visits',
                  unique_views: 'Unique Page Views' }

  DESCRIPTORS = { visits: ['', 'visit'],
                  unique_views: ['', 'unique view'] }

  VALID_LOG = '\S+\s([a-zA-Z0-9:.]+)'

  VALID_PATH = '^(/[a-zA-Z0-9.$_+\\-!*(),\']+/?)*/?$'

  VALID_IP4 = '^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'

  VALID_IP6 = '^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$'

end
