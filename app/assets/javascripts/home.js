$(document).ready(function(){
  if ($(document).width() < 1100)
  {
    $('.container-fluid').css("width","1100px");
  }
  $('.pgwSlider').pgwSlider();

  $("#category1").mouseover(function(){
    $(".category-subject-select").css("display","none");
    $("#category-subject1").css("display","block");
  });
  

  $("#category2").mouseover(function(){
    $(".category-subject-select").css("display","none");
    $("#category-subject2").css("display","block");
  });

  $("#category3").mouseover(function(){
    $(".category-subject-select").css("display","none");
    $("#category-subject3").css("display","block");
  });

  $("#category4").mouseover(function(){
    $(".category-subject-select").css("display","none");
    $("#category-subject4").css("display","block");
  });

  $("#category-subject1").mouseleave(function(){
    $("#category-subject1").css("display","none");
  });

  $("#category-subject2").mouseleave(function(){
    $("#category-subject2").css("display","none");
  });

  $("#category-subject3").mouseleave(function(){
    $("#category-subject3").css("display","none");
  });

  $("#category-subject4").mouseleave(function(){
    $("#category-subject4").css("display","none");
  });

  $(".smallschool").click(function(){
    $(".smallschool").removeClass("school-menu-active");
    $("#"+this.id).addClass("school-menu-active");
    $(".smallschool-p").css("display","none");
    $("#p-"+this.id).css("display","block");
  });

  $(".middleschool").click(function(){
    $(".middleschool").removeClass("school-menu-active");
    $("#"+this.id).addClass("school-menu-active");
    $(".middleschool-p").css("display","none");
    $("#p-"+this.id).css("display","block");
  });

  $(".highschool").click(function(){
    $(".highschool").removeClass("school-menu-active");
    $("#"+this.id).addClass("school-menu-active");
    $(".highschool-p").css("display","none");
    $("#p-"+this.id).css("display","block");
  });

  $(".adv_remove").click(function(){
    $(".advertise").slideUp("slow");
  });

});

/** 移动端js **/

//图片滚动 调用方法 imgscroll({speed: 30,amount: 1,dir: "up"});
$.fn.imgscroll = function(o){
	var defaults = {
		speed: 40,
		amount: 0,
		width: 1,
		dir: "left"
	};
	o = $.extend(defaults, o);
	
	return this.each(function(){
		var _li = $("li", this);
		_li.parent().parent().css({overflow: "hidden", position: "relative"}); //div
		_li.parent().css({margin: "0", padding: "0", overflow: "hidden", position: "relative", "list-style": "none"}); //ul
		_li.css({position: "relative", overflow: "hidden"}); //li
		if(o.dir == "left") _li.css({float: "left"});
		
		//初始大小
		var _li_size = 0;
		for(var i=0; i<_li.size(); i++)
			_li_size += o.dir == "left" ? _li.eq(i).outerWidth(true) : _li.eq(i).outerHeight(true);
		
		//循环所需要的元素
		if(o.dir == "left") _li.parent().css({width: (_li_size*3)+"px"});
		_li.parent().empty().append(_li.clone()).append(_li.clone()).append(_li.clone());
		_li = $("li", this);

		//滚动
		var _li_scroll = 0;
		function goto(){
			_li_scroll += o.width;
			if(_li_scroll > _li_size)
			{
				_li_scroll = 0;
				_li.parent().css(o.dir == "left" ? { left : -_li_scroll } : { top : -_li_scroll });
				_li_scroll += o.width;
			}
				_li.parent().animate(o.dir == "left" ? { left : -_li_scroll } : { top : -_li_scroll }, o.amount);
		}
		
		//开始
		var move = setInterval(function(){ goto(); }, o.speed);
		_li.parent().hover(function(){
			clearInterval(move);
		},function(){
			clearInterval(move);
			move = setInterval(function(){ goto(); }, o.speed);
		});
	});
};


$(document).ready(function(){

	$(".scrollleft").imgscroll({
		speed: 40,    //图片滚动速度
		amount: 0,    //图片滚动过渡时间
		width: 1,     //图片滚动步数
		dir: "left"   // "left" 或 "up" 向左或向上滚动
	});


	$(".appointment-scroll").imgscroll({
		speed: 40,    //图片滚动速度
		amount: 0,    //图片滚动过渡时间
		width: 1,     //图片滚动步数
		dir: "up"   // "left" 或 "up" 向左或向上滚动
	});

});
