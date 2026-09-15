class CreateRepairs < ActiveRecord::Migration[8.1]
  def change
    create_table :repairs do |t|
      t.bigint :bike_id, null: false
      t.bigint :staff_member_id
      t.string :status, null: false, default: "received"
      t.datetime :received_at, null: false
      t.datetime :quoted_at
      t.string :customer_response
      t.datetime :customer_responded_at
      t.date :promised_on
      t.datetime :returned_at

      t.timestamps
    end
  end
end