local Network = {}

-- Transforme un nombre quelconque en une valeur comprise entre 0 et 1 
local function sigmoid(x)
    return 1 / (1 + math.exp(-4.9 * x))
end

-- Additionne toutes les connexions qui arrivent vers un neurone 
local function calculateIncomingSum(genome, destinationNodeId, values)
    local total = 0

    for _, connection in ipairs(genome.connections) do
        local goesToDestination = connection.outputNodeId == destinationNodeId

        if connection.enabled and goesToDestination then
            local sourceValue = values[connection.inputNodeId]
            assert(sourceValue ~= nil, "Valeur manquante pour le neurone source" .. connection.inputNodeId)
            local contribution = sourceValue * connection.weight
            total = total + contribution
        end
    end

    return total
end

function Network.evaluate(genome, inputValues)
    local values ={}
    local rawSums = {}

    -- Première étape : donnes leurs valeurs aux neurones d'entrée et de biais
    for nodeId, node in pairs(genome.nodes) do

        if node.type == "input" then
            assert(inputValues[nodeId] ~= nil, "Valeur manquante pour le neurone d'entrée " .. nodeId)
            values[nodeId] = inputValues[nodeId]
        elseif node.type == "bias" then
            values[nodeId] = 1
        else
            values[nodeId] = 0
        end
    end

    -- Deuxième étape : calculer les valeurs des neurones cachés
    for nodeId, node in pairs(genome.nodes) do

        if node.type == "hidden" then
            local sum = calculateIncomingSum(genome, nodeId, values)
            rawSums[nodeId] = sum
            values[nodeId] = sigmoid(sum)
        end
    end

    -- Troisième étape : calculer les valeurs des neurones de sortie
    local outputs = {}
    for nodeId, node in pairs(genome.nodes) do

        if node.type == "output" then
            local sum = calculateIncomingSum(genome, nodeId, values)
            rawSums[nodeId] = sum
            values[nodeId] = sigmoid(sum)
            outputs[nodeId] = values[nodeId]
        end
    end

    return outputs, {
        values = values,
        rawSums = rawSums
    }
end

return Network
