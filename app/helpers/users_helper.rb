module UsersHelper
  def level_one(n,p)
    n = n.to_i
    users = []
    if self.technicalgroups && p == "technical"
      self.technicalgroups[n].each do |student|
        users.push(student)
      end
    elsif self.trafficgroups && p == "Traffic"
      self.trafficgroups[n].each do |student|
        users.push(student)
      end
    else
      self.languagesgroups[n].each do |student|
        users.push(student)
      end
    end
    return users
  end


  def level_two_tech(n,p)
    users = []
    self.level_one(n,p).each do |user|
      user.studentInfos.where(program_category_id: 1).each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_three_tech(n,p)
    users = []
    self.level_two_tech(n,p).each do |user|
      user.studentInfos.where(program_category_id: 1).each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_four_tech(n,p)
    users = []
    self.level_three_tech(n,p).each do |user|
      user.studentInfos.where(program_category_id: 1).each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_five_tech(n,p)
    users = []
    self.level_four_tech(n,p).each do |user|
      user.studentInfos.where(program_category_id: 1).each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end
  #languages level 
  def level_two_lang(n,p)
    users = []
    self.level_one(n,p).each do |user|
      user.studentInfos.where(program_category_id: 2).each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_three_lang(n,p)
    users = []
    self.level_two_lang(n,p).each do |user|
      user.studentInfos.where(program_category_id: 2).each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_four_lang(n,p)
    users = []
    self.level_three_lang(n,p).each do |user|
      user.studentInfos.where(program_category_id: 2).each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_five_lang(n,p)
    users = []
    self.level_four_lang(n,p).each do |user|
      user.studentInfos.where(program_category_id: 2).each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  #digital traffic 

  def level_two_traffic(n,p)
    users = []
    self.level_one(n,p).each do |user|
      user.studentInfos.where(program_category_id: 3).each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_three_traffic(n,p)
    users = []
    self.level_two_traffic(n,p).each do |user|
      user.studentInfos.where(program_category_id: 3).each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_four_traffic(n,p)
    users = []
    self.level_three_traffic(n,p).each do |user|
      user.studentInfos.where(program_category_id: 3).each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_five_traffic(n,p)
    users = []
    self.level_four_traffic(n,p).each do |user|
      user.studentInfos.where(program_category_id: 3).each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end
end
