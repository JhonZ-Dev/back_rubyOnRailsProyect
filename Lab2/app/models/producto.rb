class Producto < ApplicationRecord
    has_many :productos_categorias, class_name: 'ProductosCategorias', dependent: :destroy
    has_many :categorias, through: :productos_categorias, class_name: 'Categoria'
    has_many :movimiento_inventario, dependent: :destroy

end
