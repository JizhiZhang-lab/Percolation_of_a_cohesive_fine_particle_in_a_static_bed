#!/bin/bash
#SBATCH --account=p32530  ## YOUR ACCOUNT pXXXX or bXXXX
#SBATCH --partition=normal  ### PARTITION (buyin, short, normal, etc)
#SBATCH --nodes=1 ## how many computers do you need
#SBATCH --ntasks-per-node=1 ## how many cpus or processors do you need on each computer
#SBATCH --time=24:00:00 ##how long does this need to run (remember different partitions have restrictions on this param)
#SBATCH --job-name=percolation  ## When you run squeue -u NETID this is how you can identify the job
#SBATCH --output=outlog ## standard out and standard error goes to this file## SBATCH --mail-type=ALL ## you can receive e-mail alerts from SLURM when your job begins and when your job finishes (completed, failed, etc)
## SBATCH --mail-user=jizhizhang2029@u.northwestern.edu ## your email

module purge all
module load  mpi/openmpi-4.1.4-gcc-11.2.0
module load  gcc/11.2.0

l="/projects/p32530/LAMMPS/lmp_VV_damping -in"
$l case.lammps