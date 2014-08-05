fancyTests.controller 'chart-controller', [
  '$scope'
  ($scope) ->
    chartSelectors = ['#main-chart']
    parentSelector = '.chart-container'

    # mock data
    mockData =
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
        },
        {
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

    mockOptions =
      scaleShowGridLines : true
      scaleGridLineColor : "rgba(0,0,0,.05)"
      scaleGridLineWidth : 1
      bezierCurve : false
      bezierCurveTension : 0.4
      pointDot : true
      pointDotRadius : 4
      pointDotStrokeWidth : 1
      pointHitDetectionRadius : 20
      datasetStroke : true
      datasetStrokeWidth : 2
      datasetFill : true
      legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].lineColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>"

    # get the context for a canvas chart given a selector
    # selectorOrObj: optional ways to select an element
    getChartContext = (selectorOrObj) ->
      if _.isObject(selectorOrObj)
        selectorOrObj.getContext('2d')
      else
        $(selectorOrObj).get(0).getContext('2d')

    # load a line chart
    # ctx: chart context obj
    # data: data to plot on the chart
    # options: options for the chart
    loadChart = (ctx, data, options) ->
      # initialize the chart upon loading
      chart = new Chart(ctx).Line(data, options)

    resizeHandler = () ->

    # bind an event handler to window.resize so that
    # we automatically reize the chart to the parent's size
    bindResizeHandler = (chartObj) ->
      resizeHandler = () ->
        parent = chartObj.parent(parentSelector)
        console.log(parent.width())
        console.log(parent.height())
        chartObj.width(parent.width())
        chartObj.height(parent.height())
      chartObj = $(chartObj)
      resizeHandler()   # call it once to set the size initially
      $(window).resize(resizeHandler)

    _.each chartSelectors,
    (sel) ->
      obj = $(sel)
      ctx = getChartContext(sel)
      loadChart(ctx, mockData, mockOptions)
      # TODO(alex.hokanson): if we are going to do this, we need to fix the scaling issue. Right now it blindly blows up the resolution
      # I think what we need to do is just set the width based on the number of data points
      bindResizeHandler(obj)
]