class RenamePublicCommentCommenter < ActiveRecord::Migration[5.2]
  def change
    change_table :public_comments do |t|
      t.rename :commenter, :commenter_name
    end
  end
end
