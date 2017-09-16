class StudentInfo < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :registrar, class_name: 'User'
  belongs_to :district, optional: true
  belongs_to :program_category
  belongs_to :country
  belongs_to :course
  after_save :fill_missing
  mount_uploader :bankslip, BankslipUploader
  
  validates_uniqueness_of :student_id, :message => ' is already saved'
  validates_presence_of :program_time, :message => 'musth be specified'
  validates_presence_of :course_id, :message => 'must be choosen before saving'
  validates_presence_of :education_level, :message => 'must be specified'
  validates_presence_of :bankslip, :message => 'Please provide you valid bankslip'
  def generate_registration
    self.update(reg_no: "#{self.country.abbreviation}" + "00" + "#{StudentInfo.where(status: true).count + 1 }" + "/KIAC/#{Time.now.year}")
  end

  def created_date
   self.created_at.strftime("%d %b. %Y")
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
        label 'KIAC Country'
        filterable true
      end


      field :program_1 do
        label 'Program'
        filterable true
      end
      field :district_1 do
        label 'KIAC District'
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

private
def fill_missing
  self.update_column(:student_1, "#{self.student.first_name} #{self.student.last_name}")
  self.update_column(:country_1, self.country.name )
  self.update_column(:registrar_1, "#{self.registrar.first_name} #{self.registrar.last_name}")
  self.update_column(:program_1, self.program_category.name)
  self.update_column(:course_1, self.course.name)
  if self.district
    self.update_column(:district_1, self.district.name)
  else 
    self.update_column(:district_1, self.city)
  end
  if self.student.country.name == "Rwanda" && self.district
    self.student.update(district: self.district.name)
  else
    self.student.update(district: self.city)
  end
  self.student.update(application_submission: true)
end

end
