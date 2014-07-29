fancyTests = angular.module 'fancy-tests', [
  'ui.bootstrap'
  'ngRoute'
  'ngAnimate'
  'fancy-tests.services'
  'fancy-tests.filters'
  'fancy-tests.controllers'
]

fancyTests.config [
  '$routeProvider'
  '$locationProvider'
  ($route, $location) ->
    $route
      .when '/', {templateUrl: 'main.html', controller: 'MainController'}
      .otherwise {redirectTo: '/'}
    $location.html5Mode true
]