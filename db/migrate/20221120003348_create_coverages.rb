class CreateCoverages < ActiveRecord::Migration[7.0]
  def change
    create_table :coverages do |t|
      t.references :insurance, null: false, foreign_key: true
      t.string :name
      t.float :factor

      t.timestamps
    end
  end
end
