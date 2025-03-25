class SeedsController < ApplicationController
    def seed_all
      @completed = []
      @failed = nil
  
      {
        "Tribes and Spell Schools" => -> { SeedTribesAndSpellSchools.seed },
        "Basic Cards" => -> { SeedBasicCards.seed },
        "Card Mechanics" => -> { SeedCardMechanics.seed }
      }.each do |name, method|
        begin
          method.call
          @completed << name
        rescue StandardError => e
          @failed = { name: name, error: e.message, full_error: e }
          break
        end
      end
  
      render json: {
        message: @failed ? "Seeding failed::#{@failed.name}" : "Seeding completed",
        completed: @completed,
        failed: @failed,
        full_error: @failed.full_error
        }
    rescue StandardError => e
      render json: { message: "Seeding process failed", error: e.message, completed: @completed, failed: @failed, full_error: e }, status: :internal_server_error
    end
  
    # region Card Type Attributes
    def seed_tribes_and_spell_schools
      SeedTribesAndSpellSchools.seed
      render json: { message: "Seeded Tribes and Spell Schools" }
    rescue StandardError => e
      render json: { message: "Failed to seed Tribes and Spell Schools", error: e.message, full_error: e }, status: :internal_server_error
    end
  
    def seed_tribes
      SeedTribesAndSpellSchools.seed_tribes
      render json: { message: "Seeded Tribes" }
    rescue StandardError => e
      render json: { message: "Failed to seed Tribes", error: e.message, full_error: e }, status: :internal_server_error
    end
  
    def seed_spell_schools
      SeedTribesAndSpellSchools.seed_spell_schools
      render json: { message: "Seeded Spell Schools" }
    rescue StandardError => e
      render json: { message: "Failed to seed Spell Schools", error: e.message, full_error: e }, status: :internal_server_error
    end
    # endregion
  
    # region Card Seeding
    def seed_basic_cards
      SeedBasicCards.seed
      render json: { message: "Seeded Basic Cards" }
    rescue StandardError => e
      render json: { message: "Failed to seed Basic Cards", error: e.message, full_error: e }, status: :internal_server_error
    end
    # endregion
  
    # region Card Mechanics
    def seed_card_mechanics
      SeedCardMechanics.seed
      render json: { message: "Seeded Card Mechanics" }
    rescue StandardError => e
      render json: { message: "Failed to seed Card Mechanics", error: e.message, full_error: e }, status: :internal_server_error
    end
    # endregion
  end