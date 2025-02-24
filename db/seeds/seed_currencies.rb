class SeedCurrencies
  def self.seed 
    Currency.find_or_create_by(name: "Gold")
  end
end