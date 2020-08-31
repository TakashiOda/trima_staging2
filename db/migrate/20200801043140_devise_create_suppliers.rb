# frozen_string_literal: true

class DeviseCreateSuppliers < ActiveRecord::Migration[6.0]
  def change
    create_table :suppliers do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      # Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      # Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      #supplier_info
      t.string   :name
      t.string   :avatar

      # organizationから移行
      t.string  :manager_name
      t.integer :state_id
      t.integer :prefecture_id
      t.integer :town_id
      t.string :detail_address
      t.string :building
      t.string :post_code
      t.string :phone
      t.boolean :has_event, null: false, default: false
      t.boolean :has_spot, null: false, default: false
      t.boolean :has_activity, null: false, default: false
      t.boolean :has_restaurant, null: false, default: false
      t.integer :contract_plan, null: false, default: 0
      t.boolean :is_suspended, null: false, default: false #false:稼働, true:凍結
    end

    add_index :suppliers, :email,                unique: true
    add_index :suppliers, :reset_password_token, unique: true
    add_index :suppliers, :confirmation_token,   unique: true
    add_index :suppliers, :unlock_token,         unique: true
  end
end
