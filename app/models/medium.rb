class Medium < ActiveRecord::Base
  has_attached_file :path,
                    # styles: { large: "600x600>", medium: "300x300>", thumb: "150x150>" },
                    :path => ":rails_root/public/images/:id/:style/:filename",
                    :url  => "/images/:id/:style/:filename"
  validates_attachment :path, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif","application/zip","application/rar"] }

end
