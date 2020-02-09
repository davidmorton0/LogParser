module Constants
  
  INFO_TITLES = { visits: 'Page Visits',
                  unique_views: 'Unique Page Views' }

  DESCRIPTORS = { visits: ['', 'visit'],
                  unique_views: ['', 'unique view'] }

  LOG_PATTERN = '(\/\w+)(\/?\d*)\s([\d.]+)'

  LOG_WARNINGS = { file: { name: 'File Error', important: true },
                   log: { name: 'Log Format Error', important: true },
                   ip4: { name: 'ip4 Address Format Error', important: false },
                   ip6: { name: 'ip6 Address Format Error', important: false },
                   page: { name: 'Webpage Format Error', important: false } }
end
