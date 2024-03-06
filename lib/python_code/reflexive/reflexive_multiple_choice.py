import random
import time

# Seed the random number generator with the current system time
random.seed(time.time())

# Function to check if a relation is reflexive
def is_reflexive(Set, Relation):
    for element in Set:
        if (element, element) not in Relation:
            return False
    return True

# Function to generate a random relation with exactly 6 elements
def generate_random_relation():
    elements = [1, 2, 3, 4, 5, 6]
    relation = set()
    while len(relation) < 6:
        pair = (random.choice(elements), random.choice(elements))
        relation.add(pair)
    return relation

def generate_reflexive_relation():
    # Generate a set of 6 elements
    Set = set(range(1, 6))

    # Initialize an empty relation
    Relation = set()

    # Generate pairs ensuring no repetition
    while len(Relation) < 1:
        a = random.choice(tuple(Set))
        b = random.choice(tuple(Set - {a}))  # Exclude 'a' to avoid repeated pairs
        pair = (min(a, b), max(a, b))  # Ensure the pair is ordered
        # Ensure no repeated pairs
        if pair not in Relation and (pair[1], pair[0]) not in Relation:
            Relation.add(pair)

    # Add reflexive pairs to the relation
    for element in Set:
        if (element, element) not in Relation:
            Relation.add((element, element))

    # Check if the relation is reflexive
    if is_reflexive(Set, Relation):
        return Relation
    else:
        return None

def generate_question():
    relations = []  # Change to list
    is_reflexive_relation = False
    
    while not is_reflexive_relation:
        relations = []  # Change to list
        reflexive_relation = generate_reflexive_relation()
        for i in range(4):
            if i == 0:
                relation = reflexive_relation  # No need to convert to list
                is_reflexive_relation = True
            else:
                relation = generate_random_relation()  # No need to convert to list
            relations.append(list(relation))  # Add relation as list

    random.shuffle(relations)
    reflexive_index = next(i for i, relation in enumerate(relations) if is_reflexive({1, 2, 3, 4}, relation))

    return relations, is_reflexive_relation, reflexive_index

# Main function to run the quiz
def main():
    relations, is_reflexive_relation, _ = generate_question()
    reflexive_index = next(i for i, relation in enumerate(relations) if is_reflexive({1, 2, 3, 4}, relation))
    
    print("Generated relations:", relations)
    print("Is reflexive:", is_reflexive_relation)
    print("Reflexive index:", reflexive_index)

if __name__ == "__main__":
    main()
