module Constants

  DEFAULT_OPTIONS = { ip_validation: :ip4,
                      path_validation: true,
                      page_views: true,
                      unique_page_views: true,
                      file: 'webserver.log'}

  OUTPUT_COLORS = { title: :cyan,        # can be :black, :red, :green, :yellow,
                    line_break: :yellow, # :blue, :magenta, :cyan, :gray, :white
                    columns: [:gray, :green, :red], # if more columns,
                    log: :cyan }                    # final color will be used

  WARNING_COLORS = { true => :red,      #important warnings color
                     false => :yellow } #non-important warnings color

  WARNING_NAMES = { log: 'log',
                    ip4: 'ip4 address',
                    ip6: 'ip6 address',
                    ip4_ip6: 'ip address',
                    path: 'path' }

  LOG_WARNINGS = { file: { name: 'File Error', important: true },
                   log: { name: 'Log Format Error', important: true },
                   ip4: { name: 'Ip4 Address Format Error', important: false },
                   ip6: { name: 'Ip6 Address Format Error', important: false },
                   ip: { name: 'Ip Address Format Error', important: false },
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
