class StudentInfo < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :registrar, class_name: 'User'
  belongs_to :district, optional: true
  belongs_to :program_category
  belongs_to :country
  belongs_to :course

  mount_uploader :bankslip, BankslipUploader
  
  before_create :generate_registration

  def created_date
   self.created_at.strftime("%d %b. %Y")
  end
  def fill_missing
<<<<<<< HEAD
    self.update(student_1: "#{self.student.first_name} #{self.student.last_name}", country_1: self.country.name,district_1: self.district.name, registrar_1: "#{self.registrar.first_name} #{self.registrar.first_name}", program_1: self.program_category.name, course_1: self.course.name)
=======
    self.update(student_1: "#{self.student.first_name} #{self.student.last_name}", country_1: self.country.name,registrar_1: "#{self.registrar.first_name} #{self.registrar.first_name}", program: self.program_category.name, course_1: self.course.name)
    if self.district 
      self.update(district_1: self.district.name)
    end
>>>>>>> 178611c7f1b6571badd68e62496798e772468ff0
  end
  rails_admin do
    edit do
      exclude_fields :id, :student_id, :registrar_id,:created_at, :updated_at, :bankslip
    end
    show do
      include_fields :student,:country, :district, :city,  :program_category, :program_time, :course, :education_level, :city, :status, :reg_no, :bankslip, :registrar, :created_at
    end
    list do
      # filters [:education_level, :city, :created_at, :status, :reg_no]
      # Manually enable/disable per field
      field :student_1 do
        label 'Student'
        filterable true
      end
      field :country_1 do
        label 'Country'
        filterable true
      end


      field :program_1 do
        label 'Program'
        filterable true
      end
      field :district_1 do
        label 'District'
        filterable true
      end

      
      field :program_time do
        filterable true
      end

      field :course_1 do
        label 'Course'
        filterable true
      end

      field :education_level do
        filterable true
      end


      field :city do
        filterable true
      end

      field :reg_no do
        filterable true
      end

      field :bankslip do
        filterable true
      end

      field :created_at do
        filterable true
      end

      field :registrar_1 do
        label 'Registrar'
        filterable true
      end

      field :status do
        filterable true
      end 

      field :registrar do
        filterable false
      end


    end
  end



  def generate_registration
    self.reg_no = self.country.abbreviation + "00" + self.student.id.to_s + "/KIAC/#{Time.now.year}" 
  end
end
