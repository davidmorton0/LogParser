module TestData

  LOG_INFO = { "/home" => [['1.1.1.1'],['2.2.2.2']],
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
