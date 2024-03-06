import random

# Transitive Relation
# A relation 'Relation' is called transitive when:
#  ∀ (a, b) ∈ Relation and (b, c) ∈ Relation, then (a, c) ∈ Relation
def is_transitive(relation):
    for a, b in relation:
        for c, d in relation:
            if b == c and ((a, d) not in relation):
                return False
    return True

# Function to generate a random transitive relation with exactly 4 elements
def generate_random_transitive_relation():
    elements = [1, 2, 3, 4, 5, 6]
    relation = set()

    while len(relation) < 6:
        pair = (random.choice(elements), random.choice(elements))
        relation.add(pair)

    is_transitive_relation = is_transitive(relation)  # Check if the relation is transitive

    return relation, is_transitive_relation  # Return a tuple containing the relation and its transitivity

# Function to generate a random non-transitive relation with exactly 4 elements
def generate_random_non_transitive_relation():
    elements = [1, 2, 3, 4, 5, 6]
    relation = set()

    while len(relation) < 6:
        pair = (random.choice(elements), random.choice(elements))
        relation.add(pair)

    is_transitive_relation = is_transitive(relation)  # Check if the relation is transitive

    return relation, not is_transitive_relation  # Return a tuple containing the relation and whether it's non-transitive

# Function to generate a question and its correct answer
def generate_question():
    # Randomly choose whether to generate a transitive or non-transitive relation
    if random.random() < 0.5:
        return generate_random_transitive_relation()
    else:
        return generate_random_non_transitive_relation()

# Main function to run the quiz
def main():
    generated_relation, is_transitive_relation = generate_question()
    
    print("Generated relation:", generated_relation)
    print("Is Transitive:", is_transitive_relation)

if __name__ == "__main__":
    main()



