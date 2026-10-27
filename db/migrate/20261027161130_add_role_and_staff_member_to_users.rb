class AddRoleAndStaffMemberToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :string, null: false, default: "counter"
    add_reference :users, :staff_member, null: true,
                  foreign_key: true, index: { unique: true }

    remove_index :users, :email_address, unique: true
    add_index :users, "lower(email_address)", unique: true,
              name: "index_users_on_lower_email_address"
  end
end