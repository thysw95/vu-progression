-- Converts list of tables into "val1,val2,val1,val2,..."
function tableListToCSV(tblList, key1, key2)
    local parts = {}
    for _, subtable in ipairs(tblList) do
        table.insert(parts, tostring(subtable[key1]))
        table.insert(parts, tostring(subtable[key2]))
    end
    return table.concat(parts, ",")
end

-- Converts "val1,val2,val1,val2,..." back into list of tables
-- key1 and key2 define the keys to use in each subtable
function csvToTableList(str, key1, key2)
    local tblList = {}
    local parts = {}
    for part in string.gmatch(str, "([^,]+)") do
        table.insert(parts, part)
    end

    for i = 1, #parts, 2 do
        local subtable = {}
        subtable[key1] = tonumber(parts[i]) or parts[i]
        subtable[key2] = tonumber(parts[i + 1]) or parts[i + 1]
        table.insert(tblList, subtable)
    end

    return tblList
end