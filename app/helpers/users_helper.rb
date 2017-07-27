module UsersHelper
  
  def level_one
    users = []
    self.studentInfos.each do |studentInfo|
      users.push(studentInfo.student)
    end
    return users
  end

  def level_two
    users = []
    self.level_one.each do |user|
      user.studentInfos.each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_three
    users = []
    self.level_two.each do |user|
      user.studentInfos.each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_four
    users = []
    self.level_three.each do |user|
      user.studentInfos.each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end

  def level_five
    users = []
    self.level_four.each do |user|
      user.studentInfos.each do |studentInfo|
        users.push(studentInfo.student)
      end
    end
    return users
  end
end
