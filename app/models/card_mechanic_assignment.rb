class CardMechanicAssignment < ApplicationRecord
  belongs_to :card # Yes, this is required to establish the association

  # Generates a formatted mechanic string based on the lifecycle and provided mechanics
  # Example input:
  # lifecycle_stage = "Call"
  # mechanics = ["Evoke(SingleAlly)", "Copy(SingleAlly)"]
  # Expected output: "Call:Evoke(SingleAlly)|Copy(SingleAlly)"
  def self.create_adjusted_mechanic_string(lifecycle_stage, mechanics)
    formatted_mechanics = mechanics.map(&:strip).join('|')
    "#{lifecycle_stage}::#{formatted_mechanics}".delete(' ')
  end
end
