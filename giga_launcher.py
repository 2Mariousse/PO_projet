import subprocess
import os

domain_files = []
problem_files = []
LIST_PROBLEMS=[
    "ipc2000-logistics-strips-typed",
    "ipc2002-settlers-numeric-automatic",
    "ipc2008-sokoban-sequential-optimal-strips",
    "ipc2014-tetris-sequential-optimal",
               ]
for ipc_year in LIST_PROBLEMS:
    domain_file=f"automated-planning-competition/{ipc_year}/domain.pddl"
    # breakpoint()
    directory = f"automated-planning-competition/{ipc_year}/instances"
    fichiers = os.listdir(directory)
    full_paths = [os.path.join(f"automated-planning-competition/{ipc_year}/instances", fichier) for fichier in fichiers]
    for fichier in full_paths:
        command = [
        "python3",
        "try_existing.py",
        domain_file,
        fichier
    ]
        try:
            subprocess.run(command,timeout=300)
        except:
            continue