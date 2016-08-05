// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
	$( "#item_in_date" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#start_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
	$( "#end_date_s" ).datepicker({dateFormat: 'yy-mm-dd'});
});

$(function() {
  $('#item_name_autocomplete').change(function (){
  	$('#item_field_changed').val('item_name');
    $.get(window.location, $('form').serialize(), null, "script");
    return false;
  });
});

$(function() {
  $(document).on('change', '#whs_id', function (){  //only document/'body' works with every change. ('#whs_id') only works once.
     // alert("fire");
  	$.get(window.location, {whs_id: $('#whs_id').val(), field_changed: 'whs_id'}, null, "script");
    return false;
  });
});

$(function() {
    $('#item_name_autocomplete').autocomplete({
        minLength: 1,
        source: $('#item_name_autocomplete').data('autocomplete-source'),  //'#..' can NOT be replaced with this
        select: function(event, ui) {
            //alert('fired!');
            $(this).val(ui.item.value);
        },
    });
});