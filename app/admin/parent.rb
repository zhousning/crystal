# coding: utf-8

ActiveAdmin.register Parent do
  index do
    selectable_column
    column "ID",:id
    column '姓名',:name
    column '电话',:phone
    column '支付宝',:pay_num
    column '订单数' do |f|
      span f.orders.size
      span link_to "(查看)",admin_orders_path(:parent_order_id=>f.id)
    end
    column '登录次数',:sign_in_count
    column "注册时间",:created_at do |t|
      t.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "更新时间",:updated_at do |t|
      t.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    default_actions
  end

  menu label: "家长管理", :priority => 5
  config.per_page = 20
  config.sort_order = 'id_desc'

  filter :name,label:'家长姓名'
  filter :phone,label:'家长电话'

  form do |f|
    f.inputs "User Details" do
      f.input :name,:label=>"姓名"
      f.input :phone,:label=>"电话"
      f.input :pay_num,:label=>"支付宝"
    end
    f.actions
  end

  show do
    attributes_table do
      row :id,:label=>"ID"
      row :name,:label=>"姓名"
      row :phone,:label=>"电话"
      row :pay_num,:lable=>"支付宝"
      #row "登录次数:" do 
      #  td parent.sign_in_count
      #end
      #row "最近登录时间:"
      #  td parent.last_sign_in_at
      #end
      #row "创建日期:" do
      #  td parent.created_at
      #end
      #row "更新日期:"
      #  td parent.updated_at
      #end
    end
  end

  controller do
    def scoped_collection
      if params[:order_parent_id]
        super.where(:id=>params[:order_parent_id])
      elsif params[:message_parent_id]
        super.where(:id=>params[:message_parent_id])
      else
        super
      end
    end
  end

end
