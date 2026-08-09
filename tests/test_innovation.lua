local Innovation = require("neat.innovation")

local tracker = Innovation.new()

local innovationA =
    Innovation.getConnectionInnovation(tracker, 1, 4)

local innovationB =
    Innovation.getConnectionInnovation(tracker, 2, 4)

local innovationC =
    Innovation.getConnectionInnovation(tracker, 1, 4)

print("Innovation 1 -> 4 :", innovationA)
print("Innovation 2 -> 4 :", innovationB)
print("Innovation 1 -> 4 demandée une deuxième fois :", innovationC)

assert(innovationA == 1)
assert(innovationB == 2)

-- la même connexion doit récupérer la même innovation.
assert(innovationC == innovationA)

-- Comme seulement deux innovations différentes ont été créées,
-- la prochaine disponible doit être 3.
assert(tracker.nextInnovation == 3)

print()
print("Test des innovations réussi !")