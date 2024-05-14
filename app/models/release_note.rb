class ReleaseNote < ApplicationRecord
    belongs_to :release_notable, polymorphic: true
end
