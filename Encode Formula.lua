local key = 69
local function encode(...)
    local args = {...}
    local encoded = ""
    for i, arg in ipairs(args) do
        local str = tostring(arg)
        for j = 1, #str do
            local char = str:sub(j, j)
            local byteValue = char:byte() ~ key
            if tonumber(char) then
                encoded = encoded .. "_num[" .. i .. "][" .. j .. "]=" .. byteValue
            else
                if char == "_" then
                    encoded = encoded .. "_shad[" .. i .. "][" .. j .. "]=" .. byteValue
                else
                    encoded = encoded .. "_char[" .. i .. "][" .. j .. "]=" .. byteValue
                end
            end
            encoded = encoded .. char .. char
        end
    end
    return encoded
end

local function decode(encoded)
    local decoded = ""
    for charType, i, j, byteValue in encoded:gmatch("(_[a-z]+)%[(%d+)%]%[(%d+)%]=(%d+)") do
        local originalByteValue = tonumber(byteValue) ~ key
        if charType == "_num" then
            decoded = decoded .. tostring(originalByteValue)
        elseif charType == "_shad" then
            decoded = decoded .. "_"
        else
            decoded = decoded .. string.char(originalByteValue)
        end
    end
    return decoded
end


print(decode(encode("Hello")))