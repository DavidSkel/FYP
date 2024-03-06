import os
from flask import Flask, request, jsonify
import importlib.util

app = Flask(__name__)

# Function to import Python script dynamically
def import_python_script(script_path):
    spec = importlib.util.spec_from_file_location(os.path.basename(script_path).split('.')[0], script_path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module

@app.route('/quiz', methods=['GET'])
def get_quiz_question():
    question_type = int(request.args.get('question_type', -1))
    if question_type == 1:
        script_path = 'all_multiple_choice.py'  # Adjust the path accordingly
        question_module = import_python_script(script_path)
        relation, relation_type = question_module.generate_question()
        question_data = {
            'relation': list(relation),
            'relation_type': relation_type
        }
        return jsonify(question_data)
    
    if question_type == 2:
        script_path = 'transitive/transitive_true_false.py'  # Adjust the path accordingly
        question_module = import_python_script(script_path)
        generated_relation, is_transitive_relation = question_module.generate_question()

        # Convert the set to a list before passing it to jsonify
        question_data = {
            'relation': list(generated_relation),
            'is_transitive': is_transitive_relation
        }
        return jsonify(question_data)
    
    if question_type == 3:
        script_path = 'transitive/transitive_multiple_choice.py'  # Adjust the path accordingly
        question_module = import_python_script(script_path)
        relations, is_transitive_relation, transitive_index = question_module.generate_question()
        question_data = {
            'relations': list(relations),
            'is_transitive_relation': is_transitive_relation,
            'transitive_index': transitive_index
        }
        return jsonify(question_data)
    
    if question_type == 4:
        script_path = 'symmetric/symmetric_true_false.py'  # Adjust the path accordingly
        question_module = import_python_script(script_path)
        generated_relation, is_symmetric_relation = question_module.generate_question()

        # Convert the set to a list before passing it to jsonify
        question_data = {
            'relation': list(generated_relation),
            'is_symmetric': is_symmetric_relation
        }
        return jsonify(question_data)
    
    if question_type == 5:
        script_path = 'symmetric/symmetric_multiple_choice.py'  # Adjust the path accordingly
        question_module = import_python_script(script_path)
        relations, is_symmetric_relation, symmetric_index = question_module.generate_question()
        question_data = {
            'relations': list(relations),
            'is_symmetric_relation': is_symmetric_relation,
            'symmetric_index': symmetric_index
        }
        return jsonify(question_data)
    
    if question_type == 6:
        script_path = 'reflexive/reflexive_true_false.py'
        question_module = import_python_script(script_path)
        generated_relation, is_reflexive_relation = question_module.generate_question()

        # Convert the set to a list before passing it to jsonify
        question_data = {
            'relation': list(generated_relation),
            'is_reflexive': is_reflexive_relation
        }
        return jsonify(question_data)
    
    if question_type == 7:
        script_path = 'reflexive/reflexive_multiple_choice.py'
        question_module = import_python_script(script_path)
        relations, is_reflexive_relation, reflexive_index = question_module.generate_question()
        question_data = {
            'relations': list(relations),
            'is_reflexive_relation': is_reflexive_relation,
            'reflexive_index': reflexive_index
        }
        return jsonify(question_data)
    else:
        return jsonify({'error': 'Unknown question type'})

# This route handles the check_answer endpoint
@app.route('/check_answer', methods=['POST'])
def check_answer():
    user_choice = int(request.json.get('user_choice', -1))
    correct_choice = int(request.json.get('correct_choice', -1))

    if user_choice == correct_choice:
        response = {'result': 'Correct!'}
    else:
        response = {'result': 'Incorrect!'}

    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)

# @app.pos
# @app.get