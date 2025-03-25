class SeedExpansions
  def self.seed
    Expansion.find_or_create_by(name: 'Basic', description: 'Evergreen cards given to everyone at every level',
                                tagline: '')
  end
end
