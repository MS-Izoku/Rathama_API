# Rathama API


## Data Models

### Cards
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



### Decks
### Expansions

### API Keys

#### Permissions


## Development Notes

### Converting to Postgres from SQLite

#### API Permissions
* Postgres allows for Array/List based storage.  This is used for API Key Permissions
* Uncomment the migration line in AddPermissionsToApiKey after conversion

* For SQLite development, the ApplicationControllers#validate_api_key_permissions method always returns true
* validating API Permissions is not currently possible since the array of permissions cannot be stored