import numpy as np
import matplotlib.pyplot as plt

incomes= np.random.normal(100.0,20.0,10000)
#variance
variance=incomes.var()
print("Variance:",variance)
#standard deviation
standard_dev=incomes.std()
print("Standard Dev:",standard_dev)

plt.hist(incomes,50,edgecolor='black')
plt.show()