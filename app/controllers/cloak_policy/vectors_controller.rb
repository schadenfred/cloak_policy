module CloakPolicy
  class VectorsController < ApplicationController
    before_action :set_vector, only: [:show, :edit, :update, :destroy]

    def index
      @vectors = Vector.all
      @vector = Vector.new
    end

    def show
      # @platform_points = []
      # @platforms.each { |s| @platform_points << s.points_for(@vector.name) }
    end

    def new
      @vector = Vector.new(parent_id: params[:id] || nil)
    end

    def edit
    end

    def create
      @vector = Vector.new(vector_params)

      respond_to do |f|
        if @vector.save
          f.html { redirect_to vectors_path, success: 'Vector created.' }
        else
          f.html { render :new }
          f.json { render json: @vector.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @vector.update(vector_params)
          format.html { redirect_to vectors_path, notice: 'Vector was successfully updated.' }
          format.json { render :show, status: :ok, location: @vector }
        else
          format.html { render :edit }
          format.json { render json: @vector.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @vector.destroy
      respond_to do |format|
        format.html { redirect_to admin_vectors_path, notice: 'Vector destroyed.' }
      end
    end

    private
      def set_vector
        @vector = Vector.find(params[:id])
        @platforms = Platform.all
      end

      def vector_params
        params.fetch(:vector).permit!
      end
  end
end