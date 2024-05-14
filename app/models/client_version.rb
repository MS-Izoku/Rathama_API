class ClientVersion < ApplicationRecord
    include VersionManager
    has_many :release_notes, as: :release_notable
end
