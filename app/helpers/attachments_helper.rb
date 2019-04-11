module AttachmentsHelper
  def download_link(attachment,options = {nil_text: '- ไม่ได้แนบ -', text: nil})
    if attachment and attachment.data
      render partial: 'attachments/download', locals: {attachment: attachment, text: options[:text]}
    else
      tag.span options[:nil_text], class: 'red-text'
    end
  end
end
