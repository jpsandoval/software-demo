class Api::StudentsController < ApplicationController
   # GET /api/students
  def index
    students = Student.all
    render json: students
  end

  # POST /api/students
  def create
    student = Student.new(student_params)
    if student.save
      render json: student, status: :created
    else
      render json: student.errors, status: :unprocessable_entity
    end
  end

  private

  def student_params
    params.require(:student).permit(
      :nickname,
      :age,
      :house,
      :grade,
      :hobby,
      :favorite_color,
      :pet_name,
      :pet_kind
    )
  end
end
