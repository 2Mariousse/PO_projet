from __future__ import annotations
from fractions import Fraction
from itertools import product
from typing import Iterator, cast
from tqdm import tqdm

from unified_planning.io import PDDLReader
from unified_planning.model import FNode, Problem, Object
from unified_planning.model.effect import Effect, EffectKind
from unified_planning.plans.plan import ActionInstance
from unified_planning.plans import SequentialPlan


type Value = bool | int | Fraction
type State = dict[FNode, Value]

domain_file = "domain.pddl"
problem_file = "medium.pddl"

pddl_reader = PDDLReader()

problem = pddl_reader.parse_problem(domain_file, problem_file)


class FlowGraph:
    def __init__(self, problem: Problem):
        self.problem = problem
        self.root = Node(
            self,
            0,
            {
                node: value.constant_value()
                for node, value in problem.initial_values.items()
            },
        )
        self.layers = {0: {self.root}}


class Node:
    def __init__(self, graph: FlowGraph, layer: int, state: State):
        self.graph = graph
        self.layer = layer
        self.state = state
        self.children: set[tuple[Node, ActionInstance]] = set()
        self.parents: set[tuple[Node, ActionInstance]] = set()

    def __repr__(self):
        return f"{self.state} -> {self.children}"

    def __hash__(self) -> int:
        return hash(tuple(self.state.items())) ^ hash(self.layer)

    def add_child(self, child: Node, action: ActionInstance):
        self.children.add((child, action))
        child.parents.add((self, action))


def generate_all_actions(problem: Problem) -> list[ActionInstance]:
    all_actions: list[ActionInstance] = []

    for action in problem.actions:
        param_values: list[list[Object]] = []
        for parameter in action.parameters:
            param_values.append(list(problem.objects(parameter.type)))

        for values in product(*param_values):
            all_actions.append(action(*values))

    return all_actions


def generate_possible_actions_from(
    actions: list[ActionInstance], state: State
) -> Iterator[ActionInstance]:
    for action in actions:
        if check_preconditions(action, state):
            yield action


def generate_initial_state(problem: Problem) -> State:
    return {
        node: value.constant_value() for node, value in problem.initial_values.items()
    }


def check_preconditions(action: ActionInstance, state: State) -> bool:
    return all(
        precondition.substitute(state).simplify().constant_value()
        for precondition in actions_preconditions[action]
    )


def apply_action(action: ActionInstance, state: State) -> State:
    new_state = state.copy()
    for target, (kind, value) in actions_effects[action]:
        if kind == EffectKind.ASSIGN:
            new_state[target] = value
        if kind == EffectKind.INCREASE:
            new_state[target] += value
        if kind == EffectKind.DECREASE:
            new_state[target] -= value
    return new_state


def check_final_state(state: State) -> bool:
    for goal in problem.goals:
        if not goal.substitute(state).simplify().constant_value():
            return False
    return True


def generate_plan(node: Node) -> SequentialPlan:
    plan: list[ActionInstance] = []
    while node.layer > 0:
        node, action = node.parents.pop()
        plan.append(action)
    return SequentialPlan(plan[::-1])


def generate_graph(actions: list[ActionInstance]) -> SequentialPlan:
    graph = FlowGraph(problem)
    for layer in tqdm(range(50)):
        graph.layers[layer + 1] = set()
        for node in graph.layers[layer]:
            for action in generate_possible_actions_from(actions, node.state):
                new_state = apply_action(action, node.state)

                if check_final_state(new_state):
                    return generate_plan(node)

                new_node = None
                for other_node in graph.layers[layer + 1]:
                    if other_node.state == new_state:
                        new_node = other_node
                        break
                else:
                    new_node = Node(graph, layer + 1, new_state)
                    graph.layers[layer + 1].add(new_node)

                node.add_child(new_node, action)

    return SequentialPlan([])


initial_state = generate_initial_state(problem)
actions = generate_all_actions(problem)
actions_preconditions = {
    action: [
        precondition.substitute(
            {
                param: value
                for param, value in zip(
                    action.action.parameters, action.actual_parameters
                )
            }
        )
        for precondition in action.action.preconditions
    ]
    for action in actions
}
actions_effects = {
    action: [
        (
            effect.fluent.substitute(
                {
                    param: value
                    for param, value in zip(
                        action.action.parameters, action.actual_parameters
                    )
                }
            ),
            (effect.kind, effect.value.constant_value()),
        )
        for effect in cast(list[Effect], action.action.effects)
    ]
    for action in actions
}

print(generate_graph(actions))
