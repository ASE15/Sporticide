jQuery(function(){
  var $rows = $('.table .table-row');
  $('.training-type').change(function() {
      if($(this).val() == "all") {
          $rows.show();
      }
      else {
          var val = '^(?=.*\\b' + $.trim($(this).val()).split(/\s+/).join('\\b)(?=.*\\b') + ').*$',
              reg = RegExp(val, 'i'),
              text;

          $rows.show().filter(function() {
              text = $(this).find(".sport-entry").text().replace(/\s+/g, ' ');
              return !reg.test(text);
          }).hide();
    }
  });
  
  $('.location').change(function() {
      if($(this).val() == "all") {
          $rows.show();
      }
      else {
          var val = '^(?=.*\\b' + $.trim($(this).val()).split(/\s+/).join('\\b)(?=.*\\b') + ').*$',
              reg = RegExp(val, 'i'),
              text;

          $rows.show().filter(function() {
              text = $(this).find(".location-entry").text().replace(/\s+/g, ' ');
              return !reg.test(text);
          }).hide();
    }
  });
  
});
