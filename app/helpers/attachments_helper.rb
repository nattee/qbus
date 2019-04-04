module AttachmentsHelper
  def download_link(attachment,options = {nil_text: '- ไม่ได้แนบ -'})
    if attachment and attachment.data
      render partial: 'attachments/download', locals: {attachment: attachment}
    else
      tag.span options[:nil_text], class: 'red-text'
    end
  end
end
