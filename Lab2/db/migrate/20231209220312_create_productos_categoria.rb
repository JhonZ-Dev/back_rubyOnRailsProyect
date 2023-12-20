class CreateProductosCategoria < ActiveRecord::Migration[7.1]
  def change
    create_table :productos_categorias do |t|
      t.references :producto, null: false, foreign_key: { on_delete: :cascade }
      t.references :categorias, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps null: false, default: -> { 'CURRENT_TIMESTAMP' }  # Configurar valor por defecto a la fecha actual
    end
  end
end
