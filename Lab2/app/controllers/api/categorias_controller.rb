# app/controllers/api/categorias_controller.rb

class Api::CategoriasController < ApplicationController
    before_action :set_categoria, only: [:show, :update, :destroy]
    skip_before_action :verify_authenticity_token
  
 
  
    def show
      render json: @categoria
    end
  
    def create
      categoria = Categorias.new(categoria_params)
  
      if categoria.save
        render json: categoria, status: :created
      else
        render json: categoria.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @categoria.update(categoria_params)
        render json: @categoria
      else
        render json: @categoria.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @categoria.destroy
      head :no_content
    end
  
    private
  
    def set_categoria
      @categoria = Categorias.find(params[:id])
    end
  
    def categoria_params
      params.require(:categoria).permit(:nombre, :descripcion) # Ajusta los atributos según tu modelo
    end
  end
  