class CardMechanicAssignment < ApplicationRecord
    belongs_to :card

    # create a 
    def create_whole_mechanic_string
        "#{lifecycle_stage}::#{mechanic_string}"
    end

    # since mechanic strings have specific args, we need to parse
    # each of the args and create that string here
    # ie: DealDamage(damage:integer, target:target_type) should look like DealDamage(5, SingleTarget)
    def create_adjusted_mechanic_string
    end
end
