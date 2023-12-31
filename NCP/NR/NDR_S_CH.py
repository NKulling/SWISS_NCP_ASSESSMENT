# coding=UTF-8
# -----------------------------------------------
# Generated by InVEST 3.12.0 on Wed Dec 14 09:17:43 2022
# Model: Nutrient Delivery Ratio

import logging
import sys

import natcap.invest.ndr.ndr
import natcap.invest.utils

LOGGER = logging.getLogger(__name__)
root_logger = logging.getLogger()

handler = logging.StreamHandler(sys.stdout)
formatter = logging.Formatter(
    fmt=natcap.invest.utils.LOG_FMT,
    datefmt='%m/%d/%Y %H:%M:%S ')
handler.setFormatter(formatter)
logging.basicConfig(level=logging.INFO, handlers=[handler])

args = {
    'biophysical_table_path': 'C:\ndr_bptable_ds25.csv',
    'calc_n': True,
    'calc_p': False,
    'dem_path': 'C:\DEM_meanLV95_filled.tif', #DEM filled using the "fill" tool in ArcGis Pro
    'k_param': '2',
    'lulc_path': 'C:\LU-CH_2018.tif',
    'n_workers': '-1',
    'results_suffix': '_v3',
    'runoff_proxy_path': 'C:\ch_bioclim_chclim25_present_pixel_2013_2017_prec.tif',
    'subsurface_critical_length_n': '100',
    'subsurface_eff_n': '0.75',
    'threshold_flow_accumulation': '200',
    'watersheds_path': 'C:\a04_bilanz.shp',
    'workspace_dir': 'C:\invest_outputs\\v3',
}

if __name__ == '__main__':
    natcap.invest.ndr.ndr.execute(args)
