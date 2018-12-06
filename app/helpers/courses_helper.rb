#encoding:utf-8
module CoursesHelper
  def mode_option
    [['一对一教学','一对一教学']]
  end

  def price_options
    [['20','20'],['30','30'],['40','40'],['50','50'],['60','60'],['70','70'],['80','80'],['90','90'],['100','100'],['120','120'],['150','150'],['200','200']]
  end

  def format_string_newline(text)
    if text
      text.gsub("\r\n", "<br/>")
    else
      ""
    end
  end
end
