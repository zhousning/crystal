# coding: utf-8

require 'rmagick'
require 'chunky_png/rmagick'

class InformationController < ApplicationController

  has_mobile_fu
  def index
    if params[:infocategory]
      @category=InfoCategory.find(params[:infocategory])
      @information=@category.information.order("id desc").page(params[:page]).per(20)
    else
      @information=Information.order("id desc").page(params[:page]).per(20)
    end
    @infoCategory=InfoCategory.all
    @information_top=Information.order("click_times desc")
    @information_top=@information_top[0,9]
  end

  def create
    @information =Information.new(params[:information])
    @infoCategory=InfoCategory.find(params[:information][:info_category_id])
    @information.info_category = @infoCategory
    @information.number = (rand(1..9)*10000000 + rand(10000000)).to_s

    text_img = Magick::Image.new(600,200)
    gc = Magick::Draw.new
    gc.stroke('transparent')
    gc.pointsize(24)
    gc.font("fonts/simhei.ttf")
    gc.text(200,80, @information.title)
    gc.font("fonts/simhei.ttf")
    gc.fill("#ff0000")
    gc.text(200,140, @information.name + "  " + @information.phone)
    gc.draw(text_img)
    #text_img.write('love.jpg')

    chunky_png_img = ChunkyPNG::RMagick.import(text_img)

    qrcode_img = RQRCode::QRCode.new(information_url(:id=>@information.number), :size => 6, :level => :h ).to_img.resize(200,200)
    chunky_png_img.compose!(qrcode_img, 0, 0)

    logo_img = ChunkyPNG::Image.from_file(File.join(Rails.root, 'public', 'new_logo_small.png'))
    chunky_png_img.compose!(logo_img, 80, 80)

    @information.qrcode = chunky_png_img.to_string
    if @information.save
      redirect_to information_index_url
    else
      render action: "new"
    end
  end

  def show
    @information = Information.find_by_number(params[:id])
    @information_list=Information.limit(6).find_all_by_info_category_id(@information.info_category_id)
    #TODO需要修改
    @information.click_times+=1;
    @information.save
  end

  def new
    @information=Information.new
  end

  def download
    @information = Information.find_by_number(params[:id])
    data = open(File.join(Rails.root, 'public', 'pictures', @information.qrcode_uid))
    send_data data.read, :filename=>"#{@information.title}.png", :type => "application/force-download", :x_sendfile=>true
  end

end
