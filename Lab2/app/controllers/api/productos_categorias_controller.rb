# app/controllers/api/productos_categorias_controller.rb

class Api::ProductosCategoriasController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # Supongamos que recibes el id del producto y de la categoría en los parámetros
    producto_id = params[:producto_id]
    categoria_id = params[:categoria_id]

    # Crea la asociación
    productos_categoria = ProductosCategorias.new(producto_id: producto_id, categoria_id: categoria_id)

    if productos_categoria.save
      render json: productos_categoria, status: :created
    else
      render json: productos_categoria.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # Supongamos que recibes el id de la asociación producto-categoria en los parámetros
    productos_categoria_id = params[:id]

    # Encuentra y destruye la asociación
    productos_categoria = ProductosCategorias.find(productos_categoria_id)
    productos_categoria.destroy

    head :no_content
  end
end
