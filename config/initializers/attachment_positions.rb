ActiveSupport.on_load(:active_storage_attachment) do
  ActiveStorage::Attachment.class_eval do
    default_scope { order('position asc, id asc') }
  end
end