module Constants

  INFO_TITLES = { visits: 'Page Visits',
                  unique_views: 'Unique Page Views' }

  DESCRIPTORS = { visits: ['', 'visit'],
                  unique_views: ['', 'unique view'] }

  VALID_LOG = '(\/\w+)(\/?\d*)\s([\d.]+)'

  VALID_PATH = '^(/[a-zA-Z0-9.$_+\\-!*(),\']+/?)*/?$'

  VALID_IP4 = '^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'

  VALID_IP6 = '^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$'

  OUTPUT_COLORS = { # can be :black, :red, :green, :yellow, :blue, :magenta,
    title: :cyan,   #        :cyan, :gray, :white
    line_break: :yellow,
    columns: [:gray, :green, :red]  #if more columns, last color will be used
  }

  LOG_COLOR = :cyan

  DEFAULT_OPTIONS = { ip_validation: :ip4,
                      path_validation: true,
                      page_views: true,
                      unique_page_views: true,
                      file: 'webserver.log' }

  LOG_WARNINGS = { file: { name: 'File Errors', important: true },
                   log: { name: 'Log Format Errors', important: true },
                   ip4: { name: 'ip4 Address Format Errors', important: false },
                   ip6: { name: 'ip6 Address Format Errors', important: false },
                   ip: { name: 'ip Address Format Errors', important: false },
                   page: { name: 'Path Format Errors', important: false } }

end
