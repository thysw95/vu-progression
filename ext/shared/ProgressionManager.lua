local ProgressionManager = class('ProgressionManager')

-- Function to sort kit unlock groups
function ProgressionManager:sortKitProgressionTable(progressTable)
    table.sort(progressTable, function(a, b)
        return a.xpRequired < b.xpRequired
    end)
end

-- Function to sort vehicle type unlocks
function ProgressionManager:sortVehicleProgressionTable(progressTable)
    for _, vicType in pairs(progressTable) do
        table.sort(vicType.unlocks, function(a, b)
            return a.vicScoreRequired < b.vicScoreRequired
        end)
    end
end

return ProgressionManager