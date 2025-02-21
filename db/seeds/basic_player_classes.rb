class BasicPlayerClassSeeds
  def self.seed
    neutral = PlayerClass.create!(
      name: "Neutral",
      description: "Cards which can be used without a class restriction"
    )
    
    neutral.id = 0
    neutral.save!
    
    
    PlayerClass.create!(
      name: "Detainer",
      description: ""
    )
    
    PlayerClass.create!(
      name: "Magus",
      description: ""
    )
    
    PlayerClass.create!(
      name: "Sage",
      description: ""
    )
    
    PlayerClass.create!(
      name: "Trapper",
      description: ""
    )
    
    PlayerClass.create!(
      name: "Warden",
      description: ""
    )  
  end
end