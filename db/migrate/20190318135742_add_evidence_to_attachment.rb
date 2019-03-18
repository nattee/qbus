class AddEvidenceToAttachment < ActiveRecord::Migration[5.2]
  def change
    add_reference :attachments, :evidence
  end
end
