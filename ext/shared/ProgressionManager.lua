local ProgressionManager = class('ProgressionManager')

-- Function to sort kits
function ProgressionManager:sortKitProgressionTable(progressTable)
    local sortedTable = progressTable

    if #progressTable > 0 then
        table.sort(sortedTable, function(a, b)
            return a.xpRequired < b.xpRequired
        end)
    end

    return sortedTable
end

return ProgressionManager