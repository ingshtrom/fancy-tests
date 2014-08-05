var fancyTests;

fancyTests = angular.module('fancy-tests', ['ui.bootstrap', 'ngRoute', 'ngAnimate']);

fancyTests.config([
  '$routeProvider', '$locationProvider', function($route, $location) {
    $route.when('/', {
      templateUrl: 'main.html',
      controller: 'main-controller'
    }).otherwise({
      redirectTo: '/'
    });
    return $location.html5Mode(true);
  }
]);
