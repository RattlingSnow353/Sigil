--- STEAMODDED HEADER
--- MOD_NAME: Sigil
--- MOD_ID: sigil
--- MOD_AUTHOR: [Coding: RattlingSnow353, Ideas and Art: In description]
--- MOD_DESCRIPTION: a war crime against literally everything. Ideas and Art by [notmario, zy-b-org, NewtTheFish, ilikecheese, lyman, timetoexplode, MathIsFun_, Luna!, Pinkers, CrimsonHeart, Nozomi Tojo, Aure, Flare, balatrostuck gaming, Soundwave, RattlingSnow353, rock man, 5381, Coro, Twilight, l_kao, .flowr, b.b.b.b., and probably more] 
--- BADGE_COLOUR: DF509F
--- DISPLAY_NAME: Sigil
--- VERSION: 1.0.0
--- PREFIX: sshs

----------------------------------------------
------------MOD CODE -------------------------

local mod = SMODS.current_mod
local mod_path = SMODS.current_mod.path
sigil_config = SMODS.current_mod.config

function Card:get_suit()
    if self.ability.effect == 'Stone Card' and not self.vampired then
        return -math.random(100, 1000000)
    end
    return self.base.suit
end

local function is_face(card)
    local id = card:get_id()
    return id == 11 or id == 12 or id == 13
end

function shakecard(self)
    G.E_MANAGER:add_event(Event({
        func = function()
            self:juice_up(5, 3)
            return true
        end
    }))
end

local function create_consumable(card_type,tag,message,extra)
    extra=extra or {}
    
    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = (function()
                local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, extra.forced_key or nil, tag)
                card:add_to_deck()
                if extra.edition~=nil then
                    card:set_edition(extra.edition,true,false)
                end
                if extra.eternal~=nil then
                    card.ability.eternal=extra.eternal
                end
                if extra.perishable~=nil then
                    card.ability.perishable = extra.perishable
                    if tag=='v_epilogue' then
                        card.ability.perish_tally=get_voucher('epilogue').config.extra
                    else card.ability.perish_tally = G.GAME.perishable_rounds
                    end
                end
                if extra.extra_ability~=nil then
                    card.ability[extra.extra_ability]=true
                end
                G.consumeables:emplace(card)
                G.GAME.consumeable_buffer = 0
                if message~=nil then
                    card_eval_status_text(card,'extra',nil,nil,nil,{message=message})
                end
        return true
    end)}))
end

local function create_joker(card_type,tag,message,extra)
    extra=extra or {}
    
    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = (function()
                local card = create_card(card_type, G.joker, nil, nil, nil, nil, extra.forced_key or nil, tag)
                card:add_to_deck()
                if extra.edition~=nil then
                    card:set_edition(extra.edition,true,false)
                end
                if extra.eternal~=nil then
                    card.ability.eternal=extra.eternal
                end
                if extra.perishable~=nil then
                    card.ability.perishable = extra.perishable
                    if tag=='v_epilogue' then
                        card.ability.perish_tally=get_voucher('epilogue').config.extra
                    else card.ability.perish_tally = G.GAME.perishable_rounds
                    end
                end
                if extra.extra_ability~=nil then
                    card.ability[extra.extra_ability]=true
                end
                G.jokers:emplace(card)
                G.GAME.joker_buffer = 0
                if message~=nil then
                    card_eval_status_text(card,'extra',nil,nil,nil,{message=message})
                end
        return true
    end)}))
end

local function cleanSuitName(suitName, replacement)
  replacement = replacement or ""  
  local cleaned = suitName:gsub("([^%w])", function(c)
    return replacement 
  end)
  return cleaned
end

local cursuit = {
    "Acorn",
    "Rook",
    "Garfield",
    "L",
    "Chrome",
    "Bell",
    "Roflmao",
    "Spade?",
    "Heartless",
    "Gameboy",
    "Null",
    "Blood",
    "Honeycomb",
    "Jimbo",
    "Flame",
    "Cogwheel",
    "Homestuck",
    "Red Card",
    "Blue Card",
    "Eight",
    "Rubie",
    "Emerald",
    "Sapphire",
    "Interrobang",
    "Cube",
    "Nope",
    "Battery",
    "Bone",
    "Small",
    "Big",
    "Treble",
    "D6",
    "Dollar",
    "Euro",
    "Yen",
    "Pound",
    "Bolt",
    "Point",
    "Arrow",
    "Triangle",
    "Shield",
    "Duo Spade",
    "Crosse",
    "Star",
    "Circle",
    "Square",
    "Fleur",
    "Paw",
    "Car",
    "Snowflake",
    "Sword",
    "Hourglasse",
    "Puzzle",
    "Minotaur",
    "Spanner",
    "Key",
    "Tulip",
    "Cherry Blossom",
    "Sweet",
    "Salty",
    "Spicy",
    "Sour",
    "Bullet",
    "Pelt",
    "Yellow Card",
    "Seven",
    "W",
    "Sedap",
    "Spart",
    "Pearl",
    "Claymore",
    "Losse",
    "Black Card",
    "Suit",
    "Seal",
    "Gamecube",
    "DSe",
    "Nintendo Switche",
    "Arie",
    "Tauruse",
    "Gemini",
    "Cancer",
    "Super Mushroom",
    "Fire Flower",
    "Cape Feather",
    "Super Star",
    "Cloud",
    "Goomba",
    "Boo",
    "Bowser",
    "Mario",
    "Luigi",
    "Yoshi",
    "Wario",
    "Metrolinxe",
    "GO Transit",
    "TTC",
    "OC Transpo",
    "ASDA",
    "Sainsbury",
    "Tesco",
    "LIDL",
    "Starburst",
    "Crescent",
    "Cup",
    "Coin",
    "Wakka",
    "Cherrie",
    "Ghost",
    "Pellet",
    "Tube",
    "Over",
    "Dockland",
    "Purple",
    "Fortres",
    "Portal",
    "Lambda",
    "Orange Boxe",
}

local cursuitcolor = {
    "2c9850",
    "706956",
    "fda857",
    "4a148c",
    "1a73e8",
    "76a877",
    "ffd93a",
    "3c4a79",
    "e0483e",
    "495b16",
    "000000",
    "50203e",
    "ffae00",
    "fd5f55",
    "d66b1b",
    "ff6a00",
    "49da4c",
    "fe5f55",
    "009cfd",
    "1f6b0d",
    "f68125",
    "9cbf55",
    "3fa273",
    "b200ff",
    "1b265e",
    "4e3381",
    "74ffdc",
    "f7db9c",
    "3a55ab",
    "e0a23a",
    "0097a7",
    "7cb342",
    "ffaa00",
    "2f71d1",
    "2f712f",
    "b200ff",
    "9164af",
    "67af69",
    "422c5b",
    "dbc900",
    "c42d2d",
    "2d47c6",
    "347189",
    "2b7c66",
    "61663b",
    "663b3b",
    "ffd700",
    "ef9b3c",
    "ff6f4a",
    "42eafe",
    "6c3d3d",
    "573d6c",
    "6c3d63",
    "a48447",
    "fdf639",
    "f69f6f",
    "fd5f55",
    "e6bab7",
    "ff66ba",
    "d1d1d1",
    "eb5233",
    "b5ff3e",
    "929bae",
    "c0aa89",
    "fda200",
    "42ce82",
    "363e70",
    "c3bc97",
    "fe5f55",
    "dcdcdc",
    "9bafcf",
    "4f6367",
    "4f6367",
    "008fe7",
    "ed5249",
    "8d94bf",
    "929497",
    "ff0000",
    "a10000",
    "a25203",
    "a1a100",
    "626262",
    "ff8080",
    "ff8040",
    "f87800",
    "ffb500",
    "9aa3a7",
    "553e1a",
    "a0a0a0",
    "ff0000",
    "ff0000",
    "008040",
    "006b00",
    "ffff00",
    "000000",
    "4a7729",
    "da251d",
    "ed1b2d",
    "7dc242",
    "ff8e00",
    "da3a3a",
    "fff000",
    "960096",
    "0000e6",
    "1b7763",
    "f8f91a",
    "fff000",
    "ff0000",
    "ffa000",
    "f7b6af",
    "e1251f",
    "ee7623",
    "00afaa",
    "5a419b",
    "4f6367",
    "73def4",
    "ff9a54",
    "fc7e27",
}

local curblindsname = {
    "The Squirrel",
    "The Bishop",
    "The Monday",
    "The Ratio",
    "The Fox",
    "The Gong",
    "The LOL",
    "The Goad?",
    "The Kingdom",
    "The DS",
    "The Error",
    "The Bandage",
    "The Bear",
    "The Batman",
    "The Extinguisher",
    "The Jam",
    "The English",
    "The Green",
    "The Orange",
    "The Octophobe",
    "The Squadron",
    "The Lars",
    "The Court",
    "The Period",
    "The Tesseract",
    "The Agreement",
    "The Blackout",
    "Bone",
    "Small",
    "Big",
    "Treble",
    "D6",
    "Dollar",
    "Euro",
    "Yen",
    "Pound",
    "Bolt",
    "Point",
    "Arrow",
    "Triangle",
    "Shield",
    "DuoSpade",
    "Cross",
    "Star",
    "Circle",
    "Square",
    "Fleur",
    "Paw",
    "Car",
    "Snowflake",
    "Sword",
    "Hourglasse",
    "Puzzle",
    "Minotaur",
    "Spanner",
    "Key",
    "Tulip",
    "Cherry Blossom",
    "The Cavity",
    "The Tapwater",
    "The Bland",
    "The Sugarcookie",
    "Bullet",
    "Pelt",
    "Yellow Card",
    "Seven",
    "W",
    "Sedap",
    "Spart",
    "Pearl",
    "Claymore",
    "The Hospital Bill",
    "Black Card",
    "Suit",
    "Seal",
    "Gamecube",
    "DSe",
    "Nintendo Switche",
    "Arie",
    "Tauruse",
    "Gemini",
    "Cancer",
    "Super Mushroom",
    "Fire Flower",
    "Cape Feather",
    "Super Star",
    "Cloud",
    "Goomba",
    "Boo",
    "Bowser",
    "Mario",
    "Luigi",
    "Yoshi",
    "Wario",
    "Metrolinxe",
    "GO Transit",
    "TTC",
    "OC Transpo",
    "ASDA",
    "Sainsbury",
    "Tesco",
    "LIDL",
    "Starburst",
    "Crescent",
    "Cup",
    "Coin",
    "Wakka",
    "Cherrie",
    "Ghost",
    "Pellet",
    "Tube",
    "Over",
    "Dockland",
    "Purple",
    "Fortres",
    "Portal",
    "Lambda",
    "Orange Boxe",
}

local curblindscolor = {
    "a98a54",
    "c6e0eb",
    "FDF5A8",
    "7ca7ac",
    "a96415",
    "979797",
    "cac224",
    "b95c96",
    "bfc0c4",
    "6f7fe1",
    "38b4b5",
    "ddb94e",
    "907117",
    "4b4b4b",
    "e31f1f",
    "c26b5d",
    "2ed73a",
    "1e8c1c",
    "dd7b2f",
    "175109",
    "9ff524",
    "f9a6de",
    "905f27",
    "b200ff",
    "00ade5",
    "178b00",
    "000000",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "906892",
    "4a86e8",
    "980000",
    "e3cc93",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "6c888e",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
    "373e68",
}

local sinjokename = {
    "Seedy Joker",
    "Orthogonal Joker",
    "Pathetic Joker",
    "Loquacious Joker",
    "Chromatic Joker",
    "Ringing Joker",
    "Epic Joker",
    "Wrathful? Joker",
    "Unfeeling Joker",
    "Retro Joker",
    "Missing Joker",
    "Bleeding Joker",
    "Buzzy Joker",
    "Inceptive Joker",
    "Flaming Joker",
    "Steampunk Joker",
    "Sburban Joker",
    "Discarding Joker",
    "Drawing Joker",
    "Octet Joker",
    "Furious Joker",
    "Mountainous Joker",
    "Patient Joker",
    "Shocked Joker",
    "Three Dimensional Joker",
    "Disagreeable Joker",
    "Charged Joker",
    "Skeletal Joker",
    "Miniscule Joker",
    "Towering Joker",
    "Operatic Joker",
    "Rolling Joker",
    "Rich Joker",
    "European Joker",
    "Ritchi Joker",
    "Hefty Joker",
    "Electric Joker",
    "Pointy Joker",
    "Directional Joker",
    "Pythagorean Joker",
    "Defensive Joker",
    "WrathWratful Joker",
    "Crossed Joker",
    "Stellar Joker",
    "Rounded Joker",
    "Equilateral Joker",
    "French Joker",
    "Clawing Joker",
    "Driving Joker",
    "Cold Joker",
    "Offensive Joker",
    "Waiting Joker",
    "Puzzled Joker",
    "Labyrinthine Joker",
    "Handy Joker",
    "Unlocked Joker",
    "Blooming Joker",
    "Blossoming Joker",
    "Hyper Joker",
    "Dehydrated Joker",
    "Handsome Joker",
    "Sour Gummy Joker",
    "American Joker",
    "Pelt",
    "Yellow Card",
    "Seven",
    "W",
    "Rekoj Lufhtarw",
    "Spart",
    "Pearl",
    "Claymore",
    "Grieving Joker",
    "Black Card",
    "Suit",
    "Seal",
    "Gamecube",
    "DSe",
    "Nintendo Switche",
    "Arie",
    "Tauruse",
    "Gemini",
    "Cancer",
    "Super Mushroom",
    "Fire Flower",
    "Cape Feather",
    "Super Star",
    "Cloud",
    "Goomba",
    "Boo",
    "Bowser",
    "Mario",
    "Luigi",
    "Yoshi",
    "Wario",
    "Metrolinxe",
    "GO Transit",
    "TTC",
    "OC Transpo",
    "ASDA",
    "Sainsbury",
    "Tesco",
    "LIDL",
    "Starburst",
    "Crescent",
    "Cup",
    "Coin",
    "Wakka",
    "Cherrie",
    "Ghost",
    "Pellet",
    "Tube",
    "Over",
    "Dockland",
    "Purple",
    "Fortres",
    "Portal",
    "Lambda",
    "Orange Boxe",
}

local tarotname = {
    "The Seed",
    "The Castle",
    "The Lasagna",
    "L",
    "Chrome",
    "Bell",
    "Roflmao",
    "Spadel",
    "Heartless",
    "Gameboy",
    "The Blank",
    "Blood",
    "Honeycomb",
    "Jimbo",
    "Flame",
    "Cogwheel",
    "The Medium",
    "Red Card",
    "Blue Card",
    "Eight",
    "Rubie",
    "Emerald",
    "Sapphire",
    "Interrobang",
    "Cube",
    "Nope",
    "Battery",
    "Bone",
    "Small",
    "Big",
    "Treble",
    "D6",
    "Dollar",
    "Euro",
    "Yen",
    "Pound",
    "Bolt",
    "Point",
    "Arrow",
    "Triangle",
    "Shield",
    "DuoSpade",
    "Cross",
    "Star",
    "The Radius",
    "Square",
    "Fleur",
    "Paw",
    "Car",
    "Snowflake",
    "Sword",
    "Hourglasse",
    "Puzzle",
    "Minotaur",
    "Spanner",
    "Key",
    "Tulip",
    "The Sakura",
    "The Witch",
    "The Sea",
    "Spicy",
    "Sour",
    "Bullet",
    "Pelt",
    "Yellow Card",
    "Seven",
    "W",
    "Sedap",
    "Spart",
    "Pearl",
    "Claymore",
    "The Stylus",
    "Black Card",
    "Suit",
    "Seal",
    "Gamecube",
    "DSe",
    "Nintendo Switche",
    "Arie",
    "Tauruse",
    "Gemini",
    "Cancer",
    "Super Mushroom",
    "Fire Flower",
    "Cape Feather",
    "Super Star",
    "Cloud",
    "Goomba",
    "Boo",
    "Bowser",
    "Mario",
    "Luigi",
    "Yoshi",
    "Wario",
    "Metrolinxe",
    "GO Transit",
    "TTC",
    "OC Transpo",
    "ASDA",
    "Sainsbury",
    "Tesco",
    "LIDL",
    "Starburst",
    "Crescent",
    "Cup",
    "Coin",
    "Wakka",
    "Cherrie",
    "Ghost",
    "Pellet",
    "Tube",
    "Over",
    "Dockland",
    "Purple",
    "Fortres",
    "Portal",
    "Lambda",
    "Orange Boxe",
}

local deckgroups = {
    [1] = {
        "Sigil",
    },
    [2] = {
        "Currency",
        "Pound",
        "Yen",
        "Euro",
        "Dollar",
    },
    [3] = {
        "Tastes",
        "Sweet",
        "Salty",
        "Spicy",
        "Sour",
    },
    [4] = {
        "Geometry",
        "Square",
        "Circle",
        "Star",
        "Triangle",
    },
    [5] = {
        "Gems",
        "Rubie",
        "Emerald",
        "Sapphire",
        "Pearl",
    },
    [6] = {
        "Letters and Numbers",
        "Eight",
        "L",
        "Seven",
        "W",
    },
    [7] = {
        "Decks",
        "Red Card",
        "Blue Card",
        "Yellow Card",
        "Black Card",
    },
    [8] = {
        "Weird Spades",
        "Spade?",
        "Duo Spade",
        "Sedap",
        "Spart",
    },
    [9] = {
        "Combat",
        "Sword",
        "Shield",
        "Claymore",
        "Bullet",
    },
    [10] = {
        "Inscryption",
        "Blood",
        "Battery",
        "Bone",
        "Pelt",
    },
    [11] = {
        "Negated",
        "Nope",
        "Null",
        "Losse",
        "Interrobang",
    },
    [12] = {
        "Banjo-Kasuitie",
        "Honeycomb",
        "Puzzle",
        "Paw",
        "Treble",
    },
    [13] = {
        "Internet",
        "Chrome",
        "Garfield",
        "Homestuck",
        "Roflmao",
    },
    [14] = {
        "Tools",
        "Cogwheel",
        "Key",
        "Spanner",
        "Car",
    },
    [15] = {
        "Nintendo",
        "Gameboy",
        "Gamecube",
        "DSe",
        "Nintendo Switche"
    },
    [16] = {
        "Jokers",
        "D6",
        "Jimbo",
        "Suit",
        "Seal",
    },
    [17] = {
        "Lowblood",
        "Arie",
        "Tauruse",
        "Gemini",
        "Cancer"
    },
    [18] = {
        "Luigis Casinos",
        "Super Mushroom",
        "Fire Flower",
        "Cape Feather",
        "Super Star",
    },
    [19] = {
        "Bowsers Minions",
        "Cloud",
        "Goomba",
        "Boo",
        "Bowser"
    },
    [20] = {
        "Super Balatro 64",
        "Mario",
        "Luigi",
        "Yoshi",
        "Wario"
    },
    [21] = {
        "Ontario Public Transit",
        "Metrolinxe",
        "GO Transit",
        "TTC",
        "OC Transpo"
    },
    [22] = {
        "Supermarket",
        "ASDA",
        "Sainsbury",
        "Tesco",
        "LIDL"
    },
    [23] = {
        "Suit Expansion",
        "Starburst",
        "Crescent",
        "Cup",
        "Coin"
    },
    [24] = {
        "Pac-Man",
        "Wakka",
        "Cherrie",
        "Ghost",
        "Pellet"
    },
    [25] = {
        "London Transport",
        "Tube",
        "Over",
        "Dockland",
        "Purple"
    },
    [26] = {
        "Valve Games",
        "Fortres",
        "Portal",
        "Lambda",
        "Orange Boxe"
    },
}

for i = 1, #cursuit do
    table.insert(deckgroups[1], cursuit[i])
end

--- Sprites
SMODS.Atlas { key = 'lc_cards', path = '8BitDeck.png', px = 71, py = 95 }
SMODS.Atlas { key = 'lc_ui', path = 'ui_assets.png', px = 18, py = 18 }
SMODS.Atlas { key = 'hc_cards', path = '8BitDeck.png', px = 71, py = 95 }
SMODS.Atlas { key = 'hc_ui', path = 'ui_assets.png', px = 18, py = 18 }
SMODS.Atlas { key = 'Joker', path = 'Jokers.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Consumables', path = 'Consumables.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Decks', path = 'Decks.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Blind', path = 'BlindChips.png', px = 34, py = 34, frames = 21, atlas_table = 'ANIMATION_ATLAS' }
SMODS.Atlas { key = 'modicon', path = 'ModIcon.png', px = 32, py = 32 }

-- Suits
for i = 1, #cursuit do
    local suit_key = cleanSuitName(cursuit[i], "_")
	SMODS.Suit {
        key = suit_key ..'s',
        card_key = 'C'.. suit_key,

        lc_atlas = 'lc_cards',
        lc_ui_atlas = 'lc_ui',

        pos = { y = i-1 },
        ui_pos = { x = i-1, y = 0 },

        lc_colour = HEX(cursuitcolor[i]),

        loc_txt = {
            ['en-us'] = {
                singular = cursuit[i],
                plural = cursuit[i] ..'s',
            }
        },

        in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        for u = 2, #current_deck do
                            if self.key == ("sshs_"..cleanSuitName(current_deck[u], "_").."s") then
                                if args ~= nil then
                                    args.initial_deck = true
                                end
                                return true
                            end
                        end
                        return false
                    end
                end
            end
            if args ~= nil then
                args.initial_deck = false
            end
            return false
        end
    }
end

-- Blinds
for i = 1, #curblindsname do
    local suit_key = cleanSuitName(cursuit[i], "_")
    SMODS.Blind {
        key = cleanSuitName(curblindsname[i], "_"),
        boss = { min = 1, max = 10 },
        boss_colour = HEX(curblindscolor[i]),
        debuff = { suit = 'sshs_'.. suit_key ..'s' },
        atlas = 'Blind',
        pos = { x = 0, y = i-1 },
        no_collection = sigil_config.no_collection,
        loc_txt = {
            ['en-us'] = {
                name = curblindsname[i],
                text = {
                    'All '.. cursuit[i] ..'s cards',
                    'are debuffed',
                }
            }
        },
        in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        for u = 2, #current_deck do
                            if (suit_key ..'s') == (cleanSuitName(current_deck[u], "_").."s") then
                                return true
                            end
                        end
                        return false
                    end
                end
            end
        end
    }
end

-- Decks
for i = 1, #deckgroups do
    local curgroupva = deckgroups[i]
    if i ~= 1 then
        SMODS.Back {
            key = "k".. curgroupva[1],
            loc_txt = {
                ['en-us'] = {
                    name = curgroupva[1] .." Deck",
                    text = {
                        'Start the run with only',
                        '{V:1}'.. curgroupva[2] ..'s{}, {V:2}'.. curgroupva[3] ..'s{}, {V:3}'.. curgroupva[4] ..'s{}, and',
                        '{V:4}'.. curgroupva[5] ..'s{}, suits',
                    }
                }
            },
            atlas = 'Decks',
            pos = { x = i-1, y = 0 },
            config = {},
            loc_vars = function(self, info_queue, card)
                return {
                    vars = { 
                        colours = {
                            G.C.SUITS["sshs_"..cleanSuitName(curgroupva[2], "_").."s"],
                            G.C.SUITS["sshs_"..cleanSuitName(curgroupva[3], "_").."s"],
                            G.C.SUITS["sshs_"..cleanSuitName(curgroupva[4], "_").."s"],
                            G.C.SUITS["sshs_"..cleanSuitName(curgroupva[5], "_").."s"],
                        }, 
                    }
                }
            end,
        }
    else
        SMODS.Back {
            key = "k".. curgroupva[1],
            loc_txt = {
                ['en-us'] = {
                    name = curgroupva[1] .." Deck",
                    text = {
                        'Start the run with {C:attention}all',
                        'the {C:dark_edition}suits',
                    }
                }
            },
            atlas = 'Decks',
            pos = { x = 0, y = 0 },
            config = {},
            loc_vars = function(self, info_queue, card)
                return {
                    vars = { 
                        colours = {
                            G.C.SUITS["sshs_"..curgroupva[2].."s"],
                            G.C.SUITS["sshs_"..curgroupva[3].."s"],
                            G.C.SUITS["sshs_"..curgroupva[4].."s"],
                            G.C.SUITS["sshs_"..curgroupva[5].."s"],
                        }, 
                    }
                }
            end,
        }
    end
end

--Spectral idea:Convert 8 selected cards into 2 of each of [SUIT GROUP] 
-- Consumables
for i = 1, #tarotname do
    SMODS.Consumable {
        set = 'Tarot',
        key = cleanSuitName(tarotname[i], "_"),
        config = { suit_conv = "sshs_"..cleanSuitName(cursuit[i], "_").."s", max_highlighted = 3, colours = {} },
            loc_txt = {
                ['en-us'] = {
                    name = tarotname[i],
                    text = {
                        'Converts up to',
                        '{C:attention}3{} selected cards',
                        'to {V:1}'.. cursuit[i] ..'s{}',
                    }
                }
            },
        atlas = 'Consumables',
        no_collection = sigil_config.no_collection,
        pos = { x = i-1, y = 0 },
        loc_vars = function(self)
            return {
                vars = {
                    self.config.max_highlighted,
                    localize(self.config.suit_conv, 'suits_plural'),
                    colours = {G.C.SUITS["sshs_"..cleanSuitName(cursuit[i], "_").."s"] },
                },
            }
        end,
        in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        for u = 2, #current_deck do
                            if self.config.suit_conv == ("sshs_"..cleanSuitName(current_deck[u], "_").."s") then
                                return true
                            end
                        end
                        return false
                    end
                end
            end
        end
    }
end

-- Jokers
for i = 1, #sinjokename do
    SMODS.Joker {
        key = cleanSuitName(sinjokename[i], "_"),
        config = {
            extra = {
                mult = 3,
                suit = cleanSuitName(cursuit[i], "_") ..'s'
            }
        },
        atlas = 'Joker',
        pos = { x = i-1, y = 0 },
        no_collection = sigil_config.no_collection,
        loc_txt = {
            ['en-us'] = {
                name = sinjokename[i],
                text = {
                    'Played cards with',
                    '{V:1}'..cursuit[i] ..'s{} suit give',
                    '{C:mult}+#1#{} Mult when scored'
                }
            }
        },
        cost = 5,
        loc_vars = function(self, info_queue, card)
            return {
                vars = { card.ability.extra.mult, localize(card.ability.extra.suit, 'suits_singular'), colours = {G.C.SUITS["sshs_"..cursuit[i].."s"] }, }
            }
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and context.other_card:is_suit('sshs_'..cleanSuitName(cursuit[i], "_").."s") then
                return {
                    mult = card.ability.extra.mult,
                    card = card,
                }
            end
        end,
        in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        for u = 2, #current_deck do
                            if self.config.extra.suit == (cleanSuitName(current_deck[u], "_").."s") then
                                return true
                            end
                        end
                        return false
                    end
                end
            end
        end
    }
end
SMODS.Joker {
    key = 'basalt',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 10, y = 1 },
    loc_txt = {
        ['en-us'] = {
            name = 'Basalt',
            text = {
                "If played hand contains at least one", 
                "scoring card with Null suit, convert",
                "all cards in played hand to Null suit",
            }
        }
    },
    rarity = 2,
    cost = 6,
    no_collection = sigil_config.no_collection,
    loc_vars = function(self, info_queue, card)
        return {}
    end,
    calculate = function(self, card, context)
        local basaltbeta = 0
        if context.cardarea == G.play and not context.repetition and context.individual then
            if not context.other_card:is_suit('Nulls') then
                for k, v in ipairs(context.full_hand) do 
                    if v:get_suit() == 'Nulls' then 
                        basaltbeta = 1
                    end
                end
                if basaltbeta == 1 then
                    for k, v in ipairs(context.full_hand) do 
                        v:flip()
                        v:remove_from_deck()
                        v:change_suit('Nulls')
                        v:flip()
                    end 
                    return {
                        message = localize {
                            type = 'variable',
                            key = 'suit_changed',
                            vars = { new_suit }
                        },
                        card = context.other_card
                    }
                end
            end
        end
    end,
    in_pool = function(self, args)
        if sigil_config.chaos then
            return true
        end
        local in_deck = false
        local current_deck = nil
        for k = 1, #deckgroups do
            local current_deck = deckgroups[k]
            if G.GAME.selected_back ~= nil then
                if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                    for u = 2, #current_deck do
                        if self.config.extra.suit == ('Nulls') then
                            return true
                        end
                    end
                    return false
                end
            end
        end
    end
}
SMODS.Joker {
    key = 'fluorite',
    config = {
        extra = {odds = 4},
    },
    atlas = 'Joker',
    pos = { x = 19, y = 1 },
    loc_txt = {
        ['en-us'] = {
            name = 'Fluorite',
            text = {
                "{C:green}#1# in #2#{} chance for each played card with", 
                "Eight suit to turn into an 8 (rank)",
            }
        }
    },
    rarity = 2,
    cost = 6,
    no_collection = sigil_config.no_collection,
    loc_vars = function(self, info_queue, card)
        return { vars = { '' .. (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and not context.repetition and context.individual then 
            for k, v in ipairs(context.full_hand) do 
                local card = v
                local suit = string.sub(card.base.suit, 1, 1)
                local rank = card.base.id == 14 and 2 or math.min(8, 14)
                if rank < 10 then rank = tostring(rank)
                elseif rank == 10 then rank = 'T'
                elseif rank == 11 then rank = 'J'
                elseif rank == 12 then rank = 'Q'
                elseif rank == 13 then rank = 'K'
                elseif rank == 14 then rank = 'A'
                end
                if context.other_card:is_suit('Eights') then
                    if pseudorandom('lucky_money') < G.GAME.probabilities.normal / self.ability.extra.odds then
                        v:flip()
                        v:remove_from_deck()
                        v:set_base(G.P_CARDS[suit .. '_' .. rank])
                        v:change_suit('Eights')
                        v:flip()
                    end
                end
            end
            return {
                card = context.other_card
            }
        end
    end,
    in_pool = function(self, args)
        if sigil_config.chaos then
            return true
        end
        local in_deck = false
        local current_deck = nil
        for k = 1, #deckgroups do
            local current_deck = deckgroups[k]
            if G.GAME.selected_back ~= nil then
                if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                    for u = 2, #current_deck do
                        if self.config.extra.suit == ('Eights') then
                            return true
                        end
                    end
                    return false
                end
            end
        end
    end
}

-- Pool deck fixing
SMODS.Suit:take_ownership('Spades', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Suit:take_ownership('Diamonds', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Suit:take_ownership('Hearts', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Suit:take_ownership('Clubs', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Consumable:take_ownership('c_moon', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Consumable:take_ownership('c_sun', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Consumable:take_ownership('c_world', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Consumable:take_ownership('c_star', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Joker:take_ownership('j_greedy_joker', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Joker:take_ownership('j_lusty_joker', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Joker:take_ownership('j_wrathful_joker', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Joker:take_ownership('j_gluttenous_joker', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Joker:take_ownership('j_rough_gem', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Joker:take_ownership('j_bloodstone', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Joker:take_ownership('j_arrowhead', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Joker:take_ownership('j_onyx_agate', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Blind:take_ownership('bl_goad', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Blind:take_ownership('bl_head', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Blind:take_ownership('bl_club', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)
SMODS.Blind:take_ownership('bl_window', 
    { 
	    in_pool = function(self, args)
            if sigil_config.chaos then
                return true
            end
            local in_deck = false
            local current_deck = nil
            for k = 1, #deckgroups do
                local current_deck = deckgroups[k]
                if G.GAME.selected_back ~= nil then
                    if G.GAME.selected_back.name == ("b_sshs_k"..current_deck[1]) then
                        if k ~= 1 then
                            return false
                        else
                            return true
                        end
                    end
                end
            end
            return true
        end
    },
    true 
)

local text_scale = 0.9
SMODS.current_mod.config_tab = function()
  return {
    n = G.UIT.ROOT,
    config = {
      align = "tm",
      padding = 0.2,
      minw = 8,
      minh = 2,
      colour = G.C.BLACK,
      r = 0.1,
      hover = true,
      shadow = true,
      emboss = 0.05
    },
    nodes = {
      {
        n = G.UIT.R,
        config = { padding = 0, align = "cm", minh = 0.1 },
        nodes = {
          {
            n = G.UIT.C,
            config = { align = "c", padding = 0, minh = 0.1 },
            nodes = {
              {
                n = G.UIT.R,
                config = { padding = 0, align = "cm", minh = 0 },
                nodes = {
                  { n = G.UIT.T, config = { text = "All suits on all decks?", scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
                }
              },
            }
          },
          {
            n = G.UIT.C,
            config = { align = "cl", padding = 0.05 },
            nodes = {
              create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = sigil_config, ref_value = "chaos" },
            }
          },
        }
      },
      {
        n = G.UIT.R,
        config = { padding = 0, align = "cm", minh = 0.1 },
        nodes = {
          {
            n = G.UIT.C,
            config = { align = "c", padding = 0, minh = 0.1 },
            nodes = {
              {
                n = G.UIT.R,
                config = { padding = 0, align = "cm", minh = 0 },
                nodes = {
                  { n = G.UIT.T, config = { text = "Hide in collection?", scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
                }
              },
            }
          },
          {
            n = G.UIT.C,
            config = { align = "cl", padding = 0.05 },
            nodes = {
              create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = sigil_config, ref_value = "no_collection" },
            }
          },
        }
      },

    }
  }
end

local artists_credits = {
    "notmario",
    "zy-b-org",
    "NewtTheFish",
    "ilikecheese",
    "lyman",
    "timetoexplode",
    "MathIsFun_",
    "Luna!",
    "Pinkers",
    "CrimsonHeart",
    "Nozomi Tojo",
    "Aure",
    "Flare",
    "balatrostuck gaming",
    "Soundwave",
    "RattlingSnow353",
    "rock man",
    "5381",
    "Coro",
    "Twilight",
    "l_kao",
    "Flowr",
    "B",
    "Hat Stack",
    "chorus",
    "editmouse",
    "Papyrus Semi",
    "wilfredlam0418",
    "Luigicat11"
}
local coder_credits = {
    "RattlingSnow353",
}

local header_scale = 1.1
local bonus_padding = 1.15
local support_padding = 0.015
local artist_size = 0.43

SMODS.current_mod.credits_tab = function()
	chosen = true
	return {n=G.UIT.ROOT, config={align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.1, emboss = 0.05, minh = 6, minw = 10}, nodes={
		{n = G.UIT.C, config = { align = "tm", padding = 0.2 }, nodes = {
			{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
				{n=G.UIT.T, config={text = localize("b_credits"), scale = text_scale*1.2, colour = G.C.GREEN, shadow = true}},
			}},
			{n=G.UIT.R, config={align = "cm", padding = 0.05,outline_colour = G.C.GREEN, r = 0.1, outline = 1}, nodes= {
				{n=G.UIT.C, config={align = "tm", padding = 0.1, r = 0.1}, nodes= {
					{ n = G.UIT.C, config = { align = "tm", padding = 0.1 * bonus_padding, outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1 }, nodes = {
						{ n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
							{ n = G.UIT.T, config = { text = "Artists", scale = header_scale * 0.6, colour = HEX('f75294'), shadow = true } },
						} },
						{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
							{n=G.UIT.C, config={align = "tl", padding = 0}, nodes={
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[1], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[2], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[3], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[4], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[5], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[6], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[7], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[8], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[9], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[10], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[11], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[12], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[13], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
                                { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[14], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} }
							}},
							{n=G.UIT.C, config={align = "tl", padding = 0}, nodes={
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[15], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[16], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[17], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[18], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[19], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[20], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[21], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
                                { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[22], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
                                { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[23], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
                                { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[24], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[25], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
                                { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[26], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
                                { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[27], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
                                { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[28], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} },
                                { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = artists_credits[29], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} }
							}}
						}},
					} },
				}},
				{n=G.UIT.C, config={align = "tm", padding = 0.1, r = 0.1}, nodes= {
					{ n = G.UIT.C, config = { align = "tm", padding = 0.1 * bonus_padding, outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1 }, nodes = {
						{ n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
							{ n = G.UIT.T, config = { text = "Coders", scale = header_scale * 0.6, colour = G.C.ORANGE, shadow = true } },
						} },
						{n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
							{n=G.UIT.C, config={align = "tl", padding = 0}, nodes={
								{ n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = {
									{ n = G.UIT.T, config = { text = coder_credits[1], scale = text_scale * artist_size, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
								} }
							}}
						}},
					} },
				}},
			}}
		}}
	}}
end

----------------------------------------------
------------MOD CODE END---------------------