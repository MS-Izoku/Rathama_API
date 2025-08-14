class SeedExpansions
  def self.seed
    Expansion.find_or_create_by(name: 'Basic', description: 'Evergreen cards given to everyone at every level',
                                tagline: '')
    Expansion.find_or_create_by(name: 'Standard', description: 'Standard cards',
                                tagline: '')
  end
end
