local Genome = require("neat.genome")
local Network = require("neat.network")

local genome = Genome.new()

-- Neurones d'entrée
Genome.addNode(genome, 1, "input") -- obstacle
Genome.addNode(genome, 2, "input") -- ennemi

-- Neurone de biais
Genome.addNode(genome, 3, "bias")

-- Neurone caché
Genome.addNode(genome, 4, "hidden")

-- Neurone de sortie
Genome.addNode(genome, 5, "output") -- saut

-- Connexions vers le neurone caché 
Genome.addConnection(genome, 1, 4, 1.0)
Genome.addConnection(genome, 2, 4, -1.0)
Genome.addConnection(genome, 3, 4, -0.5)

-- Connexion vers le neurone de sortie
Genome.addConnection(genome, 4, 5, 1.5)
Genome.addConnection(genome, 3, 5, -0.25)

print("Nombre de neurones :", #genome.nodes)
print("Nombre de connexions :", #genome.connections)

-- Situation donnée au réseau : obstacle présent et ennemi assez éloigné
local inputs = {
    [1] = 1.0, -- obstacle
    [2] = 0.25  -- ennemi
}

local outputs, details = Network.evaluate(genome, inputs)

print()
print("Somme brute du neurone caché :")
print(details.rawSums[4])

print("Valeur activée du neurone caché :")
print(details.values[4])

print()
print("Somme brute du neurone de sortie saut :")
print(details.rawSums[5])

print("Valeur activée du neurone de sortie saut :")
print(outputs[5])