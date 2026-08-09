local Genome = {}

function Genome.new()
    return {
        nodes = {},
        connections = {}
    }
end

function Genome.addNode(genome, id, nodeType)
    local node = {
        id =id,
        type = nodeType
    }
    genome.nodes[id] = node
end

function Genome.addConnection(genome, inputNodeId, outputNodeId, weight)
    local connection = {
        inputNodeId = inputNodeId,
        outputNodeId = outputNodeId,
        weight = weight,
        enabled = true
    }
    table.insert(genome.connections, connection)
end

-- Modifie le poids de chaque connexion active du génome. 
-- forcedVariation sert uniquement à rendre les tests prévisibles : Genome.mutateWeights(genome, 0.2) ajoute exactement 0.2 à chaque poids

-- Sans forcedVariation : Genome.mutateWeights(genome) choisit une variation  aléatoire différente pour chaque connexion.

function Genome.mutateWeights(genome, forcedVariation)
    for _, connection in ipairs(genome.connections) do
        if connection.enabled then

            -- Mode utilisé pour les tests : on force une variation de poids spécifique
            if forcedVariation ~= nil then 
                connection.weight = connection.weight + forcedVariation
            -- Mode réel : on choisit une variation aléatoire différente pour chaque connexion
            else
                local chance = math.random()
                -- 90% du temps on fais une petite variation de poids, 10% du temps on réinitialise le poids à une valeur aléatoire
                if chance < 0.9 then
                    local variation = math.random() * 0.4 - 0.2
                    connection.weight = connection.weight + variation
                else
                    connection.weight = math.random() * 10 - 6
                end
            end
            if connection.weight > 5 then
                connection.weight = 5
            elseif connection.weight < -5 then
                connection.weight = -5
            end
        end
    end
end

return Genome