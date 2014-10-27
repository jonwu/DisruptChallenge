

var data = {
    labels: ["Eating", "Drinking", "Sleeping", "Designing", "Coding", "Cycling", "Running"],
    datasets: [
        {
            label: "My First dataset",
            fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [100, 59, 90, 81, 56, 55, 40]
        },
        {
            label: "My Second dataset",
            fillColor: "rgba(151,187,205,0.2)",
            strokeColor: "rgba(151,187,205,1)",
            pointColor: "rgba(151,187,205,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
            data: [28, 48, 40, 19, 96, 27, 100]
        }
    ]
};

jQuery(document).ready(function($) {
	// var ctx = $("#myChart").get(0).getContext("2d");
	// initializeRadar(data,ctx)
});


/**
 * initialize a Radar chart
 * @param  {hashmap} data
 * @param  {class} ctx
 * @param  {hashmap} options
 * @return {void}
 */
function initializeRadar(data, ctx, options){
	options = typeof options !== 'undefined' ? options : null;
	var myRadarChart = new Chart(ctx).Radar(data, options);
}
