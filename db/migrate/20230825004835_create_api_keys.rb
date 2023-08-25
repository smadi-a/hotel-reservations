class CreateAPIKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys do |t|
      t.string :key, null: false
      t.string :partner_name
      t.boolean :disabled, null: false, default: false

      t.timestamps
    end
  end
end
