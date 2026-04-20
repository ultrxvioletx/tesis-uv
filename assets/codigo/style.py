import matplotlib.pyplot as plt

latex = {
    "rabip": "\\Omega_p t",
    "rabic": "\\Omega_c t",
    "scan": "\\delta_p / \\kappa",
    "Dpa": "\\Delta_p / \\kappa",
    "Oee": "\\Omega_{EE} / \\kappa",
    "P": "P_",
    "Nt": "\\langle N \\rangle",
    "Nss": "\\langle N \\rangle _{ss}"
}

colores = {
    "estados": ["#f4afb4", "#c9b7ad", "#94a89a"], #rosa, beige, verde
    "fotones": "#9490A2" #lila
}

markers = ['s', '^', 'o']

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

def format_ax(ax, xstep=2, ystep=2, ymax=None, ymin=0, xlim=None, show_xlabels=True, show_ylabels=True):
    if xlim is not None:
        ax.set_xlim(xlim[0], xlim[1])
    if ymax is not None:
        ax.set_ylim(ymin, ymax)
    ax.xaxis.set_major_locator(plt.MultipleLocator(xstep))
    ax.yaxis.set_major_locator(plt.MultipleLocator(ystep))
    ax.xaxis.set_minor_locator(plt.MultipleLocator(xstep / 2))
    ax.yaxis.set_minor_locator(plt.MultipleLocator(ystep / 2))
    ax.yaxis.set_major_formatter(plt.ScalarFormatter() if show_ylabels else plt.NullFormatter())
    ax.yaxis.set_minor_formatter(plt.NullFormatter())
    ax.xaxis.set_major_formatter(plt.ScalarFormatter() if show_xlabels else plt.NullFormatter())

def segmento(ax, x1, x2, y, h=0.05):
    color="gray"
    lw=1
    y = y+h
    bar_h = y*0.02
    distancia = x2 - x1

    ax.plot([x1, x2], [y, y], color=color, linewidth=lw)
    ax.plot([x1, x1], [y - bar_h, y + bar_h], color=color, lw=lw)
    ax.plot([x2, x2], [y - bar_h, y + bar_h], color=color, lw=lw)
    ax.text((x1 + x2) / 2, y + bar_h, fr"{distancia:.2f}", ha="center", va="bottom", fontsize=10)