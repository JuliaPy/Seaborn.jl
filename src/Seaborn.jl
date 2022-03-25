module Seaborn

using Reexport
using PyCall
import Pandas
@reexport using PyPlot

const seaborn = PyNULL()

function __init__()
    copy!(seaborn, pyimport_conda("seaborn", "seaborn"))
end

#metaprogram to export and define all API functions
# https://seaborn.pydata.org/api.html
for function_name ∈ [
    "relplot",
    "scatterplot",
    "lineplot",
    "displot",
    "histplot",
    "kdeplot",
    "ecdfplot",
    "rugplot",
    "catplot",
    "stripplot",
    "swarmplot",
    "boxplot",
    "violinplot",
    "boxenplot",
    "pointplot",
    "barplot",
    "countplot",
    "lmplot",
    "regplot",
    "residplot",
    "heatmap",
    "clustermap",
    "FacetGrid",
    "pairplot",
    "PairGrid",
    "jointplot",
    "JointGrid",
    "set_theme",
    "axes_style",
    "set_style",
    "plotting_context",
    "set_context",
    "set_color_codes",
    "reset_defaults",
    "reset_orig",
    "set_palette",
    "color_palette",
    "husl_palette",
    "hls_palette",
    "cubehelix_palette",
    "dark_palette",
    "light_palette",
    "diverging_palette",
    "blend_palette",
    "xkcd_palette",
    "crayon_palette",
    "mpl_palette",
    "choose_colorbrewer_palette",
    "choose_cubehelix_palette",
    "choose_light_palette",
    "choose_dark_palette",
    "choose_diverging_palette",
    "despine",
    "move_legend",
    "saturate",
    "desaturate",
    "set_hls_values",
    "load_dataset",
    "get_datset_names",
    "get_data_home"
]
    #symbolize the function name
    f = Symbol(function_name)
    #export and define the function
    @eval begin
        export $f
        $f(args...; kwargs...) = seaborn.$f(args...; kwargs...)
    end
end

end # module
