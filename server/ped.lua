---@param source integer
---@param fishName string
---@param amount integer
lib.callback.register('ls_fishing:sellFish', function(source, fishName, amount)
    local item = Config.fish[fishName]
    if not item or amount <= 0 then return false end

    local price = type(item.price) == 'number' and item.price or math.random(item.price.min, item.price.max)
    ---@cast price number

    local player = Framework.getPlayerFromId(source)
    if not player then return false end

    if player:getItemCount(fishName) >= amount then
        SetTimeout(3000, function()
            if player:getItemCount(fishName) < amount then return end

            player:removeItem(fishName, amount)
            player:addAccountMoney(Config.ped.sellAccount, price * amount)
        end)

        return true
    end

    return false
end)

---@param source integer
---@param data table
---@param amount integer
---@param method string
lib.callback.register('ls_fishing:buy', function(source, data, amount, method)
    if not data or not amount or amount <= 0 then return false end

    local itemType = data.type
    local index = data.index

    if itemType ~= 'fishingRods' and itemType ~= 'baits' then return false end

    local item = Config[itemType] and Config[itemType][index]
    if not item then return false end

    local price = item.price * amount
    local player = Framework.getPlayerFromId(source)


    --if not player or GetPlayerLevel(player) < item.minLevel then return false end

    if Config.ped.buyAccount == 'bank' or Config.ped.buyAccount == 'money' then
        if player:getAccountMoney(Config.ped.buyAccount) >= price then
            SetTimeout(3000, function()
                if player:getAccountMoney(Config.ped.buyAccount) < price then return end

                player:removeAccountMoney(Config.ped.buyAccount, price)
                player:addItem(item.name, amount)
            end)

            return true
        end
    else
        if method ~= 'money' and method ~= 'bank' then return false end

        if player:getAccountMoney(method) >= price then
            SetTimeout(3000, function()
                if player:getAccountMoney(method) < price then return end
                print('method', method, price)

                player:removeAccountMoney(method, price)
                player:addItem(item.name, amount)
            end)

            return true
        end
    end

    return false
end)