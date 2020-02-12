module TestData

#ParserTest Data
  LOG_DATA = { "/home" => [['1.1.1.1'],['2.2.2.2']],
               "/about" => [['1.1.1.1'],['1.1.1.1'],['2.2.2.2']] }

  PROCESSED_LOG = { "/home" => { visits: 2, unique_views: 2 },
                    "/about" => { visits: 3, unique_views: 2 } }

  PAGE_VISITS = { title: 'Page Visits',
                  descriptor: ['', 'visit'],
                  info: [["/home", 2],
                         ["/about", 3]] }

  UNIQUE_PAGE_VIEWS = { title: 'Unique Page Views',
                        descriptor: ['', 'unique view'],
                        info: [["/home", 2],
                               ["/about", 2]] }

#FormatterTest Data
  TEST_LOG_INFO_1 = { files_read: ['filename.log'],
                      logs_read: 120,
                      logs_added: 80,
                      warnings: [{ type: :warning_type,
                                   message: 'An error occured' }] }

  TEST_INFO_OUTPUT_1 = ["\nFiles read: #{File.absolute_path('filename.log')}",
                        "Logs read: 120",
                        "Logs added: 80"].join("\n")

  TEST_LOG_INFO_2 = { files_read: ['filename.log', 'filename2.log'],
                      logs_read: 120,
                      logs_added: 80 }

  TEST_INFO_OUTPUT_2 = ["\nFiles read: #{File.absolute_path('filename.log')},",
                        "#{File.absolute_path('filename2.log')}",
                        "Logs read: 120",
                        "Logs added: 80"].join("\n")

  TEST_WARNINGS_1 = [{ type: :log, message: 'An error occured' },
                     { type: :path, message: 'Another error occured' },
                     { type: :log, message: 'A third error occured' }]

  TEST_WARNING_QUIET_1 = "\n" + ['Log Format Error: An error occured',
                         'Log Format Error: A third error occured'].join("\n") + "\n"

  TEST_WARNING_STD_1 = "\n" + ['File Errors: 0 warnings',
                       'Log Format Errors: 2 warnings',
                       'An error occured',
                       'A third error occured',
                       'Ip4 Address Format Errors: 0 warnings',
                       'Ip6 Address Format Errors: 0 warnings',
                       'Ip Address Format Errors: 0 warnings',
                       'Path Format Errors: 1 warning'].join("\n") + "\n"

  TEST_WARNING_VERBOSE_1 = "\n" + ['Log Format Error: An error occured',
                           'Path Format Error: Another error occured',
                           'Log Format Error: A third error occured'].join("\n") + "\n"

#WarningHanderTest Data
   WARNING_INFO = { warning_type_1: { name: 'Warning Type 1', important: false },
                    warning_type_2: { name: 'Warning Type 2', important: false },
                    warning_type_3: { name: 'Warning Type 3', important: true },
                    warning_type_4: { name: 'Warning Type 4', important: true },
                    warning_type_5: { name: 'Warning Type 5', important: true } }

   TEST_WARNINGS = [{ type: :warning_type_1, message: 'warning message 1' },
                    { type: :warning_type_2, message: 'warning message 2' },
                    { type: :warning_type_2, message: 'warning message 3' },
                    { type: :warning_type_2, message: 'warning message 3' },
                    { type: :warning_type_2, message: 'warning message 3' },
                    { type: :warning_type_3, message: 'warning message 4' },
                    { type: :warning_type_5, message: 'warning message 5' },
                    { type: :warning_type_5, message: 'warning message 6' }]

   WARNINGS_SUMMARY = ['Warning Type 1s: 1 warning',
                       'Warning Type 2s: 4 warnings',
                       'Warning Type 3s: 1 warning',
                       'warning message 4',
                       'Warning Type 4s: 0 warnings',
                       'Warning Type 5s: 2 warnings',
                       'warning message 5',
                       'warning message 6',]

   WARNINGS_IMPORTANT = ['Warning Type 3: warning message 4',
                         'Warning Type 5: warning message 5',
                         'Warning Type 5: warning message 6']

   WARNINGS_FULL = [ 'Warning Type 1: warning message 1',
                     'Warning Type 2: warning message 2',
                     'Warning Type 2: warning message 3',
                     'Warning Type 2: warning message 3',
                     'Warning Type 2: warning message 3',
                     'Warning Type 3: warning message 4',
                     'Warning Type 5: warning message 5',
                     'Warning Type 5: warning message 6' ]

#Output Formatter test data
  TEST_INFO_1 = { title: 'Info Title',
                          descriptor: ['', ''],
                          info: [['defgh', 1],
                                 ['bcde', 1],
                                 ['b', 1]] }

  TEST_OUTPUT_1 = ['----------',
                   'Info Title',
                   '----------',
                   'b 1',
                   'bcde 1',
                   'defgh 1']

 TEST_INFO_2 = { title: 'Info Title',
                 descriptor: ['', ''],
                 info: [['defgh', 2],
                        ['bcde', 3],
                        ['b', 1]] }

 TEST_OUTPUT_2 = ['----------',
                  'Info Title',
                  '----------',
                  'bcde 3',
                  'defgh 2',
                  'b 1',]

  TEST_INFO_3 = { title: 'Title',
                  descriptor: ['', 'egg', 'cat', 'bowl'],
                  info: [['info', 1, 1, 1 ],
                         ['more_info', 2, 3, 4 ]] }

  TEST_OUTPUT_3 = ['-----',
                   'Title',
                   '-----',
                   'more_info 2 eggs 3 cats 4 bowls',
                   'info 1 egg 1 cat 1 bowl']
end
