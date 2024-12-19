import numpy as np
income= np.random.normal(27000,15000,10000)
np.mean(income)

import matplotlib.pyplot as plt
plt.hist(income, 50)
plt.show()
