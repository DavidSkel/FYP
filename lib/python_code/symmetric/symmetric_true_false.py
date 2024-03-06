#https://stackoverflow.com/questions/43153333/python-relations-with-sets-of-tuples

import random

# Function to generate a random symmetric relation with exactly 4 elements
def generate_random_symmetric_relation(symmetric_probability=0.5):
    elements = [1, 2, 3, 4, 5, 6]
    relation = set()

    # Randomly choose whether to make the relation symmetric
    if random.random() < symmetric_probability:
        # If chosen, make the relation symmetric by adding reversed pairs
        symmetric_relation = set()
        while len(symmetric_relation) < 6:
            pair = (random.choice(elements), random.choice(elements))
            symmetric_relation.add(pair)
            symmetric_relation.add(pair[::-1])

        # Ensure that only 4 elements are in the symmetric relation
        symmetric_relation = set(list(symmetric_relation)[:6])

        return symmetric_relation, True
    else:
        while len(relation) < 6:
            pair = (random.choice(elements), random.choice(elements))
            relation.add(pair)

        return relation, False

# Symmetric Relation
# A relation 'Relation' is called symmetric when:
#  ∀ (a, b) ∈ Relation, (b, a) ∈ Relation
def is_symmetric(Relation):
    return all(tup[::-1] in Relation for tup in Relation)

# Function to generate a random non-symmetric relation with exactly 4 elements
def generate_random_non_symmetric_relation():
    elements = [1, 2, 3, 4, 5, 6]
    relation = set()

    while len(relation) < 6:
        pair = (random.choice(elements), random.choice(elements))
        relation.add(pair)

    return relation, False

# Function to generate a question and its correct answer
def generate_question():
    # Randomly choose whether to generate a symmetric or non-symmetric relation
    if random.random() < 0.5:
        return generate_random_symmetric_relation()
    else:
        return generate_random_non_symmetric_relation()

# Main function to run the quiz
def main():
    generated_relation, is_symmetric_relation = generate_question()
    
    print("Generated relation:", generated_relation)
    print("Is Symmetric:", is_symmetric_relation)

if __name__ == "__main__":
    main()

































