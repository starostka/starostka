from itertools import combinations
import pandas as pd
import pickle
from scipy.stats import ttest_rel, t

with open('result_pivot.pickle', 'rb') as handle:
    df = pickle.load(handle)

#df = pd.read_csv('pivot_results.csv', header=[0,1,2], index_col=7)

result = pd.DataFrame(columns=['pairs', 'p-value', 'confidence interval', 'reject null-hypothesis'])

conf_int = 1 - 0.05 # 95 % confidence interval
for idx, i in enumerate(combinations(['baseline', 'ridge', 'ann'], 2)):
    z_a, z_b = df['quality:test'][i[0]], df['quality:test'][i[1]]
    statistic, p_value = ttest_rel(z_a, z_b)
    print(f"{i[0]} vs {i[1]} statistic: {statistic}")
    print(f"{i[0]} vs {i[1]} p-value: {p_value}")
    reject_null = False
    if p_value < 0.05:
        reject_null = True
        print("The null hypothesis is rejected")
    row = {'pairs': f"({i[0]},{i[1]})", 'p-value': f"\({p_value:.4f}\)", 'confidence interval': f"\({conf_int} \%\)", 'reject null-hypothesis': reject_null}
    result = result.append(row, ignore_index=True)

print(result.to_latex(escape=False))