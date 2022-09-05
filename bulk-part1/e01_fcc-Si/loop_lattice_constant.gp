
set term png
set output "loop_lattice_constant.png"

set title "lattice constant of fcc Si"
set xlabel "lattice constant [Angstrom]"
set ylabel "total free energy"

plot "loop_lattice_constant.dat" using 1:4 w lp

