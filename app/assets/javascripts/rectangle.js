var jcrop_api;

$(function(){
  var img = 'img#rectangle'
  var x1 = $(img).data('x1');
  var y1 = $(img).data('y1');
  var x2 = $(img).data('x2');
  var y2 = $(img).data('y2');
  var active_textarea_id;
  var active_form_id;

  /* Initially we are in read mode, so the
  ** rectangle is set not to be moved or resized.
  */
  $(img).Jcrop({
    onChange: update_rect,
    onSelect: update_rect,
  }, function(){
    jcrop_api = this;
  });
  jcrop_api.setOptions({ allowMove: false, allowResize: false });


  /* Mouse entering a translation, makes the
  ** rectangle to move (in read mode). */
  $('div#translations').delegate('form.translation', 'mouseenter', function(){
    move_rect(this,false);
  });
  $('form#new_translation').mouseenter(function(){
    move_rect(this,false);
  });


  /* Clicking within a textarea in a translation,
  ** inactivates all translations and hide their
  ** buttons and comment link.
  ** All history divs are also hidden.
  **
  ** Thereafter the one that got clicked
  ** is activated and its button is shown.
  **
  ** The history is also shown, if there is more
  ** than one version for the transcribe/
  ** translation. If it's not, the comment link is
  ** giving the user the opportunity to force
  ** showing the history section and create a
  ** comment.
  **
  ** The rectangle is also forced to move (in case we
  ** are in edit mode). After the first click,
  ** we are in edit mode. */
  $('form.translation').delegate('textarea', 'click', function(){
    $('form.translation textarea').removeClass('active');
    $('form.translation input.submit').hide();
    $('form.translation div.button_placeholder').show();
    $('div.history').hide();
    $('a#comment').hide();

    active_textarea_id = $(this).attr('id')

    var history_id = $(this).data('history');
    active_form_id = $(this).parent().parent().get(0).id;
    if ($("div#"+history_id+" div#sentences").children('div.sentence').length > 1){
      $("div#"+history_id).show();
    }else if ($("div#"+history_id+" div#sentences").children('div.sentence').length == 1 && $("div#"+history_id+" div#sentences").children('div.sentence').children('div#comments').length == 1){
      $("div#"+history_id).show();
    }else{
      $("form#"+active_form_id+" a#comment").show();
    }

    $("form#"+active_form_id+" input.submit").show();
    $("form#"+active_form_id+" div.button_placeholder").hide();
    $("form#"+active_form_id+" textarea#"+active_textarea_id).addClass("active");
    move_rect($(this).parent().parent().get(0),true);
    jcrop_api.setOptions({ allowMove:true, allowResize:true });
  });


  /* Make a click on the comment link return false
  ** to make it a javascript event only.
  */
  $("a#comment").click(function(){
    var history_id = $("form#"+active_form_id+" textarea#"+active_textarea_id).data('history')
    $("div#"+history_id).show();
    return false;
  });

  /* Unobtrusive javacode */
  $('form#new_translation').hide()
  $("input.submit").hide();
  $('div#page a#new_link').show()
  $('div.history').hide()
  $('a#comment').hide()
});

function move_rect(obj, move){
  var x1 = form_coord_val(obj.id,"x1");
  var y1 = form_coord_val(obj.id,"y1");
  var x2 = form_coord_val(obj.id,"x2");
  var y2 = form_coord_val(obj.id,"y2");
  if (move || !$('form.active').hasClass('active')){
    jcrop_api.animateTo([x1,y1,x1+x2,y1+y2]);
  }
}

function update_rect(coords){
  $(active_form_coord("x1")).val(coords.x);
  $(active_form_coord("y1")).val(coords.y);
  $(active_form_coord("x2")).val(coords.w);
  $(active_form_coord("y2")).val(coords.h);
}

function active_form(){ return "form.active" }
function active_form_coord(s){
  return active_form()+" "+coord(s)
}
function coord(s){ return "input#translation_"+s }
function form_coord(id,s){
  return "form#"+id+" "+coord(s)
}
function form_coord_val(id,s){
  return parseInt($(form_coord(id,s)).val())
}

//function isNumber (o) {
//  return ! isNaN (o-0);
//}

