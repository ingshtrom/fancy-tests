fancyTests.service 'options-service', [
  '$rootScope'
  '$http'
  ($rootScope, $http) ->
    service =
      options:
        # string[] => list of possible x-axis labels
        xAxis: []

        # string[] => list of possible y-axis labels
        yAxis: []

        # string[] => list of possible tags
        tags: []

        # object[] => list of attribute KVPs
        attributes: []

        # string[] => list of suite ids
        suites: []

      selected:
        # string => x-axis selected option
        xAxis: ''

        # string => y-axis selected option
        yAxis: ''

        # string[] => selected tags
        tags: []

        # object[] => selected attribute KVPs
        attributes: []

        # string[] => selected feature suites
        suites: []

      updateOptions: () ->
        # MOCK UPDATE
        service.options.xAxis = ['build', 'suite', 'test', 'browser']
        service.options.yAxis = ['duration', 'passRate', 'executions']
        service.options.tags = ['tag1', 'tag2', 'tag3']
        service.options.attributes = [
          {'browser': 'chrome'},
          {'browser': 'firefox'},
          {'browser': 'internetexplorer'}
        ]
        service.options.suites = ['1234', '2345', '3456']

        service.selected.xAxis = 'build'
        service.selected.yAxis = 'duration'
        service.options.tags = []
        service.options.attributes = []
        service.options.suites = []

        $rootScope.$broadcast 'options.update'

    service.updateOptions()
    return service
]