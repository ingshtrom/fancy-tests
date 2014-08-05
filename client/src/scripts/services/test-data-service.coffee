fancyTests.service 'test-data-service', [
  '$rootScope'
  '$http'
  ($rootScope, $http) ->
    service =
      # TestData[]
      testData: []

      # update testData with data from the server
      getTestData: () ->
        # MOCK UPDATE
        service.testData = [
          new TestData('test1', [], [], '', '', 'suite1'),
          new TestData('test2', [], [], '', '', 'suite2'),
          new TestData('test3', [], [], '', '', 'suite3'),
          new TestData('test4', [], [], '', '', 'suite4'),
          new TestData('test5', [], [], '', '', 'suite5'),
          new TestData('test6', [], [], '', '', 'suite6'),
          new TestData('test7', [], [], '', '', 'suite7'),
          new TestData('test8', [], [], '', '', 'suite8'),
          new TestData('test9', [], [], '', '', 'suite9')
        ]

        $rootScope.$broadcast 'testData.update'
    return service
]