class AddPhoneExt < ActiveRecord::Migration
  def change
    add_column :people, :phone_ext, :string
    add_column :local_resources, :phone_ext, :string
  end
end
