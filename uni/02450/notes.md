
# Association Mining

$support=\frac{X}{\lvert T \rvert}$

Support for an $item > 40\%$ means $0.4 \times \lvert T \rvert$ must be satisfied.

$confidence=\frac{support(X\bigcup Y)}{support(X)}$

# Naïve Bayes Classifier

$p\left(y \mid x_{1}, x_{2}, \ldots, x_{M}\right)=\frac{p\left(x_{1}, x_{2}, \ldots, x_{M} \mid y\right) p(y)}{\sum_{k=0}^{K-1} p\left(x_{1}, x_{2}, \ldots, x_{M} \mid y=k\right) p(y=k)}$

# AUC

$TPR / Recall / Sensitivity =\frac{\text { TP }}{\text { TP }+\text { FN }}$

$Specificity=\frac{\text { TN }}{\text { TN + FP }}$

FPR = $1 - Specificity=\frac{F P}{T N+F P}$

# k-means

Compute k-means
```python
from sklearn.cluster import KMeans
x = np.array([[1.0, 1.2, 1.8, 2.3, 2.6, 3.4, 4.0, 4.1, 4.2]]).T

kmeans = KMeans(n_clusters=3, init=np.array([[1.8,3.3,3.6]]).T).fit(x)

kmeans.cluster_centers_
```