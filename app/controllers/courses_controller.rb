# encoding: UTF-8

class CoursesController < ApplicationController
  #这条语句不生效
  #before_filter {:authenticate_teacher! or :authenticate_parent!}
  load_and_authorize_resource
  has_mobile_fu
  has_mobile_fu_for :new,:index,:show,:edit
  def index
    @courses=current_teacher.courses.all
  end
  
  def show
    @course = Course.find(params[:id])
  end

  def new
    if current_teacher and current_teacher.status==Setting.teachers.status_pass_sql
      @course = Course.new
      @category = Category.all
      @category_json=@category.to_json
      @seconds = seconds
    else
      flash[:error] = t('courses.new.error')
     # redirect_to paper_teachers_path
       redirect_to editinfo_basic_teachers_path
    end
  end

  def edit
    if current_teacher and current_teacher.status==Setting.teachers.status_pass_sql
      @course = Course.find(params[:id])
      @category = Category.all
      @category_json=@category.to_json
      @seconds = seconds
      @thirds = thirds(@course.category.second)
      @subjects = subjects(@course.category.second,@course.category.third)
    else
      flash[:error] = t('courses.edit.error')
      redirect_to paper_teachers_path
    end
  end

  def create
    @course = Course.new(params[:course])
    @course.mode = "一对一教学"
    @course.teacher = current_teacher
    @category = Category.where(:subject=>params[:subject][:no3],:second=>params[:second][:no1],:third=>params[:third][:no2]).first
    @course.category = @category
    if @course.category.second == "计算机" or @course.category.second == "艺术"
      @course.name = @category.third + "-" + @category.subject
    else
      @course.name = @category.second + @category.third + @category.subject
    end
    if @course.save
      @category2 = Category.all
      @category_json=@category2.to_json
      @seconds = seconds
      flash.now[:success] = t('courses.create.success')
      redirect_to @course
    else
      #flash.now[:error] = t('courses.create.error')
      render action: "new"
    end
  end

  def update
    @course = Course.find(params[:id])
    @category = Category.where(:subject=>params[:subject][:no3],:second=>params[:second][:no1],:third=>params[:third][:no2]).first
    @course.category = @category
    @course.name = @category.second + @category.third + @category.subject
    if @course.update_attributes(params[:course])
      flash.now[:success] = t('courses.update.success')
      redirect_to @course
    else
      #flash.now[:error] = t('courses.update.error')
      render action: "edit"
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    flash.now[:success] = t('courses.destroy.success')
    redirect_to courses_url
  end

  def select_second
     @seconds=Category.where(:second=>params[:sec]).select("third").group("third").all.collect{|item| [item.third]}
     respond_to do |format|
       format.html
      format.json{ render :json => @seconds} 
     end
  end

  def select_third
    @thirds=Category.where(:second=>params[:sec],:third=>params[:third]).select("subject").all.collect{|ttem| [ttem.subject]}
    respond_to do |format|
      format.html
      format.json{ render :json => @thirds}
    end
  end

private
  def seconds
    cat=Category.select("second").order("id asc").group("second")
    res = []
    r =  ['请选择分类',0]
    res << r
    cat.each do|c|
      option = ["#{c.second}","#{c.second}"]
      res << option
    end
    return res
  end

  def thirds(second)
    c1=Category.where(:second=>second).select("third").group("third").all
    res = []
    r =  ['请选择二级分类',0]
    res << r
    c1.each do|i|
      r = ["#{i.third}","#{i.third}"]
      res << r
    end
    return res
  end

  def subjects(second,third)
    c2=Category.where(:second=>second,:third=>third).select("subject").all
    res = []
    r =  ['请选择科目',0]
    res << r
    c2.each do|j|
      r = ["#{j.subject}","#{j.subject}"]
      res << r
    end
    return res
  end
end
