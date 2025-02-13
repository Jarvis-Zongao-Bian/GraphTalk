class AddUserIdToDiscussions < ActiveRecord::Migration[8.0]
  def change
    add_reference :discussions, :user, null: true, foreign_key: true
  end
end
