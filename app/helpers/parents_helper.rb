module ParentsHelper

  def get_address_province
    p = [  
          [Setting.addresses.province_jilin_string, Setting.addresses.province_jilin]
        ]  
  end

  def get_address_city
    c = [
          [Setting.addresses.city_jilin_string, Setting.addresses.city_jilin]
        ]
  end
  

  def get_address_district
    d = [
          [Setting.addresses.district_jilin_cy_string, Setting.addresses.district_jilin_cy],
          [Setting.addresses.district_jilin_cq_string, Setting.addresses.district_jilin_cq],
          [Setting.addresses.district_jilin_fm_string, Setting.addresses.district_jilin_fm],
          [Setting.addresses.district_jilin_jh_string, Setting.addresses.district_jilin_jh],
          [Setting.addresses.district_jilin_hd_string, Setting.addresses.district_jilin_hd],
          [Setting.addresses.district_jilin_yj_string, Setting.addresses.district_jilin_yj],
          [Setting.addresses.district_jilin_ps_string, Setting.addresses.district_jilin_ps]
        ]
  end 

  def get_address_province_string(province)
    if province != nil
      if province == Setting.addresses.province_jilin.to_s()
        return Setting.addresses.province_jilin_string
      end
    end
    ""
  end

  def get_address_city_string(city)
    if city !=nil
      if city == Setting.addresses.city_jilin.to_s()
        return Setting.addresses.city_jilin_string
      end
    end
    ""
  end

  def get_address_district_string(district)
  
    if district != nil   
      if district == Setting.addresses.district_jilin_cy.to_s()
        return Setting.addresses.district_jilin_cy_string
      elsif district == Setting.addresses.district_jilin_cq.to_s()
        return Setting.addresses.district_jilin_cy_string
      elsif district == Setting.addresses.district_jilin_fm.to_s()
        return Setting.addresses.district_jilin_fm_string
      elsif district == Setting.addresses.district_jilin_lt.to_s()
        return Setting.addresses.district_jilin_lt_string
      elsif district == Setting.addresses.district_jilin_hd.to_s()
        return Setting.addresses.district_jilin_hd_string
      elsif district == Setting.addresses.district_jilin_ps.to_s()
        return Setting.addresses.district_jilin_ps_string
      elsif district == Setting.addresses.district_jilin_jh.to_s()
        return Setting.addresses.district_jilin_jh_string
      elsif district == Setting.addresses.district_jilin_yj.to_s()
        return Setting.addresses.district_jilin_yj_string
      end
    end
    ""
  end

  def get_address_details_string(detail)
    if detail != nil
      return detail
    end
    ""
  end

  def get_school_name_string(num)
    if num == Setting.schools.school_small.to_s()
      Setting.schools.school_small_string
    elsif num == Setting.schools.school_middle.to_s()
      Setting.schools.school_middle_string
    elsif num == Setting.schools.school_high.to_s()
      Setting.schools.school_high_string
    end
  end
end
