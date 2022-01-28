#!/bin/sh

# Bash script to run multiple python codes.
# If needed, use this to change file permissions -> chmod 755 <<script_name.sh>>
# use nohup to run on background.

############ CLONING FROM GITHUB ########
# git clone https://user_name@github.com/MunskyGroup/FISH_Processing.git
# this will as for your token

########### TO CREATE VIR-ENV IN CLUSTER USE #############

############# CLUSTER ####################
# module purge
# module load anaconda3
# module load cuda/10.0/cuda

############# Create env in cluster ###########

############
#source {path_to_anaconda}/anaconda3/etc/profile.d/conda.sh
#conda activate /top/college/academic/ChemE/"$USER"/home/.conda/envs/FISH_processing

#source /top/college/academic/ChemE/"$USER"/home/.conda/envs/FISH_processing/
#python_path=/top/college/academic/ChemE/"$USER"/home/.conda/envs/FISH_processing/bin/python3
#python_path ./simulation_tracking.py 20 40 >> out.txt

# ########### ACTIVATE ENV #############################
# To load the env pass the specific location of the env and then activate it. 
# If not sure about the env location use: source activate <<venv_name>>   echo $CONDA_PREFIX
source /home/luisub/anaconda3/envs/FISH_processing
conda activate FISH_processing

# ########### PROGRAM ARGUMENTS #############################
# If the program requieres positional arguments. 
# Read them in the python file using: sys.argv. This return a list of strings. 
# Where sys.argv[0] is the name of the <<python_file.py>>, and  the rest are in positional order 
# Make sure to convert str to the desired data types.
#folder_complete_path='Test/test_dir'
#folder_complete_path_0='Test/test_dir'
#folder_complete_path_1='Test/test_dir'

#Declare a string array
folders=(\
'Test/test_dir' \
'Test/test_dir' \
) 

#'smFISH_images/Linda_smFISH_images/Confocal/20220114/GAPDH-Cy3_NFKBIA-Cy5_woDex' \
#'smFISH_images/Linda_smFISH_images/Confocal/20220121/GAPDH-Cy3_NFKBIA-Cy5_5min_100nMDex' \
#'smFISH_images/Linda_smFISH_images/Confocal/20220121/GAPDH-Cy3_NFKBIA-Cy5_10min_100nMDex' \
#'smFISH_images/Linda_smFISH_images/Confocal/20220117/GAPDH-Cy3_NFKBIA-Cy5_1h_100nMDex' \
#'smFISH_images/Linda_smFISH_images/Confocal/20220114/GAPDH-Cy3_NFKBIA-Cy5_2h_100nMDex' \
#'smFISH_images/Linda_smFISH_images/Confocal/20220117/GAPDH-Cy3_NFKBIA-Cy5_4h_100nMDex' \

#folder_complete_path_0='smFISH_images/Linda_smFISH_images/Confocal/20220114/GAPDH-Cy3_NFKBIA-Cy5_woDex'
#folder_complete_path_1='smFISH_images/Linda_smFISH_images/Confocal/20220121/GAPDH-Cy3_NFKBIA-Cy5_5min_100nMDex'
#folder_complete_path_2='smFISH_images/Linda_smFISH_images/Confocal/20220121/GAPDH-Cy3_NFKBIA-Cy5_10min_100nMDex'
#folder_complete_path_3='smFISH_images/Linda_smFISH_images/Confocal/20220117/GAPDH-Cy3_NFKBIA-Cy5_1h_100nMDex'
#folder_complete_path_4='smFISH_images/Linda_smFISH_images/Confocal/20220114/GAPDH-Cy3_NFKBIA-Cy5_2h_100nMDex'
#folder_complete_path_5='smFISH_images/Linda_smFISH_images/Confocal/20220117/GAPDH-Cy3_NFKBIA-Cy5_4h_100nMDex'

#folder_complete_path_0='smFISH_images/Linda_smFISH_images/Confocal/20220124/GAPDH-Cy3_NFKBIA-Cy5_30min_100nMDex'
#folder_complete_path_1='smFISH_images/Linda_smFISH_images/Confocal/20220124/GAPDH-Cy3_NFKBIA-Cy5_15min_100nMDex'
#folder_complete_path_2='smFISH_images/Linda_smFISH_images/Confocal/20220121/GAPDH-Cy3_NFKBIA-Cy5_10min_100nMDex'
#folder_complete_path_3='smFISH_images/Linda_smFISH_images/Confocal/20220117/GAPDH-Cy3_NFKBIA-Cy5_1h_100nMDex'
#folder_complete_path_4='smFISH_images/Linda_smFISH_images/Confocal/20220114/GAPDH-Cy3_NFKBIA-Cy5_2h_100nMDex'
#folder_complete_path_5='smFISH_images/Linda_smFISH_images/Confocal/20220117/GAPDH-Cy3_NFKBIA-Cy5_4h_100nMDex'

send_data_to_NAS=0       # If data sent back to NAS use 1.
diamter_nucleus=120      # approximate nucleus size in pixels
diameter_cytosol=220     # approximate cytosol size in pixels
psf_z=350                # Theoretical size of the PSF emitted by a [rna] spot in the z plan, in nanometers.
psf_yx=120               # Theoretical size of the PSF emitted by a [rna] spot in the yx plan, in nanometers.

# Batch script instructions:
# https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script 

# ########### PYTHON PROGRAM #############################

for folder in ${folders[*]}; do
     nohup python3 ./pipeline_executable.py  $folder $send_data_to_NAS $diamter_nucleus $diameter_cytosol $psf_z $psf_yx >> out.txt
     wait
done

#nohup python3 ./pipeline_executable.py  $folder_complete_path_0 $send_data_to_NAS $diamter_nucleus $diameter_cytosol $psf_z $psf_yx >> out.txt
#wait
#nohup python3 ./pipeline_executable.py  $folder_complete_path_1 $send_data_to_NAS $diamter_nucleus $diameter_cytosol $psf_z $psf_yx >> out.txt
#wait
#nohup python3 ./pipeline_executable.py  $folder_complete_path_2 $send_data_to_NAS $diamter_nucleus $diameter_cytosol $psf_z $psf_yx >> out.txt
#wait
#nohup python3 ./pipeline_executable.py  $folder_complete_path_3 $send_data_to_NAS $diamter_nucleus $diameter_cytosol $psf_z $psf_yx >> out.txt
#wait
#nohup python3 ./pipeline_executable.py  $folder_complete_path_4 $send_data_to_NAS $diamter_nucleus $diameter_cytosol $psf_z $psf_yx >> out.txt
#wait
#nohup python3 ./pipeline_executable.py  $folder_complete_path_5 $send_data_to_NAS $diamter_nucleus $diameter_cytosol $psf_z $psf_yx >> out.txt

# ########### TO EXECUTE RUN IN TERMINAL #########################
# run as: source runner.sh &

# TODO LIST
# Create a runner function to test multiple parameters at the same time.
# Improve the plotting. 
# Create a new function to compare multiple and  plot multiple dataframes. 