local Genome = require("neat.genome")

local genome = Genome.new()

-- Noeuds d'entrée
Genome.addNode(genome, 1, "input") -- obstacle
Genome.addNode(genome, 2, "input") -- trou

-- Noeud de biais
Genome.addNode(genome, 3, "bias")

-- Noeud de sortie 
Genome.addNode(genome, 4, "output") -- saut

-- Connexions correspondantes 
Genome.addConnection(genome, 1, 4, 0.3)
Genome.addConnection(genome, 2, 4, 1.2)
Genome.addConnection(genome, 3, 4, -0.5)

print ("Poids avant mutation :")
for index, connection in ipairs(genome.connections) do
    print(index, connection.weight)
end

-- On force une variation de +0.2 pour obtenir un résultat prévisible
Genome.mutateWeights(genome, 0.2)
print()
print ("Poids après mutation :")
for index, connection in ipairs(genome.connections) do
    print(index, connection.weight)
end

-- Vérification automatique des résultats
assert(math.abs(genome.connections[1].weight - 0.5) < 0.000001)
assert(math.abs(genome.connections[2].weight - 1.4) < 0.000001)
assert(math.abs(genome.connections[3].weight - (-0.3)) < 0.000001)

print()
print("Test de mutation réussi !")

print()
print("Mutation aléatoire :")

Genome.mutateWeights(genome)

for index, connection in ipairs(genome.connections) do
    print(index, connection.weight)
end