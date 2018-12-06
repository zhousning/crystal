# encoding: UTF-8

class CommentsController < ApplicationController
  before_filter :authenticate_parent!
  load_and_authorize_resource

  def new
    @comment = Comment.new
    @teacher = Teacher.find(params[:teacher_id])
  end

  def create
    @teacher = Teacher.find(params[:teacher_id])
    @comment = Comment.new(params[:comment])
    @comment.category = Setting.comments.category_public
    @comment.desc = 0
    @comment.attitude = 0
    @comment.speed = 0
    @comment.teacher = @teacher
    @comment.parent = current_parent
    if @comment.save
      redirect_to detail_teachers_url(:id => @teacher.number)
    else
      render action: "new"
    end
  end
end
