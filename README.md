# Rathama API

## Cards
Cards are set into 6 basic categories (3 of which are considered a "basic" type of card that are always included in all classes), each handled via Single Table Inheritance.

### Fiend Cards (Minions, Monsters)
Fiends are playable cards that take up a space on the board.  They are one of the 3 basic types (along-side Spells and Traps).


### Spell Cards
Spells are playable single-use cards that activate upon playing them.  They are one of the 3 basic types (alongside Spells and Traps).

##### Data Fields


### Trap Cards
Trap Cards are playable single-use (in all cases) Cards, which take up "Trap" spaces on the game board.  Up to 5 different Traps can be active at any time on the board.


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
Decks are the lifeblood of the game, next to the cards themselves.  Players can create decks and send them to each other using a "Deck Code", which is a base64 encrypted string representing the ids of the cards.

If players have the cards in their collection and use the deck code, they can automatically create that deck in their profile.  If they do not have those cards, the remaining cards will not be included during the deck-building.  They will have the opportunity to create those cards in the client if they have the resources, otherwise they will need to be replaced with others from their current collection before the deck is playable.

### Expansions
Expansions are where new cards come into play.  Each new set of cards, be it a mini-set or full expansion, belong to this parent model.  While decks themselves are not directly tied to Expansions, the years that Expansions come out often change what cards can be played in a deck.

In certain standard rotation scenarios, where the past x-number of years of cards is available for play, only cards within those years can be used for standard deck-building.

In other formats, certain years may be included or excluded depending on the cirumstances and/or game mode being played or deck-built for.

There should always be a format where all cards can be played, no card should be useless and unplayable (but they can be bad in terms of design and playability).


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

## Logging into Github
### If you have your SSH already set up
Enter this in your terminal:
```
ssh -T git@github.com
```

### If you don't have your SSH set up
Set it up and use the above step to log in.