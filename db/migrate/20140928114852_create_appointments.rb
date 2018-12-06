# coding: utf-8

class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer    :weekday    #星期一～星期日
      t.integer    :time       #上午，下午，晚上
      t.references :course
      t.references :order

      t.timestamps
    end
  end
end
