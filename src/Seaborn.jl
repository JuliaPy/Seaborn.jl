module Seaborn

using Reexport
using PyCall
import Pandas
@reexport using PyPlot

const seaborn = PyNULL()

function __init__()
    copy!(seaborn, pyimport_conda("seaborn", "seaborn"))
end

println("TESTING!!! REMOVE ME")

#lazy docstring retrieval copied directly from:
#https://github.com/JuliaPy/PyPlot.jl/blob/67305af500a1fef26b9d127e099d110a102900f5/src/PyPlot.jl#L33
struct LazyHelp
    o # a PyObject or similar object supporting getindex with a __doc__ property
    keys::Tuple{Vararg{String}}
    LazyHelp(o) = new(o, ())
    LazyHelp(o, k::AbstractString) = new(o, (k,))
    LazyHelp(o, k1::AbstractString, k2::AbstractString) = new(o, (k1,k2))
    LazyHelp(o, k::Tuple{Vararg{AbstractString}}) = new(o, k)
end
function show(io::IO, ::MIME"text/plain", h::LazyHelp)
    o = h.o
    for k in h.keys
        o = o[k]
    end
    if hasproperty(o, "__doc__")
        print(io, convert(AbstractString, o."__doc__"))
    else
        print(io, "no Python docstring found for ", h.k)
    end
end
Base.show(io::IO, h::LazyHelp) = show(io, "text/plain", h)
function Base.Docs.catdoc(hs::LazyHelp...)
    Base.Docs.Text() do io
        for h in hs
            show(io, MIME"text/plain"(), h)
        end
    end
end

#metaprogram to export and define API functions
# https://seaborn.pydata.org/api.html
for func ∈ (
    :relplot,
    :scatterplot,
    :lineplot,
    :displot,
    :histplot,
    :kdeplot,
    :ecdfplot,
    :rugplot,
    :catplot,
    :stripplot,
    :swarmplot,
    :boxplot,
    :violinplot,
    :boxenplot,
    :pointplot,
    :barplot,
    :countplot,
    :lmplot,
    :regplot,
    :residplot,
    :heatmap,
    :clustermap,
    :FacetGrid,
    :pairplot,
    :PairGrid,
    :jointplot,
    :JointGrid,
    :set_theme,
    :axes_style,
    :set_style,
    :plotting_context,
    :set_context,
    :set_color_codes,
    :reset_defaults,
    :reset_orig,
    :set_palette,
    :color_palette,
    :husl_palette,
    :hls_palette,
    :cubehelix_palette,
    :dark_palette,
    :light_palette,
    :diverging_palette,
    :blend_palette,
    :xkcd_palette,
    :crayon_palette,
    :mpl_palette,
    :choose_colorbrewer_palette,
    :choose_cubehelix_palette,
    :choose_light_palette,
    :choose_dark_palette,
    :choose_diverging_palette,
    :despine,
    :move_legend,
    :saturate,
    :desaturate,
    :set_hls_values,
    :get_dataset_names,
    :get_data_home
)
    s = string(func)
    #export and define the function
    @eval begin
        export $func
        @doc LazyHelp(seaborn, $s) function $func(args...; kwargs...)
            seaborn.$func(args...; kwargs...)
        end
    end
end

#return a Pandas.DataFrame instead of PyCall.PyObject
export load_dataset
@doc LazyHelp(seaborn, "load_dataset") function load_dataset(args...; kwargs...)
    seaborn.load_dataset(args...; kwargs...) |> Pandas.DataFrame
end

end # module
