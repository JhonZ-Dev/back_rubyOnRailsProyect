class ProductosCategorias < ApplicationRecord
  belongs_to :producto
  belongs_to :categoria
end
