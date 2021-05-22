class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :lastname
      t.string :company

      t.timestamps
    end
  end
end
