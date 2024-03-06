#https://stackoverflow.com/questions/43153333/python-relations-with-sets-of-tuples

import random

# Function to generate a random relation with exactly 4 elements
def generate_random_relation():
    elements = [1, 2, 3, 4]
    relation = set()
    while len(relation) < 4:
        pair = (random.choice(elements), random.choice(elements))
        relation.add(pair)
    return relation

# Function to generate a random reflexive relation with exactly 4 elements
def generate_random_reflexive_relation():
    elements = [1, 2, 3, 4]
    relation = set()

    # Generate reflexive closure with exactly 4 elements
    while len(relation) < 4:
        pair = (random.choice(elements), random.choice(elements))
        relation.add(pair)

    # Ensure the relation is reflexive
    while not is_reflexive(set(elements), relation):
        element = random.choice(elements)
        if (element, element) not in relation:
            relation.add((element, element))

    # Trim down to 4 elements, ensuring at least one diagonal pair remains
    while len(relation) > 4:
        non_diagonal_pairs = relation - {(a, a) for a in elements}
        relation.remove(random.choice(list(non_diagonal_pairs)))

    return relation

# Function to generate a random symmetric relation with exactly 4 elements
def generate_random_symmetric_relation():
    elements = [1, 2, 3, 4]
    relation = set()
    while len(relation) < 4:  # Generate four pairs and their reverse to ensure 4 elements
        pair = (random.choice(elements), random.choice(elements))
        relation.add(pair)
        relation.add(pair[::-1])  # Add the reverse pair to ensure symmetry
    return relation

# Function to generate a random transitive relation with exactly 4 elements
def generate_random_transitive_relation():
    elements = [1, 2, 3, 4]
    relation = set()
    while len(relation) < 4:
        pair = (random.choice(elements), random.choice(elements))
        relation.add(pair)

    # Generate transitive closure with a maximum of 4 elements
    for _ in range(10):  # Try a maximum of 10 times to ensure we don't get stuck in an infinite loop
        for a, b in relation.copy():
            for c in elements:
                if (b, c) in relation and (a, c) not in relation and len(relation) < 4:
                    relation.add((a, c))
                    if len(relation) == 4:
                        break
            if len(relation) == 4:
                break
        if len(relation) == 4:
            break
    return relation

# Function to generate a question and its correct answer
def generate_question():
    relations = []
    relation_type = random.choice(['reflexive', 'symmetric', 'transitive'])
    if relation_type == 'reflexive':
        relation = generate_random_reflexive_relation()
    elif relation_type == 'symmetric':
        relation = generate_random_symmetric_relation()
    else:
        relation = generate_random_transitive_relation()
        
    return relation, relation_type


# Reflexive Relation
# A relation 'Relation' on a set 'Set' is called reflexive when:
# ∀ a ∈ Set, (a,a) ∈ Relation
def is_reflexive(Set, Relation):
    newSet = {(a, b) for a in Set for b in Set if a == b}
    if Relation >= newSet:
        return True
    return False

# Symmetric Relation
# A relation 'Relation' is called symmetric when:
#  ∀ (a, b) ∈ Relation, (b, a) ∈ Relation
def is_symmetric(Relation):
    return all(tup[::-1] in Relation for tup in Relation)

# Transitive Relation
# A relation 'Relation' is called transitive when:
#  ∀ (a, b), (b, c) ∈ Relation, (a, c) ∈ Relation
def is_transitive(relation):
    for a, b in relation:
        for c, d in relation:
            if b == c and ((a, d) not in relation):
                return False
    return True










