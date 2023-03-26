local bit = {}

function bit:tobit(n)
    if type(n) ~= "number" then return "number only" end
    local t = {}
    while n > 0 do
        rest = math.fmod(n,2)
        t[#t+1] = rest
        n = (n-rest)/2
    end
    return t
end

function bit:bnot(i)
    if type(i) ~= "number" then return "number only" end
    return -(i+1)
end


function bit:band(i1,i2)
    if type(i1) ~= "number" or type(i2) ~= "number" then return "number only" end

    local b1 = self:tobit(i1)
    local b2 = self:tobit(i2)
    local t = {}
    for i = math.max(#b1,#b2),1,-1 do
        if b1[i] == nil then b1[i] = 0 end
        if b2[i] == nil then b2[i] = 0 end
        if b1[i] == 1 and b2[i] == 1 then
            t[#t+1] = 1
        else
            t[#t+1] = 0
        end
    end
    return tonumber(table.concat(t),2)
end

function bit:bor(i1,i2)
    if type(i1) ~= "number" or type(i2) ~= "number" then return "number only" end

    local b1 = self:tobit(i1)
    local b2 = self:tobit(i2)
    local t = {}
    for i = math.max(#b1,#b2),1,-1 do
        if b1[i] == nil then b1[i] = 0 end
        if b2[i] == nil then b2[i] = 0 end
        if b1[i] == 1 or b2[i] == 1 then
            t[#t+1] = 1
        else
            t[#t+1] = 0
        end
    end
    return tonumber(table.concat(t),2)
end

function bit:bxor(i1,i2)
    if type(i1) ~= "number" or type(i2) ~= "number" then return "number only" end

    local b1 = self:tobit(i1)
    local b2 = self:tobit(i2)
    local t = {}
    for i = math.max(#b1,#b2),1,-1 do
        if b1[i] == nil then b1[i] = 0 end
        if b2[i] == nil then b2[i] = 0 end
        if b1[i] ~= b2[i] then
            t[#t+1] = 1
        else
            t[#t+1] = 0
        end
    end
    return tonumber(table.concat(t),2)
end

function bit:lshift(i1,i2)
    if type(i1) ~= "number" or type(i2) ~= "number" then return "number only" end
    return i1 * 2 ^ i2
end

function bit:rshift(i1,i2)
    if type(i1) ~= "number" or type(i2) ~= "number" then return "number only" end
    return math.floor(i1 / 2 ^ i2)
end

return bit
