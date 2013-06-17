var jcrop_api;
var active_form_id = false;

$(function(){
  var active_textarea_id;
  var history_id;

  /* If active_id is set in the url values are
  ** saved for the textarea and history to be
  ** active after everything is turned off. */
  if ($('textarea.active').attr('id')) {
    active_textarea_id = $('textarea.active').attr('id')
    active_form_id = $('textarea.active').parent().parent().attr('id')
    history_id = $('textarea.active').data('history');
  }

  /* Unobtrusive javacode (everything turned off)*/
  $('form#new_translation').hide()
  $("input.submit").hide();
  $('div.page a#new_link').show()
  $('div.history').hide()
  $('a#comment').hide()

  /* Active textarea/history is turned on since
  ** active_id is set in the url */
  if (active_form_id){
    activate_textarea()
    activate_history(history_id)
  }

  /* Initially we are in read mode, so the
  ** rectangle is set not to be moved or resized.
  */
  var img = 'img#rectangle'
  $(img).Jcrop({
    onChange: update_rect,
    onSelect: update_rect,
  }, function(){
    jcrop_api = this;
  });
  jcrop_api.setOptions({ allowMove: false, allowResize: false });

  /* Mouse entering a translation, makes the
  ** rectangle to move, in read mode. In edit mode
  ** you need to click within the textarea.
  */
  $('div#translations').delegate('form.translation', 'mouseenter', function(){
    move_rect(this,false);
  });
  $('form#new_translation').mouseenter(function(){
    move_rect(this,false);
  });
  $('div#translations').delegate('div#languages', 'mouseenter', function(){
    move_rect(this,true);
  });

  /* Clicking within a textarea in a
  ** translation... */
  $('form.translation').delegate('textarea', 'click', function(){
  /* All translations are and their buttons and
  ** comment links are hidden. All history divs
  ** are also hidden. */
    $('form.translation textarea').removeClass('active');
    $('form.translation input.submit').hide();
    $('form.translation div.button_placeholder').show();
    $('a#comment').hide();
    $('div.history').hide();

    active_form_id = $(this).parent().parent().get(0).id;
    active_textarea_id = $(this).attr('id')

  /* The textarea that got clicked is activated
  ** and its button is shown. */
    $(active_form()+" textarea#"+active_textarea_id).addClass("active");
    activate_textarea()

    var history_id = $(this).data('history');
    activate_history(history_id)

  /* The rectangle is also forced to move
  ** (in case we are in edit mode). After the
  ** first click, we are in edit mode. */
    move_rect($(this).parent().parent().get(0),true);
    jcrop_api.setOptions({ allowMove:true, allowResize:true });
  });

  /* Make a click on the comment link return false
  ** to make it a javascript event only. The
  ** history section is displayed. */
  $("a#comment").click(function(){
    var history_id = $("form#"+active_form_id+" textarea#"+active_textarea_id).data('history')
    $("div#"+history_id).show();
    return false;
  });
});

function activate_textarea(){
  $(active_form()+" input.submit").show();
  $(active_form()+" div.button_placeholder").hide();
}

/* The history is shown, if there is more
** than one version for the transcribe/
** translation. If there is just one, but it
** has a comment, the history is also shown.
** Otherwise, the comment link is presented
** giving the user the opportunity to force
** showing the history section where he can
** create a comment. */
function activate_history(id){
  if ($("div#"+id+" div#sentences").children('div.sentence').length > 1){
    $("div#"+id).show();
  }else if ($("div#"+id+" div#sentences").children('div.sentence').length == 1 && $("div#"+id+" div#sentences").children('div.sentence').children('div#comments').length == 1){
    $("div#"+id).show();
  }else{
    $("form#"+active_form_id+" a#comment").show();
  }
}

function active_form(){
  return "form#"+active_form_id
}
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
function move_rect(obj, move){
  if ((!active_form_id && !move) || (active_form_id && move)){
    var x1 = form_coord_val(obj.id,"x1");
    var y1 = form_coord_val(obj.id,"y1");
    var x2 = form_coord_val(obj.id,"x2");
    var y2 = form_coord_val(obj.id,"y2");
    jcrop_api.animateTo([x1,y1,x1+x2,y1+y2]);
  } else if (move) {
    var x1 = parseInt($(obj).parent().attr('data-x1'))
    var y1 = parseInt($(obj).parent().attr('data-y1'))
    var x2 = parseInt($(obj).parent().attr('data-x2'))
    var y2 = parseInt($(obj).parent().attr('data-y2'))
    jcrop_api.animateTo([x1,y1,x1+x2,y1+y2]);
  }
}

function update_rect(coords){
  if (!$('*:focus').attr('id')){
    $(active_form_coord("x1")).val(coords.x);
    $(active_form_coord("y1")).val(coords.y);
    $(active_form_coord("x2")).val(coords.w);
    $(active_form_coord("y2")).val(coords.h);
  }
}
