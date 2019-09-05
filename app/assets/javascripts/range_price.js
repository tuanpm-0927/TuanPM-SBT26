$(document).ready(function(){
  $('#search_price_from').change(function(){
    $('#price_val_from').html($(this).val());
  });

  $('#search_price_to').change(function(){
    $('#price_val_to').html($(this).val());
  });
});
