$(function(){
  var img = 'img#rectangle'
  var x1 = $(img).data('x1');
  var y1 = $(img).data('y1');
  var x2 = $(img).data('x2');
  var y2 = $(img).data('y2');
  $(img).Jcrop({
    onChange: update_rect,
    onSelect: update_rect,
    setSelect: [x1||100, y1||100, x2||200, y2||200],
  });
});

function update_rect(coords){
  $("#translation_x1").val(coords.x);
  $("#translation_y1").val(coords.y);
  $("#translation_x2").val(coords.w);
  $("#translation_y2").val(coords.h);
}
