fancyTests = angular.module 'fancy-tests', [
  'ui.bootstrap'
  'ngRoute'
  'ngAnimate'
]

fancyTests.config [
  '$routeProvider'
  '$locationProvider'
  ($route, $location) ->
    $route
      .when '/', {templateUrl: 'main.html', controller: 'main-controller'}
      .otherwise {redirectTo: '/'}
    $location.html5Mode true
]