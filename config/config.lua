Config = {}

Config.progressPerCatch = 0.05 -- The progress per one fish caught

---@class Fish
---@field price integer | { min: integer, max: integer }
---@field chance integer Percentage chance
---@field skillcheck SkillCheckDifficulity }

---@type table<string, Fish>
Config.fish = {
    ['goldfish'] = { price = { min = 10, max = 15 }, chance = 35, skillcheck = { 'easy', 'easy', 'easy' } },
    ['codfish'] = { price = { min = 35, max = 50 }, chance = 35, skillcheck = { 'easy', 'easy', 'easy' } },
    ['catfish'] = { price = { min = 20, max = 35 }, chance = 20, skillcheck = { 'easy', 'easy', 'easy' } },
    ['bluefish'] = { price = { min = 35, max = 50 }, chance = 10, skillcheck = { 'easy', 'easy', 'easy' } },
    ['tuna'] = { price = { min = 10, max = 15 }, chance = 25, skillcheck = { 'easy', 'easy', 'easy' } },
    ['redfish'] = { price = { min = 35, max = 50 }, chance = 25, skillcheck = { 'easy', 'easy', 'easy' } },
    ['trout'] = { price = { min = 20, max = 35 }, chance = 20, skillcheck = { 'easy', 'easy', 'easy' } },
    ['largemouth_bass'] = { price = { min = 20, max = 35 }, chance = 20, skillcheck = { 'easy', 'easy', 'easy' } },
    ['peacock_bass'] = { price = { min = 50, max = 75 }, chance = 5, skillcheck = { 'easy', 'easy', 'easy' } },
    ['mackerel'] = { price = { min = 120, max = 150 }, chance = 1, skillcheck = { 'easy', 'easy', 'easy' } },
    ['sole'] = { price = { min = 120, max = 150 }, chance = 1, skillcheck = { 'easy', 'easy', 'easy' } },
}

---@class FishingRod
---@field name string
---@field price integer
---@field minLevel integer The minimal level
---@field breakChance integer Percentage chance

---@type FishingRod[]
Config.fishingRods = {
    { name = 'fishing_rod', price = 350, minLevel = 1, breakChance = 10 },
    --{ name = 'basic_rod', price = 200, minLevel = 1, breakChance = 20 },
    --{ name = 'graphite_rod', price = 500, minLevel = 2, breakChance = 10 },
    --{ name = 'titanium_rod', price = 1000, minLevel = 3, breakChance = 1 },
}

---@class FishingBait
---@field name string
---@field price integer
---@field minLevel integer The minimal level
---@field waitDivisor number The total wait time gets divided by this value

---@type FishingBait[]
Config.baits = {
    { name = 'worms', price = 5, minLevel = 1, waitDivisor = 1.0 },
    { name = 'artificial_bait', price = 25, minLevel = 2, waitDivisor = 3.0 },
}

---@class FishingZone
---@field locations vector3[] One of these gets picked at random
---@field radius number
---@field minLevel integer
---@field waitTime { min: integer, max: integer }
---@field includeOutside boolean Whether you can also catch fish from Config.outside
---@field blip BlipData?
---@field message { enter: string, exit: string }?
---@field fishList string[]

---@type FishingZone[]
Config.fishingZones = {
    {
        blip = {
            name = 'Eaux profondes',
            sprite = 317,
            color = 29,
            scale = 0.6
        },
        locations = {
            vector3(-4941.7964, -2411.9146, 0.0),
        },
        radius = 1000.0,
        minLevel = 3,
        waitTime = { min = 20, max = 40 },
        includeOutside = false,
        message = { enter = 'Vous êtes dans les eaux profondes.', exit = 'Vous avez quitté les eaux profondes.' },
        fishList = { 'codfish', 'redfish', 'sole' }
    },
    {
        blip = {
            name = 'Marécage',
            sprite = 317,
            color = 56,
            scale = 0.6
        },
        locations = {
            vector3(-2188.1182, 2596.9348, 0.0),
        },
        radius = 200.0,
        minLevel = 2,
        waitTime = { min = 10, max = 20 },
        includeOutside = true,
        message = { enter = 'Vous êtes entré dans un marais.', exit = 'Vous avez quitté le marais.' },
        fishList = { 'goldfish', 'catfish', 'mackerel' }
    },
}

-- Outside of all zones
Config.outside = {
    waitTime = { min = 10, max = 25 },

    ---@type string[]
    fishList = {
        'bluefish',
        'tuna',
        'trout',
        'largemouth_bass',
        'sole',
    }
}

Config.ped = {
    model = `s_m_m_cntrybar_01`,
    buyAccount = 'choose', -- 'money', 'bank' or 'choose'
    sellAccount = 'bank',
    blip = {
        name = 'Pêche',
        sprite = 356,
        color = 74,
        scale = 0.75
    },

    ---@type vector4[]
    locations = {
        vec4(-1593.47, 5196.77, 4.36, 20.94),
        vec4(-815.54, -1346.63, 5.15, 53.61)
    }
}

Config.renting = {
    model = `s_m_m_dockwork_01`, -- The ped model
    account = 'bank',
    boats = {
        { model = `speeder`, price = 500, image = 'https://i.postimg.cc/mDSqWj4P/164px-Speeder.webp' },
        { model = `dinghy`, price = 750, image = 'https://i.postimg.cc/ZKzjZgj0/164px-Dinghy2.webp'  },
        { model = `tug`, price = 1250, image = 'https://i.postimg.cc/jq7vpKHG/164px-Tug.webp' }
    },
    blip = {
        name = 'Location de bateau',
        sprite = 410,
        color = 74,
        scale = 0.7
    },
    returnDivider = 5, -- Players can return it and get some cash back
    returnRadius = 10.0, -- The save radius

    ---@type { coords: vector4, spawn: vector4 }[]
    locations = {
        { coords = vec4(-711.6, -1299.38, 5.4, 56.23), spawn = vec4(-719.83, -1318.69, 0.12, 229.79) },
        { coords = vec4(-1604.57, 5257.07, 2.07, 296.29), spawn = vec4(-1601.16, 5260.1, 0.12, 206.87) }
    }
}