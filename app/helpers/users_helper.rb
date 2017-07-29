module UsersHelper
  # def groups
  #   users = {}
  #   # students = []
  #   # self.studentInfos.each do |studentInfo|
  #   #   students.push(studentInfo.student)
  #   # end
  #   groups = self.studentInfos.each_slice(1).to_a

  #   group_n = 1
  #   groups.each do |group|
  #     users["group_#{group_n}"] = group
  #     group_n += 1
  #   end
  #   return users
  # end
  
  def level_one(n,p)
    n = n.to_i
    users = []
    if self.techgroups && p == "Tech"
      self.techgroups[n].each do |student|
        users.push(student)
      end
    elsif self.trafficgroups && p == "Traffic"
      self.trafficgroups[n].each do |student|
        users.push(student)
      end
    else
      self.englishgroups[n].each do |student|
        users.push(student)
      end
    end
    return users
  end

  def level_two(n,p)
    users = []
    self.level_one(n,p).each do |user|
      user.studentInfos.each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_three(n,p)
    users = []
    self.level_two(n,p).each do |user|
      user.studentInfos.each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_four(n,p)
    users = []
    self.level_three(n,p).each do |user|
      user.studentInfos.each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_five(n,p)
    users = []
    self.level_four(n,p).each do |user|
      user.studentInfos.each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end
end
