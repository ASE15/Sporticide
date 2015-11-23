jQuery(function(){
  var $rows = $('.table .table-row');
  $('.training-type').change(function() {
      show();
  });
  
  function show(line) {
      var t_type_reg = reg_exp('.training-type');
      var t_type_all = is_all('.training-type');
      var location_reg = reg_exp('.location');
      var location_all = is_all('.location');
      var recurrence_reg = reg_exp('.recurrence');
      var recurrence_all = is_all('.recurrence');
      
      $rows.show().filter(function() {
          return filter(this, t_type_all, t_type_reg, ".sport-entry") 
          || filter(this, location_all, location_reg, ".location-entry") 
          || filter(this, recurrence_all, recurrence_reg, ".recurrence-entry") ;
      }).hide();
  }
  
  function is_all(class_name) {
    return $(class_name).val() == "all"
  }
  
  function filter(line, all, reg, entry_class) {
    var text = $(line).find(entry_class).text().replace(/\s+/g, ' ');
    return !reg.test(text) && !all;
  }
  
  function reg_exp(class_name) {
      var val = '^(?=.*\\b' + $.trim($(class_name).val()).split(/\s+/).join('\\b)(?=.*\\b') + ').*$';
      return RegExp(val, 'i');
  }
  
  $('.location').change(function() {
     show();
  });
  
  $('.recurrence').change(function() {
     show();
  });
  
  $("#start-date-input").datepicker({
        onSelect: function(date) {
          $rows.show().filter(function() {
              var start_date = new Date($(this).find(".start-entry").attr("data-date"));
              var selected_start_date = $.datepicker.parseDate( "mm/dd/yy", date);
              var selected_end_date = $("#end-date-input").datepicker("getDate");
              start_date.setMinutes(start_date.getMinutes()+selected_start_date.getTimezoneOffset());
              
              var shouldShow = true
              if(selected_start_date && !isNaN(selected_start_date.getTime())) {
                shouldShow = shouldShow && selected_start_date <= start_date;
              }
              
              if(selected_end_date && !isNaN(selected_end_date.getTime())) {
                shouldShow = shouldShow && selected_end_date >= start_date
              }
              
              return !shouldShow;
          }).hide();
        },
      });
      
  $("#end-date-input").datepicker({
        onSelect: function(date) {
          $rows.show().filter(function() {
              var selected_end_date = $("#end-date-input").datepicker("getDate");
              var selected_start_date = $("#start-date-input").datepicker("getDate");
              var start_date = new Date($(this).find(".start-entry").attr("data-date"));
              start_date.setMinutes(start_date.getMinutes()+selected_start_date.getTimezoneOffset());
              
              var shouldShow = true
              if(selected_start_date && !isNaN(selected_start_date.getTime())) {
                shouldShow = shouldShow && selected_start_date <= start_date;
              }
              
              if(selected_end_date && !isNaN(selected_end_date.getTime())) {
                shouldShow = shouldShow && selected_end_date >= start_date
              }
              
              return !shouldShow;
          }).hide();
        },
      });
  
  $("#start-date-clear").click(function(){
    $rows.show()
    $("#start-date-input").val('');
  });
  
  $("#end-date-clear").click(function(){
    $("#end-date-input").val('');
  });
});
