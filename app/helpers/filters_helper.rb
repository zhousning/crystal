# encoding: UTF-8
module FiltersHelper
  def get_week_string(week)
  
    if week != nil   
      if week == Setting.appointments.weekday_monday.to_s()
        Setting.appointments.weekday_monday_string.to_s()
      elsif week == Setting.appointments.weekday_tuesday.to_s()
        Setting.appointments.weekday_tuesday_string.to_s()
      elsif week == Setting.appointments.weekday_thursday.to_s() 
        Setting.appointments.weekday_thursday_string.to_s()
      elsif week == Setting.appointments.weekday_friday.to_s()
        Setting.appointments.weekday_friday_string.to_s()
      elsif week == Setting.appointments.weekday_wednesday.to_s()
        Setting.appointments.weekday_wednesday_string.to_s()
      elsif week == Setting.appointments.weekday_saturday.to_s()
        Setting.appointments.weekday_saturday_string.to_s()
      elsif week == Setting.appointments.weekday_sunday.to_s()
        Setting.appointments.weekday_sunday_string.to_s()
      end
    end
  end

  def get_time_string(time)
  
    if time != nil   
      if time == Setting.appointments.time_morning.to_s() 
        Setting.appointments.time_morning_string.to_s()
      elsif time == Setting.appointments.time_afternoon.to_s()
        Setting.appointments.time_afternoon_string.to_s()
      elsif time == Setting.appointments.time_evening.to_s()
        Setting.appointments.time_evening_string.to_s()
      end
    end
  end

  def get_color_string(course)
    if course.to_s() == Setting.colors.courses_yw.to_s()
      Setting.colors.courses_yw_color.to_s()
    elsif  course.to_s() == Setting.colors.courses_sx.to_s()
      Setting.colors.courses_sx_color.to_s()
    elsif course.to_s() == Setting.colors.courses_yy.to_s()
      Setting.colors.courses_yy_color.to_s()
    elsif course.to_s() == Setting.colors.courses_wl.to_s()
      Setting.colors.courses_wl_color.to_s()
    elsif course.to_s() == Setting.colors.courses_hx.to_s()
      Setting.colors.courses_hx_color.to_s()
    elsif course.to_s() == Setting.colors.courses_sw.to_s()
      Setting.colors.courses_sw_color.to_s()
    elsif course.to_s() == Setting.colors.courses_zz.to_s()
      Setting.colors.courses_zz_color.to_s()
    elsif course.to_s() == Setting.colors.courses_ls.to_s()
      Setting.colors.courses_ls_color.to_s()
    elsif course.to_s() == Setting.colors.courses_dl.to_s()
      Setting.colors.courses_dl_color.to_s()
    else
      Setting.colors.courses_qt_color.to_s()
    end
  end

  def get_min_price(courses)
    price = courses[0].price
    courses.each do |c|
      price = c.price if c.price < price
    end
    return price
  end
end
