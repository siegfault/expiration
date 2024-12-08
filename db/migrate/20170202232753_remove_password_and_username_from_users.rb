# frozen_string_literal: true

class RemovePasswordAndUsernameFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :password_digest # rubocop:todo Rails/BulkChangeTable
    remove_column :users, :username
  end

  def down
    add_column :users, :password_digest, :string # rubocop:todo Rails/BulkChangeTable
    add_column :users, :username, :string

    User.update_all("password_digest = '', username = email") # rubocop:todo Rails/SkipsModelValidations

    change_column_null :users, :password_digest, false # rubocop:todo Rails/BulkChangeTable
    change_column_null :users, :username, false
  end
end
