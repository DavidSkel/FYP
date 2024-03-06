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

def generate_random_symmetric_relation():
    elements = [1, 2, 3, 4, 5, 6]
    relation = set()
    while len(relation) < 6:  # Generate three unique pairs to ensure 6 elements
        pair = (random.choice(elements), random.choice(elements))
        if pair[::-1] not in relation:  # Ensure the reverse pair is not already present
            relation.add(pair)
            relation.add(pair[::-1])  # Add the reverse pair to ensure symmetry
    return relation


# Function to generate a question and its correct answer
def generate_question():
    relations = []
    is_symmetric_relation = False
    symmetric_index = random.randint(0, 3)

    for i in range(4):
        if i == symmetric_index:
            relation = generate_random_symmetric_relation()
            is_symmetric_relation = True
        else:
            relation = generate_random_relation()
        relations.append(list(relation))  # Convert relation to list and append

    return relations, is_symmetric_relation, symmetric_index


# Symmetric Relation
# A relation 'Relation' is called symmetric when:
#  ∀ (a, b) ∈ Relation, (b, a) ∈ Relation
def is_symmetric(Set, Relation):
    return all(tup[::-1] in Relation for tup in Relation)

# Main function to run the quiz
def main():
    relations, is_symmetric_relation, _ = generate_question()
    symmetric_index = next(i for i, relation in enumerate(relations) if is_symmetric({1, 2, 3, 4}, relation))
    
    print("Generated relations:", relations)
    print("Is symmetric:", is_symmetric_relation)
    print("Symmetric index:", symmetric_index)

if __name__ == "__main__":
    main()







