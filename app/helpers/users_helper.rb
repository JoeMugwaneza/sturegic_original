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
  
  def level_one(n)
    n = n.to_i
    users = []
    self.studentgroups[n].each do |student|
      users.push(student)
    end
    return users
  end

  def level_two(n)
    users = []
    self.level_one(n).each do |user|
      user.studentInfos.each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_three(n)
    users = []
    self.level_two(n).each do |user|
      user.studentInfos.each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_four(n)
    users = []
    self.level_three(n).each do |user|
      user.studentInfos.each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_five(n)
    users = []
    self.level_four(n).each do |user|
      user.studentInfos.each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end
end
