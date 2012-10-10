$(function(){
  var img = 'img#rectangle'
  var x1 = $(img).data('x1');
  var y1 = $(img).data('y1');
  var x2 = $(img).data('x2');
  var y2 = $(img).data('y2');

  var jcrop_api;
  $(img).Jcrop({
    onChange: update_rect,
    onSelect: update_rect,
    setSelect: [x1||100, y1||100, x2||200, y2||200],
  }, function(){
    jcrop_api = this;
  });

  $('div#translations').delegate('form.edit_translation', 'mouseenter', function(){
    var x1 = $(this).data('x1');
    var y1 = $(this).data('y1');
    var x2 = $(this).data('x2');
    var y2 = $(this).data('y2');
    var project_id = $('input#project_id').val();
    var page_id = $('input#page_id').val();
    jcrop_api.animateTo([x1,y1,x1+x2,y1+y2]);
    $.getScript("/translations/2.js?project_id="+project_id+"&page_id="+page_id)
  });
});

function update_rect(coords){
  $("#translation_x1").val(coords.x);
  $("#translation_y1").val(coords.y);
  $("#translation_x2").val(coords.w);
  $("#translation_y2").val(coords.h);
}
