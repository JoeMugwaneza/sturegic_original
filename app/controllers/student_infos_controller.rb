class StudentInfosController < ApplicationController
  def index
      
    end

    def show
      
    end

    def new
      @program_category = ProgramCategory.find_by(id: params[:program_id])
      @student = User.find_by(id: params[:student_id])
      @student_infos = StudentInfo.new
    end

    def create
      @student_infos = StudentInfo.new(student_infos_params)
      if @student_infos.save
       flash[:scuess] = "Student Application Successfully Submited" 
       redirect_to "/"
      else
        render :new
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
      params.require(:student_info).permit(:education_level, :course_id, :program_category_id, :district_id, :registrar_id, :student_id, :country_id)
    end
    def find_program
      @program_category = ProgramCategory.find_by(id: 1)
  end
end
