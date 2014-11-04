// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
	$( "#item_in_date" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#item_start_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#item_end_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
});

$(function() {
  $('#item_name').change(function (){
  	$('#item_field_changed').val('item_name');
    $.get(window.location, $('form').serialize(), null, "script");
    return false;
  });
});