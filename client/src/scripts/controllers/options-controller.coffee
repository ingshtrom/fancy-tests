fancyTests.controller 'options-controller', [
  '$scope'
  'options-service'
  ($scope, _options) ->
    $scope.options = {}

    $scope.$on 'options.update',
      (event) ->
        console.log 'updating options'
        $scope.options = _options.options

    $scope.options = _options.options
]