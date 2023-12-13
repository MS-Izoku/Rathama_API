class FiendCard < Card

    # validate required data presence
    validates_presence_of :attack, :defense
    
    # validate absence of data
    validates :armor, absence: true
    validates :durability, absence: true

    # validate required base values of data
    validates :attack, numericality: { greater_than_or_equal_to: 0 }
    validates :health, numericality: { greater_than_or_equal_to: 1 }
end
