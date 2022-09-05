#!/bin/bash
######### VASP PATH #################
VASP_PATH=~/vasp-5.4.1/bin
#####################################

######### VASP MODE ##################
## You can use standard version (vasp) or gamma version
VM=vasp_std
######################################
export PATH=${VASP_PATH}:$PATH

source /WORK/app/toolshs/cnmodule.sh
module purge
module load MPI/Intel/MPICH/3.2-icc14-dyn intel-compilers/14.0.2 fftw/3.3.4-default

rm -f loop_lattice_constant.dat
for a in  3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3
do
cat > POSCAR << EOF
fcc Si
$a
 0.5 0.5 0.0
 0.0 0.5 0.5
 0.5 0.0 0.5
1
cartesian
0 0 0
EOF

yhrun -N $SLURM_NNODES -n $SLURM_NTASKS ${VM}
## mpirun -np 2 vasp_std

en=$(awk '/F=/ {print $0}' OSZICAR)
echo $a $en  >> loop_lattice_constant.dat

cat OUTCAR | grep "Total CPU time used"
done
