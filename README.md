# Seaborn

[![Build Status](https://travis-ci.org/JuliaPy/Seaborn.jl.svg?branch=master)](https://travis-ci.org/JuliaPy/Seaborn.jl)

A Julia wrapper around the [Seaborn data visualization library](http://seaborn.pydata.org/index.html):

> Seaborn is a Python data visualization library based on [matplotlib](https://matplotlib.org/). It provides a high-level interface for drawing attractive and informative statistical graphics.

> For a brief introduction to the ideas behind the library, you can read the [introductory notes](http://seaborn.pydata.org/introduction.html) or the [paper](https://joss.theoj.org/papers/10.21105/joss.03021). Visit the [installation page](http://seaborn.pydata.org/installing.html) to see how you can download the package and get started with it. You can browse the [example gallery](http://seaborn.pydata.org/examples/index.html) to see some of the things that you can do with seaborn, and then check out the [tutorial](http://seaborn.pydata.org/tutorial.html) or [API reference](http://seaborn.pydata.org/api.html) to find out how.

> To see the code or report a bug, please visit the [GitHub repository](https://github.com/mwaskom/seaborn). General support questions are most at home on [stackoverflow](https://stackoverflow.com/questions/tagged/seaborn/) or [discourse](https://discourse.matplotlib.org/c/3rdparty/seaborn/21), which have dedicated channels for seaborn.

![Gallery](http://seaborn.pydata.org/_static/anscombes_quartet_thumb.png)
![Gallery](http://seaborn.pydata.org/_static/many_pairwise_correlations_thumb.png)
![Gallery](http://seaborn.pydata.org/_static/many_facets_thumb.png)
![Gallery](http://seaborn.pydata.org/_static/scatterplot_matrix_thumb.png)
![Gallery](http://seaborn.pydata.org/_static/hexbin_marginals_thumb.png)
![Gallery](http://seaborn.pydata.org/_static/scatterplot_categorical_thumb.png)

# Installation and usage

This Julia wrapper exposes all of the functions in the [Seaborn API](http://seaborn.pydata.org/api.html).

You need to have a Python distribution installed with the `seaborn` Python package. If you do not already have it, run `pip install seaborn` form the command line.
