$(document).ready(function(){
  $('#price_from').change(function(){
    $('#price_val_from').html($(this).val());
  });

  $('#price_to').change(function(){
    $('#price_val_to').html($(this).val());
  });
});
