// listen to shiny output events
$(document).on('shiny:value', function(event) {  
  // for gt_out events
  if (event.target.id === 'gt_out') {
    const id = 'gt_out';
    
    // generate a 100 point color gradient
    const gradientArray = new Gradient()
      .setColorGradient("#000000", "00FF00")
	    .setMidpoint(100);
    
    // temporarily place the freshly rendered table into the #gtout 
    // div to be replaced later with the modified version
    $( '#' + id ).html(event.value.html);
    
    // for each bar element
    $( "#" + id + " > div > table > tbody > tr > td[headers='x'] > div > div" )
      .each(function() {
        // calculate rendered width as a percent
        var p = $( this ).width() / $( this ).parent().width();
	      
	      // retrive the corresponding color
	      var i = Math.round(100 * p);
	      var b = gradientArray.getColor(i);
        
        // set bar color
        $( this ).css('background', b);
      });
    
    // copy modified table back to event data to allow 
    // default processing to use our modified table
    event.value.html = $( '#' + id ).html();
  }
});
