class SeedExpansions
  def self.seed
    Expansion.find_or_create_by(name: 'Basic')
  end
end