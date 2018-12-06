$(document).ready(function(){
   
    $("#new_addr").click(function(){
      $("#new_addr_div").css("display","block");
    });
      
    $("#new_addr_sure").click(function(){
      var p = document.getElementById("p1");
      var c = document.getElementById("c1");
      var d = document.getElementById("d1");
      var de = document.getElementById("d2");
      if(p.options.selectedIndex ==0)
      {
        alert("请选择省份！");
        return;
      }
      if(c.options.selectedIndex ==0)
      {
        alert("请选择市！");
        return;
      }
      if(d.options.selectedIndex == 0)
      {
        alert("请选择区！");
        return;
      }  
      if(de.value =="")
      {
        alert("请输入具体地址！");
        return;
      }
      var addr= p.options[p.options.selectedIndex].text + c.options[c.options.selectedIndex].text + d.options[d.options.selectedIndex].text + de.value;
                      
      document.getElementById("addr").value=addr;
                          
      $("#new_addr_div").css("display","none");
    });

    $("#new_addr_cancle").click(function(){
      $("#new_addr_div").css("display","none");
    });

    $(".checktime").click(function(){
      $(".checktime").attr("checked",false);
      $("#"+this.id).attr("checked","true");
    });
});

function input_hours(price)
{
  var hours = $(".hours-value").val();
  if (hours <= 0) hours = 1;
  $(".order-submit-footer-number").text("￥"+(hours*price).toString());
}
