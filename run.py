from unified_planning.io import PDDLReader
from up_enhsp.enhsp_planner import ENHSPEngine
from unified_planning.plans import SequentialPlan
from unified_planning.plans.plan import ActionInstance

import sys


domain_file = "domain.pddl"

planner = ENHSPEngine("-h blcost")
pddl_reader = PDDLReader()


def save_plan_to_file(
    plan_actions: list[ActionInstance], domain_name: str, problem_name: str | None
):
    with open(f"{problem_name}.plan", "w") as f:
        f.write(f";;!domain: {domain_name}\n")
        f.write(f";;!problem: {problem_name}\n\n")

        for i, action in enumerate(plan_actions):
            f.write(
                f"{i}: ({' '.join([action.action.name] + [str(param) for param in action.actual_parameters])})\n"
            )

        makespan = len(plan_actions) - 1
        f.write(f"\n; Makespan: {makespan}\n")
        f.write(f"; Metric: {makespan}\n")


for problem_name in ["easy", "medium", "hard", "very_hard"]:
    problem = pddl_reader.parse_problem(domain_file, f"{problem_name}.pddl")
    result = planner.solve(problem, output_stream=sys.stdout)

    if result.plan is None:
        print(f"No plan found for {problem.name}")
    else:
        assert isinstance(result.plan, SequentialPlan)

        print(f"Plan found for {problem.name}")
        save_plan_to_file(result.plan.actions, "the_game", problem.name)
