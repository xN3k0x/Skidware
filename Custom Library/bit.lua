--[[
Built-in function that use:
    tonumber
    tostring
    pcall
    pairs

That's why it so fcking hard to detect 😎
]]

local bit = {}
local math = {}
local custom = {}

function custom:concat(tbl, sep, start_index, end_index)
    sep = sep or ""
    start_index = start_index or 1
    end_index = end_index or #tbl
    local result = ""
    for i = start_index, end_index do
        result = result .. tbl[i]
        if i ~= end_index then
            result = result .. sep
        end
    end
    return result
end

function custom:b2n(s)
    local result = 0
    local exponent = 0
    for i = #s, 1, -1 do
        local c = s:sub(i,i)
        if c == '0' then
            result = result + 0
        elseif c == '1' then
            result = result + 2^exponent
        else
            return nil
        end
        exponent = exponent + 1
    end
    return result
end

function custom:type(value)
    if value == nil then
        return "nil"
    elseif pcall(function() for i,v in pairs(value) do end end) then
        return "table"
    elseif pcall(value) and true or false then
        return "function"
    elseif value == true or value == false then
        return "boolean"
    elseif tonumber(value) ~= nil then
        return "number"
    elseif tostring(value) ~= nil then
        return "string"
    else
        return "userdata"
    end
end

function math:floor(x)
    local integerPart = x - x % 1
    if x < 0 and x ~= integerPart then
        integerPart = integerPart - 1
    end
    return integerPart
end

function math:fmod(x, y)
    return x - math:floor(x/y) * y
end

function math:max(...)
    local arg = {...}
    local maxVal = arg[1]
    for i = 2, #arg do
        if arg[i] > maxVal then
            maxVal = arg[i]
        end
    end
    return maxVal
end

function bit:tobit(n)
    if custom:type(n) ~= "number" then return "number only" end
    local t = {}
    while n > 0 do
        rest = math:fmod(n,2)
        t[#t+1] = rest
        n = (n-rest)/2
    end
    return t
end

function bit:bnot(i)
    if custom:type(i) ~= "number" then return "number only" end
    return -(i+1)
end


function bit:band(i1,i2)
    if custom:type(i1) ~= "number" or custom:type(i2) ~= "number" then return "number only" end

    local b1 = self:tobit(i1)
    local b2 = self:tobit(i2)
    local t = {}
    for i = math:max(#b1,#b2),1,-1 do
        if b1[i] == nil then b1[i] = 0 end
        if b2[i] == nil then b2[i] = 0 end
        if b1[i] == 1 and b2[i] == 1 then
            t[#t+1] = 1
        else
            t[#t+1] = 0
        end
    end
    return custom:b2n(custom:concat(t))
end

function bit:bor(i1,i2)
    if custom:type(i1) ~= "number" or custom:type(i2) ~= "number" then return "number only" end

    local b1 = self:tobit(i1)
    local b2 = self:tobit(i2)
    local t = {}
    for i = math:max(#b1,#b2),1,-1 do
        if b1[i] == nil then b1[i] = 0 end
        if b2[i] == nil then b2[i] = 0 end
        if b1[i] == 1 or b2[i] == 1 then
            t[#t+1] = 1
        else
            t[#t+1] = 0
        end
    end
    return custom:b2n(custom:concat(t))
end

function bit:bxor(i1,i2)
    if custom:type(i1) ~= "number" or custom:type(i2) ~= "number" then return "number only" end

    local b1 = self:tobit(i1)
    local b2 = self:tobit(i2)
    local t = {}
    for i = math:max(#b1,#b2),1,-1 do
        if b1[i] == nil then b1[i] = 0 end
        if b2[i] == nil then b2[i] = 0 end
        if b1[i] ~= b2[i] then
            t[#t+1] = 1
        else
            t[#t+1] = 0
        end
    end
    return custom:b2n(custom:concat(t))
end

function bit:lshift(i1,i2)
    if custom:type(i1) ~= "number" or custom:type(i2) ~= "number" then return "number only" end
    return i1 * 2 ^ i2
end

function bit:rshift(i1,i2)
    if custom:type(i1) ~= "number" or custom:type(i2) ~= "number" then return "number only" end
    return math:floor(i1 / 2 ^ i2)
end

return bit
