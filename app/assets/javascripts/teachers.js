function pass(id){
  $(document).ready(function(){
    $(".t_pass_0"+id).toggle(1000);
  });
}

function ctg_select(title){
    var val = $(title).text();
    $(title).parents("ul").siblings(".ctg-title").val(val);
}

function change_color(label){
  var checkbox = $(label).children("input[type='checkbox']");
  if(checkbox.attr('checked')){
    $(label).children("span").css("color","red");
  }
  else{
    $(label).children("span").css("color","black");
  }
}

$(function(){
  var time_txt = $(".sel_time");
  for(var i=0; i<time_txt.length; i++){
    var val = $(time_txt[i]).val().substring(0,10);
    $(time_txt[i]).val(val);
  }
});


function select_price(allcourse){
  var course_name = $("#course_price option:selected").text();
  var course_json = allcourse;
  $.each(course_json,function(i,k){
    if(k.name == course_name){
      $("#teacher_price").empty();
      $("#teacher_price").append("￥"+k.price);
    }
  });
}


function togglecontent(obj){
  var title = $(obj);
  title.parent().next(".panel-body").toggle("slow");
}

$(function(){
  $(".datepicker").css({"margin":"0px","width":"100%"});
  $(".table-condensed").css("width","100%");
})

function toggleInfo(){
  $(".edit-basic-info").toggle("slow");
}

$(document).ready(function() {   
     var sideslider = $('[data-toggle=collapse-side]');
     var sel = sideslider.attr('data-target');
     var sel2 = sideslider.attr('data-target-2');
     sideslider.click(function(event){
         $(sel).toggleClass('in');
         $(sel2).toggleClass('out');
     });
 });
