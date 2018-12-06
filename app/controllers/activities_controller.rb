# encoding: UTF-8

class ActivitiesController < ApplicationController
  has_mobile_fu
  has_mobile_fu_for :beauty, :beauty2

  def bouns
    render :layout => false
  end

  def beauty
    @teachers = Teacher.where(:status => Setting.teachers.status_pass_sql).order("created_at desc")
    @teachers.sort!{|a,b| b.votes.size<=>a.votes.size}
  end

  def beauty2
    @teachers = Teacher.where(:status => Setting.teachers.status_pass_sql, :join_status => Setting.teachers.join_status_sec_vote).order("created_at desc")
    #@teachers.sort!{|a,b| b.sec_votes.size<=>a.sec_votes.size}
    @teachers.sort!{|a,b| (b.sec_votes.size*0.7+b.votes.size*0.3)<=>(a.sec_votes.size*0.7+a.votes.size*0.3)}
  end

  def vote_create2
    vote_status = 0
    if simple_captcha_valid?
      cur_sign = Digest::MD5.hexdigest(request.remote_ip + params[:teacher][:number] + Time.now.strftime("%Y-%m-%d"))
      session_id = session[:session_id] || "null"
      cur_sign2 = Digest::MD5.hexdigest(session_id + params[:teacher][:number] + Time.now.strftime("%Y-%m-%d"))
      @vote = SecVote.new(:ip=>request.remote_ip, :sign=>cur_sign, :sign2=>cur_sign2, :session=>session_id)

      @teacher = Teacher.find_by_number(params[:teacher][:number].to_s)
      return if @teacher.status != Setting.teachers.status_pass_sql

      @vote.teacher = @teacher
      if !@vote.save
        flash[:error] = t('activities.vote_create.error')
        vote_status = 2
      else
        flash[:success] = "您的投票成功，如果有兴趣，再支持以下其他的选手吧。"
        vote_status = 1
      end
    else
      flash[:error] = "您输入的验证码有误，请重新输入正确的验证码，重新投票。"
        vote_status = 3
    end
    user_vote_access_log(vote_status)
    redirect_to activities_beauty2_url
  end

  #def vote_code_validate
  #  if simple_captcha_valid?
  #    respond_to do |format|
  #      format.json{ render :json => {result:"success"}.to_json}
  #    end
  #  else
  #    respond_to do |format|
  #      format.json{ render :json => {result:"error"}.to_json}
  #    end
  #  end
  #end

  private

  def user_vote_access_log(status)
    session_id = session[:session_id] || ""
    parent_id = (current_parent && current_parent.id) || ""
    parent_name = (current_parent && current_parent.name) || ""
    teacher_id = (current_teacher && current_teacher.id) || ""
    teacher_name = (current_teacher && current_teacher.name) || ""
    logger.info "#{Time.now.strftime("%Y-%m-%d %H:%M:%S")} [vote_log]\t#{request.request_method}\t#{request.url}\t#{request.referer}\t#{request.remote_ip}\t#{request.user_agent}\t#{session_id}\t#{parent_id}\t#{parent_name}\t#{teacher_id}\t#{teacher_name}\t#{params[:teacher][:number]}\t#{status}"
  end
end
