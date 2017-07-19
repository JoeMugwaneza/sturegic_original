class StudentInfosController < ApplicationController
  def index
      
    end

    def show
      
    end

    def new
      @student = User.find_by(id: params[:student_id])
      @student_infos = StudentInfo.new
    end

    def create
      @student_infos = StudentInfo.new(student_infos_params)
      lkjlgkjfgkj
      if @student.save
        @
      end
    end

    def edit
      
    end

    def update
      
    end
    private
    def find_student_infos
      
    end
    def student_infos_params
      params.require(:student_info).permit(:education_level, :course_id, :program_category_id, :district_id, :city, :registrar_id, :student_id)
    end
    def find_program
      @program_category = ProgramCategory.find_by(id: 1)
  end
end
