class AddFromToEmails < ActiveRecord::Migration[6.0]
  def change
    add_column :emails, :from, :string
  end
end
