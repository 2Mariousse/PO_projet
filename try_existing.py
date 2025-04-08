from unified_planning.io import PDDLReader
from up_enhsp.enhsp_planner import ENHSPEngine
planner_name="enhsp"
import csv
import argparse
import sys
csv_filename = "times.csv"
parser = argparse.ArgumentParser()
parser.add_argument("domain",type=str)
parser.add_argument("problem",type=str)
args = parser.parse_args()

domain_file=args.domain
problem_file=args.problem
planner = ENHSPEngine()
pddl_reader = PDDLReader()

import re

def get_domain_name_from_pddl(domain_file):
    with open(domain_file, "r") as f:
        for line in f:
            match = re.search(r"\(define\s+\(domain\s+([^\s)]+)", line)
            if match:
                return match.group(1)
    return "unknown"



def save_plan_to_file(plan_actions: list, domain_name: str, problem_name: str):
    match = re.search(r"([^/]+)\.pddl$", problem_file)
    with open(f"{planner_name}/{domain_name}__{match.group(1)}.plan", "w") as f:
        f.write(f";;!domain: {domain_name}\n")
        f.write(f";;!problem: {problem_name}\n\n")

        for i, action in enumerate(plan_actions):
            f.write(
                f"{i}: ({' '.join([action.action.name] + [str(param) for param in action.actual_parameters])})\n"
            )

        makespan = len(plan_actions) - 1
        f.write(f"\n; Makespan: {makespan}\n")
        f.write(f"; Metric: {makespan}\n")


problem = pddl_reader.parse_problem(domain_file, problem_file)

result = planner.solve(problem, output_stream=sys.stdout)


if result.plan is None:
    print(f"No plan found for {problem.name}")
else:
    print(f"Plan found for {problem.name}")

    domain_name=get_domain_name_from_pddl(domain_file)

    message= result.log_messages[0].message
    # récupérer les performances :

    plan_length_match = re.search(r"Plan-Length:(\d+)", message)
    metric_match = re.search(r"Metric \(Search\):([\d.]+)", message)
    planning_time_match = re.search(r"Planning Time \(msec\): (\d+)", message)
    heuristic_time_match = re.search(r"Heuristic Time \(msec\): (\d+)", message)
    search_time_match = re.search(r"Search Time \(msec\): (\d+)", message)
    expanded_nodes_match = re.search(r"Expanded Nodes:(\d+)", message)
    states_evaluated_match = re.search(r"States Evaluated:(\d+)", message)
    dead_ends_match = re.search(r"Number of Dead-Ends detected:(\d+)", message)
    duplicates_match = re.search(r"Number of Duplicates detected:(\d+)", message)


    plan_length = int(plan_length_match.group(1)) if plan_length_match else None
    metric = float(metric_match.group(1)) if metric_match else None
    planning_time = int(planning_time_match.group(1)) / 1000 if planning_time_match else None 
    heuristic_time = int(heuristic_time_match.group(1)) / 1000 if heuristic_time_match else None
    search_time = int(search_time_match.group(1)) / 1000 if search_time_match else None
    expanded_nodes = int(expanded_nodes_match.group(1)) if expanded_nodes_match else None
    states_evaluated = int(states_evaluated_match.group(1)) if states_evaluated_match else None
    dead_ends = int(dead_ends_match.group(1)) if dead_ends_match else None
    duplicates = int(duplicates_match.group(1)) if duplicates_match else None



    # Vérifier si le fichier existe pour écrire l'en-tête une seule fois

    # Sauvegarde des données dans un fichier CSV
    with open(csv_filename, "a", newline="") as csvfile:
        csv_writer = csv.writer(csvfile)
        
        
        # Écrire les valeurs extraites
        csv_writer.writerow([
            domain_name, problem.name, plan_length, metric, planning_time,
            heuristic_time, search_time, expanded_nodes, 
            states_evaluated, dead_ends, duplicates
        ])

    print(f"Résultats sauvegardés dans {csv_filename}")



    save_plan_to_file(result.plan.actions, domain_name, problem.name)
