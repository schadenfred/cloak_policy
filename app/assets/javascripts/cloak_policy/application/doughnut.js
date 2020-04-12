$(document).on('turbolinks:load', function() {
  Chart.pluginService.register({
    beforeDraw: function (chart) {
        if (chart.options.centertext) {
            var width = chart.chart.width,
                    height = chart.chart.height,
                    ctx = chart.chart.ctx;

            ctx.restore();
            var fontSize = (height / 280).toFixed(2); // was: 114
            ctx.font = fontSize + "em sans-serif";
            ctx.textBaseline = "middle";

            var text = chart.options.centertext, // "75%",
                    textX = Math.round((width - ctx.measureText(text).width) / 2),
                    textY = height / 2 - (chart.titleBlock.height - 15);

            ctx.fillText(text, textX, textY);
            ctx.save();
        }
    }
  });
  var exposure = {
    'red' : 10,
    'yellow' : 20,
    'blue' : 30
  }

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
  var data = {
    datasets: [
      { data: [ 10,20,30],
      // },
      // { data: [ 40,50,60],
    }
  ],
    labels: [
      'Red',
      'Yellow',
      'Blue'
    ]
  };

  var options = {
    tooltips: {
      enabled: true,
    },
    // title: {
    //   display: true,
    //   position: "bottom",
    //   text: 'Upcoming Meetings'
    // },
    legend: {
      display: true,
    },
    centertext: "back",
    elements: {
      arc: {
        backgroundColor: colorize.bind(null, false, false),
        hoverBackgroundColor: hoverColorize
      }
    }
  };


  var canvas = document.getElementById("chart-0");

  canvas.onclick = function(evt) {
    var activePoints = chart.getElementsAtEvent(evt);
    // debugger
    // console.log(activePoints);
    console.log(data.datasets.length)
    if (activePoints[0]) {
      var chartData = activePoints[0]['_chart'].config.data;
      var idx = activePoints[0]['_index'];

      var label = chartData.labels[idx];
      var value = chartData.datasets[0].data[idx];
      addDataset()
      var url = "http://example.com/?label=" + label + "&value=" + value;
      // console.log(url);
      // alert(url);

    } else if (data.datasets.length == 1) {
      return;
    } else {
      removeDataset();
    }
  };


  var chart = new Chart('chart-0', {
    type: 'pie',
    data: data,
    options: options
  });

  $('#addDataset').click(function() {
    addDataset();
  });

  // eslint-disable-next-line no-unused-vars
  function addDataset() {
    chart.data.datasets.unshift({
      data: generateData()
    });
    chart.update();
  }

  $('#removeDataset').click(function() {
    removeDataset();
  });
  // eslint-disable-next-line no-unused-vars
  function removeDataset() {
    chart.data.datasets.shift();
    chart.update();
  }


  $('#togglePieDoughnut').click(function() {
    togglePieDoughnut();
  });
  // eslint-disable-next-line no-unused-vars
  function togglePieDoughnut() {
    if (chart.options.cutoutPercentage) {
      chart.options.cutoutPercentage = 0;
    } else {
      chart.options.cutoutPercentage = 50;
    }
    chart.update();
  }
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