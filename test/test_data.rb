module TestData

  LOG_INFO = { "/home" => [['1.1.1.1'],['2.2.2.2']],
               "/about" => [['1.1.1.1'],['1.1.1.1'],['2.2.2.2']], }

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

  INPUT2 = { title: 'Page Visits',
             descriptor: ['', 'egg', 'cat', 'bowl'],
             info: [["/home", 1, 2, 3 ],
                    ["/about", 1, 2, 3 ]]
           }

  OUTPUT = ['-----------',
            'Page Visits',
            '-----------',
           ['/about', '1 egg', '2 cats', '3 bowls'],
           ['/home', '1 egg', '2 cats', '3 bowls']]

end
