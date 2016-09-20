module Api
  module V1

    class TeachersController < ApplicationController
      def index
        render json: Teacher.all
      end

      def show
        teacher=Teacher.find(params[:id])
        render json: teacher
      end

      def create
        teacher=Teacher.new(teacher_params)
        if teacher.save
          render json: teacher
        else
          render json: teacher.errors, status:500
        end
      end

      def update
        teacher= Teacher.find(params[:id])
        if teacher.update(teacher_params)
          render json: teacher
        else
          render json: teacher.errors, status: 500
        end
      end

      def destroy
        teacher=Teacher.find_by(id: params[:id])
        if teacher
          teacher.destroy
          head :ok
        else
          render json: {"error"=>"teacher with id of #{params[:id]} not found"}, status: 404
        end
      end


      private

      def teacher_params
        params.require(:teacher).permit(:name, :subject, :quote)
      end

    end
  end
end
