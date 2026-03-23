import matplotlib.pyplot as plt

#colores = ["#8AAA79", "#b8b8f3", "#d47777", "#545e75", "#443742"] # opcion descartada pero la dejo por si acaso
#colores = ["#83a598", "#D58E8E", "#9ccfd8", "#b8b8f3", "#5980a5"] # opcion descartada pero la dejo por si acaso
#colores = ["#f4afb4", "#c9b7ad", "#9490A2", "#94a89a", "#797d81"]
cmap = plt.get_cmap('Pastel1')
colores = {
    "estados_t": [cmap(2), cmap(3), cmap(4)], #rosita, gris, menta
    "fotones_t": "#94a89a", #verde
    "estados_ss": ["#f4afb4", "#c9b7ad"], #rosa, beige
    "fotones_ss": "#9490A2" #lila
}

def set_style():
    plt.rcParams.update({
        "text.usetex": True,
        # fuente iwona
        "text.latex.preamble": r"\usepackage[math]{iwona}",
        
        # tamaños de fuente
        "font.size": 12,
        "axes.labelsize": 14, # etiquetas x,y
        "axes.titlesize": 14, # título
        "legend.fontsize": 11,
        "xtick.labelsize": 11,
        "ytick.labelsize": 11,
        
        # ejes (ticks hacia adentro, en todos los bordes)
        "xtick.direction": "out",
        "ytick.direction": "out",
        "xtick.major.size": 8,   # largo de ticks principales
        "ytick.major.size": 8,
        "xtick.minor.size": 6,   # largo de ticks menores
        "ytick.minor.size": 6,
        "xtick.major.width": 1,  # grosor
        "ytick.major.width": 1,
        "xtick.top": False,
        "ytick.right": False,
        "axes.linewidth": 1.2, # grosor del recuadro
        
        # líneas de las gráficas
        "lines.linewidth": 2.0,
        "lines.markersize": 6,
        
        # cuadrícula
        "grid.alpha": 0.4,
        "grid.linestyle": "--",
        
        # resolución para guardar
        "savefig.dpi": 300,
        "figure.figsize": (6, 4),
        "savefig.bbox": "tight",
    })

def format_ax(ax, xstep=2, ystep=2, ymax=None, xlim=None):
    if xlim is not None:
        xmin,xmax = xlim[0],xlim[1]
        ax.set_xlim(xmin, xmax)
    if ymax is not None:
        ax.set_ylim(0, ymax)
    ax.xaxis.set_major_locator(plt.MultipleLocator(xstep))
    ax.yaxis.set_major_locator(plt.MultipleLocator(ystep))
    ax.xaxis.set_minor_locator(plt.MultipleLocator(xstep / 2))
    ax.yaxis.set_minor_locator(plt.MultipleLocator(ystep / 2))
    ax.yaxis.set_major_formatter(plt.ScalarFormatter())
    ax.yaxis.set_minor_formatter(plt.ScalarFormatter())