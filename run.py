from unified_planning.io import PDDLReader
from up_enhsp.enhsp_planner import ENHSPEngine


domain_file = "domain.pddl"

planner = ENHSPEngine()
pddl_reader = PDDLReader()


def save_plan_to_file(plan_actions: list, domain_name: str, problem_name: str):
    with open(f"{problem_name}.plan", "w") as f:
        f.write(f";;!domain: {domain_name}\n")
        f.write(f";;!problem: {problem_name}\n\n")

        for i, action in enumerate(plan_actions):
            f.write(
                f"{i}: ({' '.join([action.action.name] + [param.name for param in action.action.parameters])})\n"
            )

        makespan = len(plan_actions) - 1
        f.write(f"\n; Makespan: {makespan}\n")
        f.write(f"; Metric: {makespan}\n")


for problem_name in ["easy", "medium", "hard"]:
    problem = pddl_reader.parse_problem(domain_file, f"{problem_name}.pddl")
    result = planner.solve(problem)

    if result.plan is None:
        print(f"No plan found for {problem.name}")
    else:
        print(f"Plan found for {problem.name}")
        save_plan_to_file(result.plan.actions, "the_game", problem.name)
