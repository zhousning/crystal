# encoding: UTF-8
class FiltersController < ApplicationController
  has_mobile_fu
  has_mobile_fu_for :index, :select, :subject, :search

  def select
    if params[:school] != "all"
      @subjects = Category.select("subject").where("second = '#{params[:school]}'").group("subject").order("id")
    end

    condition_category = ""
    if params[:school] != "all" && params[:school] != nil
       condition_category += " second = '#{params[:school]}'"
    end
    if params[:course] != "all" && params[:course] != nil
      if condition_category != ""
        condition_category += " and subject = '#{params[:course]}'"
      else
        condition_category += " subject = '#{params[:course]}'"
      end
    end
    @courses = Course.where(:category_id => Category.where(condition_category)).group("teacher_id")

    @teachers = []
    @courses.map do |course|
      if course.teacher
        if params[:period] == "all" || course.period.to_s == params[:period] || course.period == Setting.courses.period_all
          if params[:sex] == "all" || course.teacher.sex.to_s == params[:sex]
            weekdays = course.teacher.appointments.map {|a| a.weekday.to_s}
            if params[:time] == "all" || weekdays.include?(params[:time])
              @teachers << course.teacher
            end
          end
        end
      end
    end
    @teachers.uniq!{|t| t.id}
    @teachers.sort!{|a,b| compute(b.score,b.signcount)<=>compute(a.score,a.signcount)}
    @teachers.reject!{|t| t.status != Setting.teachers.status_pass_sql}
  end

  def index
    @courses = Course.all
    @courses = @courses.select {|c| c.teacher != nil}
    @teachers = @courses.map {|course| course.teacher}
    @teachers.uniq!{|t| t.id}
    @teachers.sort!{|a,b| compute(b.score,b.signcount)<=>compute(a.score,a.signcount)}
    @teachers.reject!{|t| t.status != Setting.teachers.status_pass_sql}
  end

  def subject
    @category = Category.find_by_number(params[:number])
    params[:school] = @category.second
    params[:grade] = "all"
    params[:course] = @category.subject
    params[:sex] = "all"
    params[:period] = "all"
    params[:time] = "all"
    select
    render "subject"
  end

  def search
    params[:school] = "all"
    params[:grade] = "all"
    params[:course] = "all"
    params[:sex] = "all"
    params[:period] = "all" 
    params[:time] = "all"
    @courses = Course.where(:category_id => Category.where("subject like ?", "%#{params[:keywords]}%").select("id"))
    @teachers = []
    @courses.each do |course|
      @teachers << course.teacher if course.teacher
    end
    @teachers.uniq!{|t| t.id}
    @teachers.sort!{|a,b| compute(b.score,b.signcount)<=>compute(a.score,a.signcount)}
    @teachers.reject!{|t| t.status != Setting.teachers.status_pass_sql}
  end

  private

  def compute(score, signcount)
    new_signcount = signcount ? signcount : 0
    new_signcount = new_signcount>5 ? 5 : new_signcount
    score + new_signcount * 4
  end
end
