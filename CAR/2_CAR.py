# coding=UTF-8
# -----------------------------------------------
#
# Model: InVEST Carbon Model
# Python version : 3.8 


#import modules

import natcap.invest.carbon, os, string # Requires to have all natcap.invest dependencies installed (e.g. GDAL, rtree, numpy, etc). Cannot run on python 2!

#------ Define paths to variables

#Path to a folder containing biophysical tables for each region+altitude
bp_tables_folder = r'C:\CAR\BPTABLE'
#Path to a folder containing LULC rasters for each region 
lu_folder = r'C:\CAR\scratch\lulc_clip\18'
#Path to output folder containing each InVEST model
output_folder = r'C:\CAR\scratch\Invest_models'

# Process: browsing through folders and defining names

listdir = os.listdir(bp_tables_folder)
list_names = []

print("List of regions:")

for i in range(0,len(listdir)):
    name = listdir[i]
    name = name[:-4]
    list_names.append(name)
    print (name)

# Process: Individually running InVEST Carbon model on each raster map from "lu_folder"

for i in range(0, len(list_names)):
    bptable= bp_tables_folder + "\\" + list_names[i] + ".csv"
    lu = lu_folder + "\\" + list_names[i] + ".tif"
    out = output_folder + "\\" + list_names[i]
    tag = list_names[i]

    args = {
    'calc_sequestration': False,
    'carbon_pools_path': bptable,
    'do_redd': False,
    'do_valuation': False,
    'lulc_cur_path': lu,
    'results_suffix': tag,
    'workspace_dir': out,
    }

    if __name__ == '__main__':
        natcap.invest.carbon.execute(args)
    print("InVEST model " + tag + " :done")

print(".........................................")
print("script 2, year 2018 done!")






