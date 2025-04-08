import pandas as pd
import matplotlib.pyplot as plt

# Charger les deux CSV
csv1 = pd.read_csv('times1_0.csv')  # remplace avec le chemin réel
csv2 = pd.read_csv('times.csv')  # idem

# Standardiser les colonnes si nécessaire (par ex. enlever espaces)
csv1.columns = csv1.columns.str.strip()
csv2.columns = csv2.columns.str.strip()

# Fusionner sur Domain + Problem (clé commune)
merged = pd.merge(csv1, csv2, on=['Domain', 'Problem'], suffixes=('_csv1', '_csv2'))

# Choisir les colonnes à comparer
metrics = ['Planning Time (s)', 'Search Time (s)', 'Expanded Nodes',"Plan-Length"]

# Pour chaque métrique, faire un barplot comparatif
for metric in metrics:
    plt.figure(figsize=(12, 5))
    x_labels = merged['Domain'] + ' - ' + merged['Problem']
    values1 = merged[f'{metric}_csv1']
    values2 = merged[f'{metric}_csv2']
    
    x = range(len(merged))
    width = 0.35
    
    plt.bar([i - width/2 for i in x], values1, width, label='1-0')
    plt.bar([i + width/2 for i in x], values2, width, label='hadd')
    
    plt.xticks(ticks=x, labels=x_labels, rotation=90)
    plt.ylabel(metric)
    plt.title(f'Comparaison de {metric} (1-0 vs hadd)')
    plt.legend()
    plt.tight_layout()
    plt.grid(axis='y', linestyle='--', alpha=0.7)
    plt.savefig(f'comparison_{metric.replace(" ", "_")}.png')
    plt.close()
