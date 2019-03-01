__precompile__(true)
module Seaborn

export
jointplot,
pairplot,
distplot,
kdeplot,
rugplot,
lmplot,
regplot,
residplot,
interactplot,
coefplot,
factorplot,
boxplot,
violinplot,
stripplot,
swarmplot,
pointplot,
barplot,
countplot,
heatmap,
clustermap,
tsplot,
palplot,
FacetGrid,
PairGrid,
JointGrid,
axes_style,
set_style,
plotting_context,
set_context,
set_color_codes,
reset_defaults,
reset_orig,
load_dataset

using Reexport
using PyCall
import Pandas
@reexport using PyPlot

const seaborn = PyNULL()

function __init__()
    copy!(seaborn, pyimport_conda("seaborn", "seaborn"))
end

macro delegate(f_list...)
    blocks = Expr(:block)
    for f in f_list
        block = quote
            function $(esc(f))(args...; kwargs...)
                seaborn.$(QuoteNode(f))(args...; kwargs...)
            end
        end
        push!(blocks.args, block)
    end
    blocks
end

@delegate jointplot pairplot kdeplot lmplot regplot residplot interactplot coefplot boxplot violinplot stripplot swarmplot pointplot clustermap tsplot palplot FacetGrid PairGrid JointGrid axes_style set_style plotting_context set_context set_color_codes reset_defaults reset_orig set


"""
    distplot(a; <keyword arguments>)

Flexibly plot a univariate distribution of observations.

This function combines the matplotlib `hist` function (with automatic
calculation of a good default bin size) with the seaborn `kdeplot`
and `rugplot` functions. It can also fit `scipy.stats`
distributions and plot the estimated PDF over the data.

# Arguments

* `a` : Series, 1d-array, or list.
    Observed data. If this is a Series object with a ``name`` attribute,
    the name will be used to label the data axis.
* `bins` : argument for matplotlib hist(), or None, optional.
    Specification of hist bins, or None to use Freedman-Diaconis rule.
* `hist` : bool, optional.
    Whether to plot a (normed) histogram.
* `kde` : bool, optional.
    Whether to plot a gaussian kernel density estimate.
* `rug` : bool, optional.
    Whether to draw a rugplot on the support axis.
* `fit` : random variable object, optional.
    An object with `fit` method, returning a tuple that can be passed to a
    `pdf` method a positional arguments following an grid of values to
    evaluate the pdf on.
* `{hist, kde, rug, fit}_kws` : dictionaries, optional.
    Keyword arguments for underlying plotting functions.
* `color` : matplotlib color, optional.
    Color to plot everything but the fitted curve in.
* `vertical` : bool, optional.
    If True, oberved values are on y-axis.
* `norm_hist` : bool, optional.
    If True, the histogram height shows a density rather than a count.
    This is implied if a KDE or fitted density is plotted.
* `axlabel` : string, False, or None, optional.
    Name for the support axis label. If None, will try to get it
    from a.namel if False, do not set a label.
* `label` : string, optional.
    Legend label for the relevent component of the plot
* `ax` : matplotlib axis, optional.
    if provided, plot on this axis

# Returns
`ax` : matplotlib Axes
    Returns the Axes object with the plot for further tweaking.

# See Also

* `kdeplot` : Show a univariate or bivariate distribution with a kernel
          density estimate.
* `rugplot` : Draw small vertical lines to show each observation in a
          distribution.
"""
function distplot(args...; kwargs...)
    seaborn.distplot(args...; kwargs...)
end

"""
    rugplot(a; <keyword arguments>)

Plot datapoints in an array as sticks on an axis.

# Arguments

* `a` : 1D array of observations.
* `height` : Height of ticks as proportion of the axis.
* `axis` : Axis to draw rugplot on.
* `ax` : Axes to draw plot into; otherwise grabs current axes.
* `kwargs` :  Other keyword arguments are passed to `axvline` or `axhline`.

# Returns

* `ax` :  The `Axes` object with the plot on it.
"""
function rugplot(args...; kwargs...)
    seaborn.rugplot(args...; kwargs...)
end

"""
    countplot(x; <keyword arguments>)

Show the counts of observations in each categorical bin using bars.

A count plot can be thought of as a histogram across a categorical, instead
of quantitative, variable. The basic API and options are identical to those
for `barplot`, so you can compare counts across nested variables.

Input data can be passed in a variety of formats, including:

* Vectors of data represented as lists, numpy arrays, or pandas Series
  objects passed directly to the ``x``, ``y``, and/or ``hue`` parameters.
* A "long-form" DataFrame, in which case the ``x``, ``y``, and ``hue``
  variables will determine how the data are plotted.
* A "wide-form" DataFrame, such that each numeric column will be plotted.
* Anything accepted by `plt.boxplot` (e.g. a 2d array or list of vectors)

In most cases, it is possible to use numpy or Python objects, but pandas
objects are preferable because the associated names will be used to
annotate the axes. Additionally, you can use Categorical types for the
grouping variables to control the order of plot elements.

# Parameters

* `x`, `y`, `hue` : names of variables in ``data`` or vector data, optional.
    Inputs for plotting long-form data. See examples for interpretation.
* `data` : DataFrame, array, or list of arrays, optional.
    Dataset for plotting. If ``x`` and ``y`` are absent, this is
    interpreted as wide-form. Otherwise it is expected to be long-form.
* `order`, `hue_order` : lists of strings, optional.
    Order to plot the categorical levels in, otherwise the levels are
    inferred from the data objects.
* `orient` : "v" | "h", optional.
    Orientation of the plot (vertical or horizontal). This is usually
    inferred from the dtype of the input variables, but can be used to
    specify when the "categorical" variable is a numeric or when plotting
    wide-form data.
* `color` : matplotlib color, optional.
    Color for all of the elements, or seed for `light_palette` when
    using hue nesting.
* `palette` : seaborn color palette or dict, optional.
    Colors to use for the different levels of the ``hue`` variable. Should
    be something that can be interpreted by `color_palette`, or a
    dictionary mapping hue levels to matplotlib colors.
* `saturation` : float, optional.
    Proportion of the original saturation to draw colors at. Large patches
    often look better with slightly desaturated colors, but set this to
    ``1`` if you want the plot colors to perfectly match the input color
    spec.
* `ax` : matplotlib Axes, optional.
    Axes object to draw the plot onto, otherwise uses the current Axes.
* `kwargs` : key, value mappings.
    Other keyword arguments are passed to ``plt.bar``.

# Returns

`ax` : matplotlib Axes
    Returns the Axes object with the boxplot drawn onto it.

# See Also

* `barplot` : Show point estimates and confidence intervals using bars.
* `factorplot` : Combine categorical plots and a class:`FacetGrid`.
"""
function countplot(args...; kwargs...)
    seaborn.countplot(args...; kwargs...)
end

"""
    barplot(x, y; <keyword arguments>)

Show point estimates and confidence intervals as rectangular bars.

A bar plot represents an estimate of central tendency for a numeric
variable with the height of each rectangle and provides some indication of
the uncertainty around that estimate using error bars. Bar plots include 0
in the quantitative axis range, and they are a good choice when 0 is a
meaningful value for the quantitative variable, and you want to make
comparisons against it.

For datasets where 0 is not a meaningful value, a point plot will allow you
to focus on differences between levels of one or more categorical
variables.

It is also important to keep in mind that a bar plot shows only the mean
(or other estimator) value, but in many cases it may be more informative to
show the distribution of values at each level of the categorical variables.
In that case, other approaches such as a box or violin plot may be more
appropriate.

Input data can be passed in a variety of formats, including:

- Vectors of data represented as lists, numpy arrays, or pandas Series
  objects passed directly to the `x`, `y`, and/or `hue` parameters.
- A "long-form" DataFrame, in which case the `x`, `y`, and `hue`
  variables will determine how the data are plotted.
- A "wide-form" DataFrame, such that each numeric column will be plotted.
- Anything accepted by `plt.boxplot` (e.g. a 2d array or list of vectors)

In most cases, it is possible to use numpy or Python objects, but pandas
objects are preferable because the associated names will be used to
annotate the axes. Additionally, you can use Categorical types for the
grouping variables to control the order of plot elements.

# Parameters

* `x`, `y`, `hue` : names of variables in ``data`` or vector data, optional.
    Inputs for plotting long-form data. See examples for interpretation.
* `data` : DataFrame, array, or list of arrays, optional.
    Dataset for plotting. If `x` and `y` are absent, this is
    interpreted as wide-form. Otherwise it is expected to be long-form.
* `order`, `hue_order` : lists of strings, optional.
    Order to plot the categorical levels in, otherwise the levels are
    inferred from the data objects.
* `estimator` : callable that maps vector -> scalar, optional.
    Statistical function to estimate within each categorical bin.
* `ci` : float or None, optional.
    Size of confidence intervals to draw around estimated values. If
    `nothing`, no bootstrapping will be performed, and error bars will
    not be drawn.
* `n_boot` : int, optional.
    Number of bootstrap iterations to use when computing confidence
    intervals.
* `units` : name of variable in `data` or vector data, optional.
    Identifier of sampling units, which will be used to perform a
    multilevel bootstrap and account for repeated measures design.
* `orient` : "v" | "h", optional.
    Orientation of the plot (vertical or horizontal). This is usually
    inferred from the dtype of the input variables, but can be used to
    specify when the "categorical" variable is a numeric or when plotting
    wide-form data.
* `color` : matplotlib color, optional.
    Color for all of the elements, or seed for `light_palette` when
    using hue nesting.
* `palette` : seaborn color palette or dict, optional.
    Colors to use for the different levels of the `hue` variable. Should
    be something that can be interpreted by `color_palette`, or a
    dictionary mapping hue levels to matplotlib colors.
* `saturation` : float, optional.
    Proportion of the original saturation to draw colors at. Large patches
    often look better with slightly desaturated colors, but set this to
    `1` if you want the plot colors to perfectly match the input color
    spec.
* `errcolor` : matplotlib color.
    Color for the lines that represent the confidence interval.
* `ax` : matplotlib Axes, optional.
    Axes object to draw the plot onto, otherwise uses the current Axes.
* `errwidth` : float, optional.
    Thickness of error bar lines (and caps).
* `capsize` : float, optional.
    Width of the "caps" on error bars.

* `kwargs` : key, value mappings.
    Other keyword arguments are passed through to `plt.bar` at draw
    time.

# Returns

`ax` : matplotlib Axes.
    Returns the Axes object with the boxplot drawn onto it.

# See Also

* `countplot` : Show the counts of observations in each categorical bin.
* `pointplot` : Show point estimates and confidence intervals using scatterplot
            glyphs.
* `factorplot` : Combine categorical plots and a class:`FacetGrid`.
"""
function barplot(args...; kwargs...)
    seaborn.barplot(args...; kwargs...)
end

"""
    heatmap(data; <keyword arguments>)

Plot rectangular data as a color-encoded matrix.

This function tries to infer a good colormap to use from the data, but
this is not guaranteed to work, so take care to make sure the kind of
colormap (sequential or diverging) and its limits are appropriate.

This is an Axes-level function and will draw the heatmap into the
currently-active Axes if none is provided to the ``ax`` argument.  Part of
this Axes space will be taken and used to plot a colormap, unless ``cbar``
is False or a separate Axes is provided to ``cbar_ax``.

# Parameters

* `data` : rectangular dataset.
    2D dataset that can be coerced into an ndarray. If a Pandas DataFrame
    is provided, the index/column information will be used to label the
    columns and rows.
* `vmin`, `vmax` : floats, optional.
    Values to anchor the colormap, otherwise they are inferred from the
    data and other keyword arguments. When a diverging dataset is inferred,
    one of these values may be ignored.
* `cmap` : matplotlib colormap name or object, optional.
    The mapping from data values to color space. If not provided, this
    will be either a cubehelix map (if the function infers a sequential
    dataset) or ``RdBu_r`` (if the function infers a diverging dataset).
* `center` : float, optional.
    The value at which to center the colormap. Passing this value implies
    use of a diverging colormap.
* `robust` : bool, optional.
    If True and ``vmin`` or ``vmax`` are absent, the colormap range is
    computed with robust quantiles instead of the extreme values.
* `annot` : bool or rectangular dataset, optional.
    If `true`, write the data value in each cell. If an array-like with the
    same shape as ``data``, then use this to annotate the heatmap instead
    of the raw data.
* `fmt` : string, optional.
    String formatting code to use when adding annotations.
* `annot_kws` : dict of key, value mappings, optional.
    Keyword arguments for ``ax.text`` when ``annot`` is True.
* `linewidths` : float, optional.
    Width of the lines that will divide each cell.
* `linecolor` : color, optional.
    Color of the lines that will divide each cell.
* `cbar` : boolean, optional.
    Whether to draw a colorbar.
* `cbar_kws` : dict of key, value mappings, optional.
    Keyword arguments for `fig.colorbar`.
* `cbar_ax` : matplotlib Axes, optional.
    Axes in which to draw the colorbar, otherwise take space from the
    main Axes.
* `square` : boolean, optional.
    If `true`, set the Axes aspect to "equal" so each cell will be
    square-shaped.
* `ax` : matplotlib Axes, optional.
    Axes in which to draw the plot, otherwise use the currently-active
    Axes.
* `xticklabels` : list-like, int, or bool, optional.
    If `true`, plot the column names of the dataframe. If `false`, don't plot
    the column names. If list-like, plot these alternate labels as the
    xticklabels. If an integer, use the column names but plot only every
    n label.
* `yticklabels` : list-like, int, or bool, optional.
    If `true`, plot the row names of the dataframe. If `false`, don't plot
    the row names. If list-like, plot these alternate labels as the
    yticklabels. If an integer, use the index names but plot only every
    n label.
* `mask` : boolean array or DataFrame, optional.
    If passed, data will not be shown in cells where ``mask`` is True.
    Cells with missing values are automatically masked.
* `kwargs` : other keyword arguments.
    All other keyword arguments are passed to ``ax.pcolormesh``.

# Returns

`ax` : matplotlib Axes.
    Axes object with the heatmap.
"""
function heatmap(args...; kwargs...)
    seaborn.heatmap(args...; kwargs...)
end

"""
    factorplot(<keyword arguments>)

Draw a categorical plot onto a FacetGrid.

The default plot that is shown is a point plot, but other seaborn
categorical plots can be chosen with the ``kind`` parameter, including
box plots, violin plots, bar plots, or strip plots.

It is important to choose how variables get mapped to the plot structure
such that the most important comparisons are easiest to make. As a general
rule, it is easier to compare positions that are closer together, so the
``hue`` variable should be used for the most important comparisons. For
secondary comparisons, try to share the quantitative axis (so, use ``col``
for vertical plots and ``row`` for horizontal plots). Note that, although
it is possible to make rather complex plots using this function, in many
cases you may be better served by created several smaller and more focused
plots than by trying to stuff many comparisons into one figure.

After plotting, the :class:`FacetGrid` with the plot is returned and can
be used directly to tweak supporting plot details or add other layers.

Note that, unlike when using the underlying plotting functions directly,
data must be passed in a long-form DataFrame with variables specified by
passing strings to ``x``, ``y``, ``hue``, and other parameters.

As in the case with the underlying plot functions, if variables have a
``categorical`` data type, the correct orientation of the plot elements,
the levels of the categorical variables, and their order will be inferred
from the objects. Otherwise you may have to use the function parameters
(``orient``, ``order``, ``hue_order``, etc.) to set up the plot correctly.

# Parameters

* `x`, `y`, hue : names of variables in ``data``.
    Inputs for plotting long-form data. See examples for interpretation.
* `data` : DataFrame.
    Long-form (tidy) dataset for plotting. Each column should correspond
    to a variable, and each row should correspond to an observation.
* `row`, `col` : names of variables in ``data``, optional.
    Categorical variables that will determine the faceting of the grid.
* `col_wrap` : int, optional.
    "Wrap" the column variable at this width, so that the column facets
    span multiple rows. Incompatible with a ``row`` facet.
* `estimator` : callable that maps vector -> scalar, optional.
    Statistical function to estimate within each categorical bin.
* `ci` : float or None, optional.
    Size of confidence intervals to draw around estimated values. If
    ``None``, no bootstrapping will be performed, and error bars will
    not be drawn.
* `n_boot` : int, optional.
    Number of bootstrap iterations to use when computing confidence
    intervals.
* `units` : name of variable in ``data`` or vector data, optional.
    Identifier of sampling units, which will be used to perform a
    multilevel bootstrap and account for repeated measures design.
* `order`, `hue_order` : lists of strings, optional.
    Order to plot the categorical levels in, otherwise the levels are
    inferred from the data objects.
* `row_order`, `col_order` : lists of strings, optional.
    Order to organize the rows and/or columns of the grid in, otherwise the
    orders are inferred from the data objects.
* `kind` : {``point``, ``bar``, ``count``, ``box``, ``violin``, ``strip``}.
    The kind of plot to draw.
* `size` : scalar, optional.
    Height (in inches) of each facet. See also: ``aspect``.
* `aspect` : scalar, optional.
    Aspect ratio of each facet, so that ``aspect * size`` gives the width
    of each facet in inches.
* `orient` : "v" | "h", optional.
    Orientation of the plot (vertical or horizontal). This is usually
    inferred from the dtype of the input variables, but can be used to
    specify when the "categorical" variable is a numeric or when plotting
    wide-form data.
* `color` : matplotlib color, optional.
    Color for all of the elements, or seed for :func:`light_palette` when
    using hue nesting.
* `palette` : seaborn color palette or dict, optional.
    Colors to use for the different levels of the ``hue`` variable. Should
    be something that can be interpreted by :func:`color_palette`, or a
    dictionary mapping hue levels to matplotlib colors.
* `legend` : bool, optional.
    If ``True`` and there is a ``hue`` variable, draw a legend on the plot.
* `legend_out` : bool, optional.
    If ``True``, the figure size will be extended, and the legend will be
    drawn outside the plot on the center right.
* `share{x,y}` : bool, optional.
    If true, the facets will share y axes across columns and/or x axes
    across rows.
* `margin_titles` : bool, optional.
    If ``True``, the titles for the row variable are drawn to the right of
    the last column. This option is experimental and may not work in all
    cases.
* `facet_kws` : dict, optional.
    Dictionary of other keyword arguments to pass to :class:`FacetGrid`.
* `kwargs` : key, value pairings.
    Other keyword arguments are passed through to the underlying plotting
    function.

# Returns

`g` : `FacetGrid`.
    Returns the `FacetGrid` object with the plot on it for further
    tweaking.
"""
function factorplot(args...; kwargs...)
    seaborn.factorplot(args...; kwargs...)
end

function load_dataset(name)
    o = seaborn.load_dataset(name)
    Pandas.DataFrame(o)
end

end # module
