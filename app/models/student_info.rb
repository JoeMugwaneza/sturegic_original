class StudentInfo < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :registrar, class_name: 'User'
  belongs_to :district, optional: true
  belongs_to :program_category
  belongs_to :country
  belongs_to :course
 
  
  before_create :generate_registration

  def generate_registration
    self.reg_no = self.country.abbreviation + "00" + self.student.id.to_s + "/KIAC/#{Time.now.year}" 
  end
end
