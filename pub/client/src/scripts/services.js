fancyTests.service('options-service', [
  '$rootScope', '$http', function($rootScope, $http) {
    var service;
    service = {
      options: {
        xAxis: [],
        yAxis: [],
        tags: [],
        attributes: [],
        suites: []
      },
      selected: {
        xAxis: '',
        yAxis: '',
        tags: [],
        attributes: [],
        suites: []
      },
      updateOptions: function() {
        service.options.xAxis = ['build', 'suite', 'test', 'browser'];
        service.options.yAxis = ['duration', 'passRate', 'executions'];
        service.options.tags = ['tag1', 'tag2', 'tag3'];
        service.options.attributes = [
          {
            'browser': 'chrome'
          }, {
            'browser': 'firefox'
          }, {
            'browser': 'internetexplorer'
          }
        ];
        service.options.suites = ['1234', '2345', '3456'];
        service.selected.xAxis = 'build';
        service.selected.yAxis = 'duration';
        service.options.tags = [];
        service.options.attributes = [];
        service.options.suites = [];
        return $rootScope.$broadcast('options.update');
      }
    };
    service.updateOptions();
    return service;
  }
]);

fancyTests.service('test-data-service', [
  '$rootScope', '$http', function($rootScope, $http) {
    var service;
    service = {
      testData: [],
      getTestData: function() {
        service.testData = [new TestData('test1', [], [], '', '', 'suite1'), new TestData('test2', [], [], '', '', 'suite2'), new TestData('test3', [], [], '', '', 'suite3'), new TestData('test4', [], [], '', '', 'suite4'), new TestData('test5', [], [], '', '', 'suite5'), new TestData('test6', [], [], '', '', 'suite6'), new TestData('test7', [], [], '', '', 'suite7'), new TestData('test8', [], [], '', '', 'suite8'), new TestData('test9', [], [], '', '', 'suite9')];
        return $rootScope.$broadcast('testData.update');
      }
    };
    return service;
  }
]);
