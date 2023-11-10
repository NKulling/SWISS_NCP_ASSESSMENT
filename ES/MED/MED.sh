#!/bin/sh
#SBATCH -J medicinal
#SBATCH -e medicinal.e%j
#SBATCH -o medicinal.o%j
#SBATCH -n 1
#SBATCH --cpus-per-task 1
#SBATCH --mem=480000
#SBATCH -p shared-bigmem
#SBATCH -t 02:30:00

module load GCC/10.2.0  
module load OpenMPI/4.0.5
module load GDAL/3.2.1
module load PROJ/7.2.1
module load R/4.0.4

srun Rscript  /MED.R

