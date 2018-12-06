function vote_submit(obj){
  var vote = $(obj);
  var opt_id = vote.next("input[type=radio]").attr("id");
  var t_number = vote.next("input[type=radio]").val();
  $.post("/activities/vote_create",{optid:opt_id,teacher_number:t_number},function(data){
    var radio = $("input[id="+data.optid+"]"); 
    radio.parent().next(".ticket-wraper").find(".ticket").html();
    radio.parent().next(".ticket-wraper").find(".ticket").html(data.size+"票");
    });
}

function check_radio(obj){
  $(obj).next("input[type=radio]").attr("checked","true");
}


function vote_code_validate(){
  var captcha = $("input[name=captcha]").val();
  $.post("/activities/vote_code_validate",{captcha:captcha},function(data){
    if (data.result == "success")
      $("#vote_form").submit();
    else
      $(".vote_message").html("<font class='vote_error'>验证码错误</font>");
  });
}

