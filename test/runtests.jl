using Seaborn
using Test

# Let's just make sure this doesn't error
rugplot([1,3,5])

# Issue #11
Seaborn.set(style="ticks")
