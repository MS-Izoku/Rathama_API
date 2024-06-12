# Rathama API

## Cards
Cards are set into 6 basic categories (3 of which are considered a "basic" type of card that are always included in all classes), each handled via Single Table Inheritance.

### Fiend Cards (Minions, Monsters)
Fiends are playable cards that take up a space on the board.  They are one of the 3 basic types (along-side Spells and Traps).


### Spell Cards
Spells are playable single-use cards that activate upon playing them.  They are one of the 3 basic types (alongside Spells and Traps).

##### Data Fields


### Trap Cards

### Hero Cards
Heroes replace the current Player's default hero, and change at least one of their Scale Powers (of the Player's choice)


### Monuments (Locations, Non-Attacking Fiends)
Monuments are cards that take up a single space on the board and have a set durability.  They can activate once per turn and have a cooldown, activating their effect.

### Weapons
Weapon cards are durability-based cards that temporarily replace one of a player's Scale Powers.




### Scale Powers ("Hero Powers")
Scale Powers are abilities players can use once per turn for a set mana cost.  Some Scale Powers automatically activate, and others have no mana cost asscociated with them.  They can act as passive or active effects, though are typically not as powerful as cards of their same cost.

#### Data Fields
* 


## Decks
### Expansions

### API Keys

#### Permissions



## Quests and Rewards
### Quests
Quests are models that have any number of rewards. They can be Daily, Weekly, Monthly, Special, or Seasonal.

### PlayerQuests
A joiner class between Quests and Players, which contains data regarding the completion of that quest for a specific player.

### Rewards
Rewards involve the polymorphic rewardable relationship, where rewards can be anything from Cards to InGameCurrency.

To make a model rewardable (ie: player cosmetics or whatever), add the following line to that model
```
belongs_to :rewardable, polymorphic: true
```

A Reward Mdoel also has an integer field for :quantity, which exists to give a numerical value to whatever reward is present.  If you want to give 2 Cards instead of one, simply provide the reward model with a number.

```
reward1 = quest.rewards.create(amount: 200, rewardable: InGameCurrency.first)
reward2 = quest.rewards.create(amount: 300, rewardable: InGameCurrency.last)
```

## Development Notes

### Converting to Postgres from SQLite

#### API Permissions
* Postgres allows for Array/List based storage.  This is used for API Key Permissions
* Uncomment the migration line in AddPermissionsToApiKey after conversion

* For SQLite development, the ApplicationControllers#validate_api_key_permissions method always returns true
* validating API Permissions is not currently possible since the array of permissions cannot be stored


### Json Serialization
We currently use the oj_serialization package to render json wherever possible, which keeps things generally clean and fast.