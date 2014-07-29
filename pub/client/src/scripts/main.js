var fancyTests;

fancyTests = angular.module('fancy-tests', ['ui.bootstrap', 'ngRoute', 'ngAnimate', 'fancy-tests.services', 'fancy-tests.filters', 'fancy-tests.controllers']);

fancyTests.config([
  '$routeProvider', '$locationProvider', function($route, $location) {
    $route.when('/', {
      templateUrl: 'main.html',
      controller: 'MainController'
    }).otherwise({
      redirectTo: '/'
    });
    return $location.html5Mode(true);
  }
]);
