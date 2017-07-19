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
      find_student_infos
      @student = @student_infos.student
    end

    def update
      find_student_infos
      if ProgramCategory.find_by(id: student_infos_params["program_category_id"]).courses.include?(Course.find_by(id: student_infos_params["course_id"]))
        @student_infos.update(student_infos_params)
        flash[:sucess] = "#{@student_infos.student.username} registration Info Updated"
        redirect_to "/"
      else
        redirect_to "/student_infos/#{find_student_infos.id}/edit"
      end
    end
    private
    def find_student_infos
      @student_infos = StudentInfo.find_by(id: params[:id])
    end
    def student_infos_params
      params.require(:student_info).permit(:education_level, :course_id, :program_category_id, :district_id, :registrar_id, :student_id, :country_id, :city)
    end
end
