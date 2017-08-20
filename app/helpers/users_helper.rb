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


  def archive
    #this will return a hash in which the month names are the keys, 
    #and the values are arrays of the posts belonging to such months
    #something like: 
    #{ "February" => [#<Post 0xb5c836a0>,#<Post 0xb5443a0>],
    # 'March' => [#<Post 0x43443a0>] }
    students = []
    self.studentInfos.each do |studentInfo| 
      students.push(studentInfo.student)
    end

    students_by_month = students.group_by { |student| student.created_at.strftime("%B") }

  end

  def archive_payments
    the_sum = Hash.new
    the_day = []
    if self.languagesgroups.any?
      self.languagesgroups.each do |languagesgroup|
        student_by_month = languagesgroup.group_by { |student| student.created_at.strftime("%d %B %y") }
        student_by_month.each do |month, students|
          the_day.push(month)
          level_one_students = self.level_one(self.languagesgroups.index(languagesgroup), "Languages") & students
          the_sum[month]=(level_one_students.count * 2000) if level_one_students.count != 0
          level_two_students = self.level_two_lang(self.languagesgroups.index(languagesgroup), "Languages") & students
          the_sum[month]=(level_two_students.count * 1000) if level_two_students.count != 0
          level_three_students = self.level_three_lang(self.languagesgroups.index(languagesgroup), "Languages") & students
          the_sum[month]=(level_three_students.count * 1000) if level_three_students.count != 0
          level_four_students = self.level_four_lang(self.languagesgroups.index(languagesgroup), "Languages") & students
          the_sum[month]=(level_four_students.count * 1000) if level_four_students.count != 0
          level_five_students = self.level_five_lang(self.languagesgroups.index(languagesgroup), "Languages") & students
          the_sum[month]=(level_five_students.count * 1000) if level_five_students.count != 0
        end
      end
    end
    if self.technicalgroups.any?
      self.technicalgroups.each do |technicalgroup|
        student_by_month = technicalgroup.group_by { |student| student.created_at.strftime("%d %B %y") }
        student_by_month.each do |month, students|
          level_one_students = self.level_one(self.technicalgroups.index(technicalgroup), "technical") & students
          the_sum[month]=(level_one_students.count * 5000) unless level_one_students.count == 0
          level_two_students = self.level_two_tech(self.technicalgroups.index(technicalgroup), "technical") & students
          the_sum[month]=(level_two_students.count * 4000) if level_two_students.count != 0
          level_three_students = self.level_three_tech(self.technicalgroups.index(technicalgroup), "technical") & students
          the_sum[month]=(level_three_students.count * 3000) if level_three_students.count != 0
          level_four_students = self.level_four_tech(self.technicalgroups.index(technicalgroup), "technical") & students
          the_sum[month]=(level_four_students.count * 2000) if level_four_students != 0
          level_five_students = self.level_five_tech(self.technicalgroups.index(technicalgroup), "technical") & students
          the_sum[month]=(level_five_students.count * 1000) if level_five_students.count != 0
        end
      end
    end
    if self.trafficgroups.any?
      self.trafficgroups.each do |trafficgroup|
        student_by_month = trafficgroup.group_by { |student| student.created_at.strftime("%d %B %y") }
        student_by_month.each do |month, students|
          level_one_students = self.level_one(self.trafficgroups.index(trafficgroup), "Traffic") & students
          the_sum[month]=(level_one_students.count * 2000) if level_one_students.count != 0
          level_two_students = self.level_two_tech(self.trafficgroups.index(trafficgroup), "Traffic") & students
          the_sum[month]=(level_two_students.count * 1000) if level_two_students.count != 0
          level_three_students = self.level_three_tech(self.trafficgroups.index(trafficgroup), "Traffic") & students
          the_sum[month]=(level_three_students.count * 1000) if level_three_students.count != 0
          level_four_students = self.level_four_tech(self.trafficgroups.index(trafficgroup), "Traffic") & students 
          the_sum[month]=(level_four_students.count * 1000) if level_four_students.count != 0
          level_five_students = self.level_five_tech(self.trafficgroups.index(trafficgroup), "Traffic") & students 
          the_sum[month]=(level_five_students.count * 1000) if level_five_students.count != 0
        end
      end
    end
    return the_sum
  end

  def this_month_payments 
     if self.technicalgroups.any? 
       tech_sum = 0 
       self.technicalgroups.each do |group|
         tech_sum += ((self.level_one(self.technicalgroups.index(group),"technical").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 5000) + (self.level_two_tech(self.technicalgroups.index(group),"technical").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 4000) + (self.level_three_tech(self.technicalgroups.index(group),"technical").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 3000) + (self.level_four_tech(self.technicalgroups.index(group),"technical").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 2000)+ (self.level_five_tech(self.technicalgroups.index(group),"technical").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 1000))
       end   
     end 
     if self.languagesgroups.any? 
       lang_sum = 0 
       self.languagesgroups.each do |group|
         lang_sum += ((self.level_one(self.languagesgroups.index(group),"languages").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 2000) + (self.level_two_lang(self.languagesgroups.index(group),"languages").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 1000) + (self.level_three_lang(self.languagesgroups.index(group),"languages").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 1000) + (self.level_four_lang(self.languagesgroups.index(group),"languages").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 1000)+ (self.level_five_lang(self.languagesgroups.index(group),"languages").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 1000))
       end   
     end 
     if self.trafficgroups.any? 
       traffic_sum = 0 
       self.trafficgroups.each do |group|
         traffic_sum += ((self.level_one(self.trafficgroups.index(group),"Traffic").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 2000) + (self.level_two_traffic(self.trafficgroups.index(group),"Traffic").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 1000) + (self.level_three_traffic(self.trafficgroups.index(group),"Traffic").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 1000) + (self.level_four_traffic(self.trafficgroups.index(group),"Traffic").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 1000)+ (self.level_five_traffic(self.trafficgroups.index(group),"Traffic").select{|student| Time.now.beginning_of_month <= student.created_at && Time.now.end_of_month >= self.created_at}.count * 1000))
       end 
     end 
    return (tech_sum.to_i + lang_sum.to_i + traffic_sum.to_i)
  end
end
