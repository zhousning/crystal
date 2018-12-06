function select_no1(value){
    $.getJSON("/courses/select_second",{sec:value},function(data){
      $("#third_no2").empty();
      $("#subject_no3").empty();
      var s_no2=$("#third_no2");
        var option = $("<option>").val(0).text("请选择二级分类"); 
        s_no2.append(option);
      $.each(data,function(k,v){
         option = $("<option>").val(v).text(v); 
        s_no2.append(option);
      });
    });
}

function select_no2(value1,value2){
    $.getJSON("/courses/select_third",{third:value1,sec:value2},function(data){
      $("#subject_no3").empty();
      $.each(data,function(k,v){
        var option = $("<option>").val(v).text(v);
        $("#subject_no3").append(option);
      });
    });
}


function select_no1_category(no1,category_json){
    var no1_json = category_json;
    var no1_v = $(no1).val();
    $("#third_no2").empty();
    $("#subject_no3").empty();
    var s_no2=$("#third_no2");
    var option = $("<option>").val(0).text("请选择二级分类"); 
    s_no2.append(option);

    $.each(no1_json,function(i,k){
      if(k.second == no1_v){
        option = $("<option>").val(k.third).text(k.third); 
        s_no2.append(option);
      }
     });     

     var $options=s_no2.find("option");
     for(var i=0;i<$options.length;i++){
      $item1 = $options.eq(i);
      for (var j=0;j<$options.length;j++){
       if(i==j){
         continue;
       }
       $item2 = $options.eq(j);
       if($item1.attr("value") === $item2.attr("value")){
        i>j?$item1.remove(): $item2.remove();
       }
      }
     }
}



function select_no2_category(no1,category_json){
    var no1_json = category_json;
    var no1_v = $(no1).val();
    var second_no1 = $("#second_no1").val();
    var s_no3=$("#subject_no3");
    s_no3.empty();
    var option = $("<option>").val(0).text("请选择科目"); 
    s_no3.append(option);
    $.each(no1_json,function(i,k){
      if(k.second == second_no1 && k.third == no1_v){
        option = $("<option>").val(k.subject).text(k.subject); 
        s_no3.append(option);
      }
     });     
}



function check_select(no){
    var s_no3 = $(no).val();
    if(s_no3 == 0)
    {
      $("#error").remove();
      $(".promot-parts").after("<font id='error' color='#CF425A'>请选择科目分类</font>");
    }
    else
    {
      $("#error").remove();
    }
}



function submit_course(){
    var result = $(".ctg_list").find("option:selected[value=0]");
    if(result.length >0)
    {
      $("#error").remove();
      $(".promot-parts").after("<font id='error' color='#CF425A'>请选择科目分类</font>");
      return;
    }
    else
    {
      $(".course_form").submit();
    }
}













