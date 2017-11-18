class TagJobship < ApplicationRecord
  belongs_to :tag
  belongs_to :job
end
