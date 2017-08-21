class Course < ApplicationRecord
  has_many :students, class_name: 'StudentInfo', :dependent => :restrict_with_error
  belongs_to :program_category

  rails_admin do
    edit do
      exclude_fields :id, :students
    end
    list do
      exclude_fields :id, :students
      
      field :price do
        label 'Fees (Rwf)'
        formatted_value do # used in form views
          value.to_i
        end
        pretty_value do # used in list view columns and show views, defaults to formatted_value for non-association fields
          value.to_i
        end
        export_value do
          value.to_i # used in exports, where no html/data is allowed
        end
      end
    end
  end
end
