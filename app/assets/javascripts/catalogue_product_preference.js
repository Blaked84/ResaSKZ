$(document).ready(function() {
  $(function() {
    $('select.select_preference').change(function() {
      var id = $(this).data('product');
      $("#submitPreference_"+id).trigger('click');
    })
  })
})
