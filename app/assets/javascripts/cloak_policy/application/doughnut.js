$(document).on('turbolinks:load', function() {

  var sampleDatasets = {
    datasets: [
      {
        data: [100,200,3000],
        labels: ['red', 'yellow', 'blue']
      },
      {
        data: [100,200,300],
        labels: ['green', 'brown', 'purple']
      },
      {
        data: [100,200,300],
        labels: ['bill', 'bobo', 'ted']
      }

    ]
  }

  const exposure = [
    {
      'name' : 'privacy',
      'weight' : 100,
      'subvectors' : [
        {
          'name' : 'locatability',
          'weight' : 300,
          'subvectors' : [
            {
              'name' : 'address',
              'weight' : 20,
              'subvectors' : []
            },
            {
              'name' : 'ip address',
              'weight' : 40,
              'subvectors' : []
            }
          ]
        },
        {
          'name' : 'sharability',
          'weight' : 400,
          'subvectors' : []
        }
      ]
    },
    {
      'name' : 'notifiability',
      'weight' : 200,
      'subvectors' : []
    }
  ]
  var DATA_COUNT = 5;

  var utils = Samples.utils;

  utils.srand(110);

  function getValuesAt(object, key) {
    array = []
    object.filter(function(e) {
      array.push(e[key])
    });
    return array;
  }

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

  var matrixPosition = [0,0]

  var initialDataset = {
    data: [100],
    labels: ['GET YOUR CLOAK ON'],
    borderWidth: [0],
    backgroundColor: ['#DCDCDC'],
    hoverBackgroundColor: ['#ADD8E6']
  }

  var backDataset = {
    data: [100],
    labels: ['START OVER'],
    borderWidth: [0],
    backgroundColor: ['#DCDCDC'],
    hoverBackgroundColor: ['#ADD8E6']
  }

  var data = sampleDatasets;
  // var data = { datasets: [ initialDataset ] };


  function getDataset(jsObject) {
    hash = {
      data: getValuesAt(jsObject, 'weight'),
      labels: getValuesAt(jsObject, 'name'),
      borderWidth: 0,
      hoverBorderWidth: 0,
    }
    return hash
  }

  function storeMatrixCoordinates(index, datasetIndex, activePoint) {
    console.log("index: " + index)
    console.log("datasetIndex: " + datasetIndex)
    console.log(activePoint._chart.config.data.datasets[datasetIndex].labels[index])

  }
  var options = {
    onClick: function(e) {
      var activePoint = this.getElementAtEvent(e)[0];
      var index = activePoint._index;
      var datasetIndex = activePoint._datasetIndex;
      storeMatrixCoordinates(index, datasetIndex, activePoint)
    },
    legend: false,
    tooltips: false,
    plugins: {
      datalabels: {
        color: 'white',
        borderColor: 'white',
        borderWidth: 2,
        borderRadius: 25,
        formatter: function(value, context) {
          label = context.chart.data.datasets[context.datasetIndex].labels[context.dataIndex];
          // label =  context.chart.data.datasets[context.dataIndex].labels[context.datasetIndex]
          // console.log(label)
          return label

          // return context.chart.data.datasets[0].labels[context.dataIndex];
        }
      }
    },

    elements: {
      arc: {
        // borderWidth: 0,
        // hoverBorderWidth: 0,
        backgroundColor: colorize.bind(null, false, false),
        hoverBackgroundColor: hoverColorize
      }
    }
  };
  var canvas = document.getElementById("chart-0");

  // canvas.onclick = function(evt) {
  //   var activePoints = chart.getElementsAtEvent(evt);
  //   if (activePoints[0]) {
  //     var chartData = activePoints[0]['_chart'].config.data;
  //     var idx = activePoints[0]['_index'];

  //     var label = chartData.datasets[0].labels[idx];
  //     var value = chartData.datasets[0].data[idx];
  //     var node = exposure.find(o => o['name'] === label)
  //     loggable(activePoints[0])
  //     loggable(activePoints[1])
  //     loggable(activePoints[2])
  //     // console.log(evt)
  //     // loggable(activePoints[3])
  //     // console.log(activePoints[0], activePoints[1])
  //     // console.log(activePoints[1])
  //     // console.log(activePoints[2])
  //     // console.log(activePoints[3])
  //     // console.log(activePoints)
  //     // addDataset(node)

  //   } else if (data.datasets.length == 1) {
  //     return;
  //   } else { removeDataset();}
  // };

  function loggable(point) {
    console.log(point['_datasetIndex'])

  }

  var chart = new Chart('chart-0', {
    type: 'pie',
    data: data,
    options: options
  });

  function addDataset(exposureObject) {
    chart.data.datasets.unshift( getDataset(exposureObject.subvectors));
    chart.update();
  }























  function removeDataset() {
    chart.data.datasets.shift();
    chart.update();
  }

  function togglePieDoughnut() {
    if (chart.options.cutoutPercentage) {
      chart.options.cutoutPercentage = 0;
    } else {
      chart.options.cutoutPercentage = 50;
    }
    chart.update();
  }

  $('#addDataset').click(function() {
    addDataset();
  });

  $('#removeDataset').click(function() {
    removeDataset();
  });

  $('#togglePieDoughnut').click(function() {
    togglePieDoughnut();
  });

  function randomize() {
    chart.data.datasets.forEach(function(dataset) {
      dataset.data = generateData();
    });
    chart.update();
  }
});