
$("document").ready(function(){
 
  $("#p_address_edit_open").click(function(){
    $("#p_address_div").fadeIn();
  });

  $("#p_address_edit_close").click(function(){
    $("#p_address_div").fadeOut();
  });
  
 /* $("#p_password_modify_form").on('submit', function(event){
    alert("fasdf");
    var password = document.getElementById("#password");
    if(password =="")
    {
      alert("请输入原有的密码！");
      return;
    }
    $.ajax({
      url: $(this).prop('action'),
        dataType: 'json'
    }).done(function(data) {
      alert("adf");
    });
  })
  */
  $("#p_password_modify_btn").click(function(){
    
    var password = document.getElementById("p_password").value;
    if(password =="")
    {
      alert("请输入原有的密码！");
      document.getElementById("p_password").focus();
      return;
    }
    var new_password = document.getElementById("p_new_password").value;
    if(new_passowrd =="")
    {
      alert("请输入新的密码！");
      document.getElementById("p_new_password").focus();
      return;
    }
    var new_password_repeat = document.getElementById("p_new_password_repeat").value;
    if(new_password_repeat =="")
    {
      alert("请再次输入新的密码！");
      document.getElementById("p_new_password_repeat").focus();
      return;
    }
    
    if(new_password != new_password_repeat)
    {
      alert("两次密码输入的不一致！");
      return;
    }
  });
});

function parent_validate(){
  var p_phone = $("#parent_phone").val();
  var p_password = $("#parent_password").val();
  var sel_val = $("#course_price").val();
  var rad_val = $("input[name='course[id]']:checked").val()
    
  if(typeof(sel_val) == "undefined"){
    id = rad_val;
  }
  else{
    id = sel_val;
  }
  $.getJSON("/parent_validate",{p_phone:p_phone,p_password:p_password,id:id},function(data){
    if(data.res == "success")
    {
      $("#new_parent").submit();
    }
    else if(data.res == "error")
    {
      $(".error_message").text("用户名或密码错误");
      return;
    }
  });
}
