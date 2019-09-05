$(document).ready(function(){
  $('#select_start_day').click(function(){
    var start_days = $('#tour_start_days').val();
    if( !start_days.includes('|' + $(this).val())){
        if(start_days.length == 0){
          start_days += $(this).val();
          $('#tour_start_days').val(start_days)
        }
        else{
          start_days += '|' + $(this).val() + ''
          $('#tour_start_days').val(start_days)
        }
    }
    else{
      start_days = start_days.replace('|' + $(this).val(), '');
      $('#tour_start_days').val(start_days)
    }
  });
});
