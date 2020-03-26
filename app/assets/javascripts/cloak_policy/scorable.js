$(document).on('turbolinks:load', function() {


  const borderColor = [
    'rgba(255, 99, 132, 1)',
    'rgba(54, 162, 235, 1)',
    'rgba(255, 206, 86, 1)',
    'rgba(75, 192, 192, 1)',
    'rgba(153, 102, 255, 1)',
    'rgba(255, 99, 132, 1)',
    'rgba(54, 162, 235, 1)',
    'rgba(255, 206, 86, 1)',
    'rgba(75, 192, 192, 1)',
    'rgba(153, 102, 255, 1)',
    'rgba(255, 99, 132, 1)',
    'rgba(54, 162, 235, 1)',
    'rgba(255, 206, 86, 1)',
    'rgba(75, 192, 192, 1)',
    'rgba(153, 102, 255, 1)',
    'rgba(255, 99, 132, 1)',
    'rgba(54, 162, 235, 1)',
    'rgba(255, 206, 86, 1)',
    'rgba(75, 192, 192, 1)',
    'rgba(153, 102, 255, 1)',
    'rgba(255, 99, 132, 1)',
    'rgba(54, 162, 235, 1)',
    'rgba(255, 206, 86, 1)',
    'rgba(75, 192, 192, 1)',
    'rgba(153, 102, 255, 1)',
    'rgba(255, 99, 132, 1)',
    'rgba(54, 162, 235, 1)',
    'rgba(255, 206, 86, 1)',
    'rgba(75, 192, 192, 1)',
    'rgba(153, 102, 255, 1)' ]

  const backgroundColor =  [
    'rgba(255, 99, 132, 0.2)',
    'rgba(54, 162, 235, 0.2)',
    'rgba(255, 206, 86, 0.2)',
    'rgba(75, 192, 192, 0.2)',
    'rgba(153, 102, 255, 0.2)',
    'rgba(255, 99, 132, 0.2)',
    'rgba(54, 162, 235, 0.2)',
    'rgba(255, 206, 86, 0.2)',
    'rgba(75, 192, 192, 0.2)',
    'rgba(153, 102, 255, 0.2)',
    'rgba(255, 99, 132, 0.2)',
    'rgba(54, 162, 235, 0.2)',
    'rgba(255, 206, 86, 0.2)',
    'rgba(75, 192, 192, 0.2)',
    'rgba(153, 102, 255, 0.2)',
    'rgba(255, 99, 132, 0.2)',
    'rgba(54, 162, 235, 0.2)',
    'rgba(255, 206, 86, 0.2)',
    'rgba(75, 192, 192, 0.2)',
    'rgba(153, 102, 255, 0.2)',
    'rgba(255, 99, 132, 0.2)',
    'rgba(54, 162, 235, 0.2)',
    'rgba(255, 206, 86, 0.2)',
    'rgba(75, 192, 192, 0.2)',
    'rgba(153, 102, 255, 0.2)',
    'rgba(255, 99, 132, 0.2)',
    'rgba(54, 162, 235, 0.2)',
    'rgba(255, 206, 86, 0.2)',
    'rgba(75, 192, 192, 0.2)',
    'rgba(153, 102, 255, 0.2)'
  ]

  // function getDataSet() {

    // const ctx = document.getElementById('scoreChart');
    // const scoreChart = document.getElementById('scoreChart')
    // const data = {
    //   labels: JSON.parse(scoreChart.dataset.labels),
    //   datasets: [{
    //     label: scoreChart.dataset.label,
    //     data: JSON.parse(scoreChart.dataset.scores),
    //     backgroundColor: backgroundColor,
    //     borderColor: borderColor
    //   }]
    // }
  // }

  if ($('#polarChart').length > 0) {
    const ctx = document.getElementById('scoreChart');
    const scoreChart = document.getElementById('scoreChart')
    const data = {
      labels: JSON.parse(scoreChart.dataset.labels),
      datasets: [{
        label: scoreChart.dataset.label,
        data: JSON.parse(scoreChart.dataset.scores),
        backgroundColor: backgroundColor,
        borderColor: borderColor
      }]
    }// getDataSet();
    var myChart = new Chart(ctx, {
      type: 'polarArea',
      data: data,
      options: {
        legend: {
          display: true,
        }
      }
    });
  }

  if ($('#barChart').length > 0) {
    const ctx = document.getElementById('scoreChart');
    const scoreChart = document.getElementById('scoreChart')
    const data = {
      labels: JSON.parse(scoreChart.dataset.labels),
      datasets: [{
        label: scoreChart.dataset.label,
        data: JSON.parse(scoreChart.dataset.scores),
        backgroundColor: backgroundColor,
        borderColor: borderColor
      }]
    }
    // getDataSet();
    var myChart = new Chart(ctx, {
      type: 'bar',
      data: data,
      options: {
        scales: {
          yAxes: [{
              ticks: {
                  beginAtZero: true,
                  suggestedMax: 100
              }
          }]
        }
      }
    });
  }
});