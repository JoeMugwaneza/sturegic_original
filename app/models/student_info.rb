class StudentInfo < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :registrar, class_name: 'User'
  belongs_to :district, optional: true
  belongs_to :program_category
  belongs_to :country
  belongs_to :course

  mount_uploader :bankslip, BankslipUploader
  
  before_create :generate_registration

  rails_admin do
    edit do
      exclude_fields :id, :student_id, :registrar_id,:created_at, :updated_at, :bankslip
    end

    list do
      # filters [:education_level, :city, :created_at, :status, :reg_no]
      # Manually enable/disable per field
      field :student do
        filterable false
      end

      field :registrar do
        filterable false
      end

      field :district do
        filterable false
      end

      field :country do
        filterable false
      end

      field :program_category do
        filterable false
      end
      field :program_time do
        filterable false
      end
      field :education_level do
        filterable true
      end

      field :course do
        filterable false
      end

      field :city do
        filterable true
      end

      field :created_at do
        filterable true
      end

      field :status do
        filterable true
      end 

      field :reg_no do
        filterable true
      end

      field :bankslip do
        filterable false
      end
    end
  end



  def generate_registration
    self.reg_no = self.country.abbreviation + "00" + self.student.id.to_s + "/KIAC/#{Time.now.year}" 
  end
end
