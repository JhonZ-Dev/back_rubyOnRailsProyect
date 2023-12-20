# app/controllers/api/movimiento_inventario_controller.rb

class Api::MovimientoInventarioController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_movimiento_inventario, only: [:show, :update, :destroy]
  
    def index
      movimientos_inventario = MovimientoInventario.all
      render json: movimientos_inventario
    end
  
    def show
      render json: @movimiento_inventario
    end
  
    def create
        # Extraer el producto_id de la URL
        producto_id = params[:producto_id]
        
        # Crear un nuevo movimiento de inventario
        movimiento_inventario = MovimientoInventario.new(movimiento_inventario_params.merge(producto_id: producto_id))
    
        if movimiento_inventario.save
          render json: movimiento_inventario, status: :created
        else
          render json: movimiento_inventario.errors, status: :unprocessable_entity
        end
    end
  
    def update
      if @movimiento_inventario.update(movimiento_inventario_params)
        render json: @movimiento_inventario
      else
        render json: @movimiento_inventario.errors, status: :unprocessable_entity
      end
    end
  
    # def destroy
    #   @movimiento_inventario = MovimientoInventario.find(params[:id])
    #   @movimiento_inventario.destroy
    #   head :no_content
    # end

    def destroy
      # Eliminar las asociaciones en productos_categoria
      MovimientoInventario.where(id: @movimiento_inventario.id).destroy_all
      # Ahora puedes eliminar la categoría
      @movimiento_inventario.destroy
      head :no_content
    end
  
    private
  
    def set_movimiento_inventario
      @movimiento_inventario = MovimientoInventario.find(params[:id])
    end
  
    def movimiento_inventario_params
      params.require(:movimiento_inventario).permit(:producto_id, :cantidad, :fecha_movimiento, :tipo_movimiento)
    end
  end
  