class CreateBase < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.text :url
      t.text :title
      t.text :content
      t.timestamps
    end
    add_index :pages, :url
  end

  def self.down
    remove_index :pages, :url
    drop_table :pages
  end
end

