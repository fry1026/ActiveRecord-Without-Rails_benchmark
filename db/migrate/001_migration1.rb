class Migration1 < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.text :title
      t.text :content
      t.boolean :read, default: false
      t.belongs_to :author, index: true
    end
    create_table :awards do |t|
      t.text :name
    end
    create_table :authors do |t|
      t.text :first_name
      t.text :last_name
      t.text :email
      t.text :full_content
    end
    create_table :award_presentations do |t|
      t.belongs_to :award, index: true
      t.belongs_to :author, index: true
    end
  end
end
