local Innovation = {}

-- Crée un nouveau tracker d'innovations. 
function Innovation.new()
    return {
        nextInnovation = 1,
        connectionInnovations = {}
    }
end

-- Construit une clé unique représentant une connexion. 
local  function connectionKey(inputNodeId, outputNodeId)
    return inputNodeId .. "->" .. outputNodeId
end

-- Retourne le numéro d'innovation d'une connexion.
-- Si la connexion n'existe pas encore, elle est ajoutée au tracker avec un nouveau numéro d'innovation.

function Innovation.getConnectionInnovation(tracker, inputNodeId, outputNodeId)
    local  key = connectionKey(inputNodeId, outputNodeId)
    local existingInnovation = tracker.connectionInnovations[key]
    if existingInnovation ~= nil then
        return existingInnovation
    end
    local newInnovation = tracker.nextInnovation
    tracker.connectionInnovations[key] = newInnovation
    tracker.nextInnovation = tracker.nextInnovation + 1
    return newInnovation
end

return Innovation