class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :content
      t.string :title
      t.string :image
      t.float :latitude
      t.float :longitude
      t.string :category
      t.text :tags
      t.integer :rating
      t.boolean :denied
    end
  end
end