fancyTests.controller('chart-controller', [
  '$scope', function($scope) {
    var bindResizeHandler, chartSelectors, getChartContext, loadChart, mockData, mockOptions, parentSelector, resizeHandler;
    chartSelectors = ['#main-chart'];
    parentSelector = '.chart-container';
    mockData = {
      labels: ['100', '101', '102', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112', '113'],
      datasets: [
        {
          label: 'My First dataset',
          fillColor: 'rgba(220,220,220,0.2)',
          strokeColor: 'rgba(220,220,220,1)',
          pointColor: 'rgba(220,220,220,1)',
          pointStrokeColor: '#fff',
          pointHighlightFill: '#fff',
          pointHighlightStroke: 'rgba(220,220,220,1)',
          data: [65, 59, 80, 81, 56, 55, 40, 65, 59, 80, 81, 56, 55, 40]
        }, {
          label: 'My Second dataset',
          fillColor: 'rgba(151,187,205,0.2)',
          strokeColor: 'rgba(151,187,205,1)',
          pointColor: 'rgba(151,187,205,1)',
          pointStrokeColor: '#fff',
          pointHighlightFill: '#fff',
          pointHighlightStroke: 'rgba(151,187,205,1)',
          data: [28, 48, 40, 19, 86, 27, 90, 28, 48, 40, 19, 86, 27, 90]
        }
      ]
    };
    mockOptions = {
      scaleShowGridLines: true,
      scaleGridLineColor: "rgba(0,0,0,.05)",
      scaleGridLineWidth: 1,
      bezierCurve: false,
      bezierCurveTension: 0.4,
      pointDot: true,
      pointDotRadius: 4,
      pointDotStrokeWidth: 1,
      pointHitDetectionRadius: 20,
      datasetStroke: true,
      datasetStrokeWidth: 2,
      datasetFill: true,
      legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].lineColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>"
    };
    getChartContext = function(selectorOrObj) {
      if (_.isObject(selectorOrObj)) {
        return selectorOrObj.getContext('2d');
      } else {
        return $(selectorOrObj).get(0).getContext('2d');
      }
    };
    loadChart = function(ctx, data, options) {
      var chart;
      return chart = new Chart(ctx).Line(data, options);
    };
    resizeHandler = function() {};
    bindResizeHandler = function(chartObj) {
      resizeHandler = function() {
        var parent;
        parent = chartObj.parent(parentSelector);
        console.log(parent.width());
        console.log(parent.height());
        chartObj.width(parent.width());
        return chartObj.height(parent.height());
      };
      chartObj = $(chartObj);
      resizeHandler();
      return $(window).resize(resizeHandler);
    };
    return _.each(chartSelectors, function(sel) {
      var ctx, obj;
      obj = $(sel);
      ctx = getChartContext(sel);
      loadChart(ctx, mockData, mockOptions);
      return bindResizeHandler(obj);
    });
  }
]);

fancyTests.controller('main-controller', ['$scope', function($scope) {}]);

fancyTests.controller('options-controller', [
  '$scope', 'options-service', function($scope, _options) {
    $scope.options = {};
    $scope.$on('options.update', function(event) {
      console.log('updating options');
      return $scope.options = _options.options;
    });
    return $scope.options = _options.options;
  }
]);
