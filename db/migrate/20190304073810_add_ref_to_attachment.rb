class AddRefToAttachment < ActiveRecord::Migration[5.2]
  def change
    add_reference :attachments, :criterium_attachment, foreign_key: true
    add_reference :attachments, :application, foreign_key: true
  end
end
