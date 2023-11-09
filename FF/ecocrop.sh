#!/bin/sh
#SBATCH --job-name=ecocrop
#SBATCH --error=ec_error.e%j
#SBATCH --output=ec_out.o%j
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --partition=shared-bigmem
#SBATCH --time=0-12:00:00
#SBATCH --mem-per-cpu=100G 

module load GCC/10.2.0  
module load OpenMPI/4.0.5
module load GDAL/3.2.1
module load PROJ/7.2.1
module load R/4.0.4

srun Rscript  $HOME/ecocrop/code/FF_1.R