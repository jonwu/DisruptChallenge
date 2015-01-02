function initializeBar(data, ctx) {
	var myBardChart = new Chart(ctx).Bar(data, null);
	// legend(document.getElementById("legend"), colors)
}

$(document).ready(function() {
    $('.content-wrapper').scrollToFixed( { marginTop: 10 } );
});	


