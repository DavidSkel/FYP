#https://stackoverflow.com/questions/43153333/python-relations-with-sets-of-tuples

import random

# Function to generate a random relation with exactly 4 elements
def generate_random_relation():
    elements = [1, 2, 3, 4, 5, 6]
    relation = set()
    while len(relation) < 6:
        pair = (random.choice(elements), random.choice(elements))
        relation.add(pair)
    return relation

# Function to generate a random transitive relation with exactly 4 elements
def generate_random_transitive_relation():
    elements = [1, 2, 3, 4, 5, 6]
    relation = set()
    while len(relation) < 6:
        pair = (random.choice(elements), random.choice(elements))
        relation.add(pair)

    # Generate transitive closure with a maximum of 6 elements
    for _ in range(10):  # Try a maximum of 10 times to ensure we don't get stuck in an infinite loop
        for a, b in relation.copy():
            for c in elements:
                if (b, c) in relation and (a, c) not in relation and len(relation) < 6:
                    relation.add((a, c))
                    if len(relation) == 6:
                        break
            if len(relation) == 6:
                break
        if len(relation) == 6:
            break
    return relation

# Function to generate a question and its correct answer
def generate_question():
    relations = []
    is_transitive_relation = False
    transitive_relation = generate_random_transitive_relation()
    
    for i in range(4):
        if i == 0:
            relation = transitive_relation
            is_transitive_relation = True
        else:
            relation = generate_random_relation()
        relations.append(list(relation))  # Convert relation to list and append

    random.shuffle(relations)  # Shuffle the list of relations so the transitive one is not always first
    transitive_index = next(i for i, relation in enumerate(relations) if relation == list(transitive_relation))

    return relations, is_transitive_relation, transitive_index


# Transitive Relation
# A relation 'Relation' is called transitive when:
#  ∀ (a, b), (b, c) ∈ Relation, (a, c) ∈ Relation
def is_transitive(Set, relation):
    for a, b in relation:
        for c in Set:
            if (b, c) in relation and (a, c) not in relation:
                return False
    return True

# Main function to run the quiz
def main():
    relations, is_transitive_relation, _ = generate_question()
    transitive_index = next(i for i, relation in enumerate(relations) if is_transitive({1, 2, 3, 4}, relation))
    
    print("Generated relations:", relations)
    print("Is transitive:", is_transitive_relation)
    print("Transitive index:", transitive_index)

if __name__ == "__main__":
    main()

