class Api::ProductoController < ApplicationController
    before_action :set_producto, only: [:show, :edit, :update, :destroy]
    skip_before_action :verify_authenticity_token
      # GET /api/productos
  def index
    @productos = Producto.all
    render json: @productos
  end

  # GET /api/productos/1
  def show
    render json: @producto
  end

  # GET /api/productos/new
  def new
    @producto = Producto.new
  end

  # POST /api/productos
  def create
    @producto = Producto.new(producto_params)

    if @producto.save
      render json: @producto, status: :created
    else
      render json: @producto.errors, status: :unprocessable_entity
    end
  end

  # GET /api/productos/1/edit
  def edit
  end

  # PATCH/PUT /api/productos/1
  def update
    if @producto.update(producto_params)
      render json: @producto
    else
      render json: @producto.errors, status: :unprocessable_entity
    end
  end


  # GET /api/productos_con_categorias
  def productos_con_categorias
    @productos = Producto.includes(:categorias).all
    render json: @productos.as_json(include: :categorias)
  end
  # GET /api/productos_con_categorias
  def productos_con_categorias2
    sql = <<~SQL
      SELECT p.nombre AS producto_nombre, p.id AS id_producto, c.nombre AS categoria_nombre, pc.id as id
      FROM productos p
      INNER JOIN productos_categorias pc ON p.id = pc.producto_id
      INNER JOIN categorias c ON c.id = pc.categorias_id
    SQL

    result = ActiveRecord::Base.connection.execute(sql)
    render json: result
  end

  # DELETE /api/productos/1
  def destroy
    # @producto.destroy
    # head :no_content
    @producto = Producto.find(params[:id])
    @producto.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_producto
    @producto = Producto.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def producto_params
    params.require(:producto).permit(:nombre, :precio, :stock)
  end
end
