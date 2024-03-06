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

# Function to generate a random relation with exactly 4 elements
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

def generate_random_or_reflexive_relation(reflexive_probability=0.5):
    is_reflexive = random.random() <= reflexive_probability
    if is_reflexive:
        return generate_reflexive_relation(), True
    else:
        return generate_random_relation(), False

def generate_question(reflexive_probability=0.5):
    generated_relation, is_reflexive_relation = generate_random_or_reflexive_relation(reflexive_probability)
    
    return generated_relation, is_reflexive_relation

# Main function to run the quiz
def main():
    generated_relation, is_reflexive_relation = generate_question()
    
    print("Generated relation:", generated_relation)
    print("Is reflexive:", is_reflexive_relation)

if __name__ == "__main__":
    main()















