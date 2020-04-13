$(document).on('turbolinks:load', function() {
  var DATA_COUNT = 5;
  var utils = Samples.utils;
  utils.srand(110);

  function colorize(opaque, hover, ctx) {
    var v = ctx.dataset.data[ctx.dataIndex];
    var c = v < -50 ? '#D60000'
    : v < 0 ? '#F46300'
    : v < 50 ? '#0358B6'
    : '#44DE28';

    var opacity = hover ? 1 - Math.abs(v / 150) - 0.2 : 1 - Math.abs(v / 150);

    return opaque ? c : utils.transparentize(c, opacity);
  }

  function hoverColorize(ctx) {
    return colorize(false, true, ctx);
  }

  function generateData() {
    return utils.numbers({
      count: DATA_COUNT,
      min: -100,
      max: 100
    });
  }

  var configuratorStep = 0

  var options = {
    tooltips: {
      enabled: false
    },
    legend: {
      display: false
    },
    plugins: {
      datalabels: {
        color: 'white',
        borderColor: 'white',
        // borderWidth: 2,
        // borderRadius: 25,
        formatter: function(value, context) {
          return context.chart.data.datasets[configuratorStep].labels[context.dataIndex];
        }
      }
    },

    elements: {
      arc: {
        borderWidth: 0,
        hoverBorderWidth: 0,
        backgroundColor: colorize.bind(null, false, false),
        hoverBackgroundColor: hoverColorize
      }
    }
  };

  var canvas = document.getElementById("chart-0");
  var exposure = {
    'privacy' : 100,
    'notifications' : 200,
    'reachability' : 300,
  }

  var data = {
    datasets: [
      {
        data: Object.values(exposure),
        labels: Object.keys(exposure)
      }
    ]
  };

  canvas.onclick = function(evt) {
    var activePoints = chart.getElementsAtEvent(evt);
    if (activePoints[0]) {
      var chartData = activePoints[0]['_chart'].config.data;
      var idx = activePoints[0]['_index'];
      addDataset()
    } else if (data.datasets.length == 1) {
      return;
    } else { removeDataset();}
  };


  var chart = new Chart('chart-0', {
    type: 'pie',
    data: data,
    options: options
  });

  $('#addDataset').click(function() {
    addDataset();
  });

  $('#removeDataset').click(function() {
    removeDataset();
  });

  $('#togglePieDoughnut').click(function() {
    togglePieDoughnut();
  });

  function addDataset() {
    chart.data.datasets.unshift({
      data: generateData()
    });
    chart.update();
  }

  function removeDataset() {
    chart.data.datasets.shift();
    chart.update();
  }


  // eslint-disable-next-line no-unused-vars
  // function togglePieDoughnut() {
  //   if (chart.options.cutoutPercentage) {
  //     chart.options.cutoutPercentage = 0;
  //   } else {
  //     chart.options.cutoutPercentage = 50;
  //   }
  //   chart.update();
  // }
  // // eslint-disable-next-line no-unused-vars
  // $('#randomize').click(function() {
  //   randomize();
  // });

  // $('#chart-0').append("<p>Test</p>")
  // function randomize() {
  //   chart.data.datasets.forEach(function(dataset) {
  //     dataset.data = generateData();
  //   });
  //   chart.update();
  // }
});