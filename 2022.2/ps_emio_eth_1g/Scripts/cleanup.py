# Python script to cleanup the files leftover from running Vivado and PetaLinux
# Tested on Python 3.8

# Run from <project name>/Scripts directory
# Make sure 'vivado' and 'petalinux-build' have paths defined

import os #interact with operating system
import shutil #high-level operations on files and directories
import glob #match multiple files based on a pattern



#Get path to hardware folder created by Vivado
cwd = os.getcwd()
design_name = os.path.basename(os.path.dirname(cwd))
hardware_folder = design_name + '_hw'
hardware_path = os.path.join('../Hardware/', hardware_folder) # Hardware path from Scripts folder
# print(hardware_path)

#Delete hardware folder
try:
    shutil.rmtree(hardware_path)
    print(hardware_path, 'has been deleted.')
except OSError as e:
    print('Error: %s : %s' % (hardware_path, e.strerror))

#Designate other Vivado output files to be deleted (found in Scripts folder where Vivado is ran from)
vivado_files1 = glob.glob('*.jou')
vivado_files2 = glob.glob('*.log')
vivado_files3 = glob.glob('*.str')
vivado_files = vivado_files1 + vivado_files2 + vivado_files3

#Delete Vivado output files
for x in vivado_files:
    try:
        os.remove(x)
    except OSError as e:
        print('Error: %s : %s' % (hardware_path, e.strerror))
print(vivado_files, 'have been deleted.')

#Change current working directory to PetaLinux directory
print('Changing directory to: ../Software/PetaLinux')
os.chdir('../Software/PetaLinux')

#Run 'petalinux-build -x mrproper' command to clean up the entire PetaLinux project
print('Currently running: petalinux-build -x mrproper')
try:
    os.system('petalinux-build -x mrproper')
    print('Finished running: petalinux-build -x mrproper')
except OSError as e:
    print('PetaLinux build error: %s ' % (e.strerror))
    
#Delete PetaLinux components folder
try:
    shutil.rmtree('./components/')
    print('/PetaLinux/components/ has been deleted.')
except OSError as e:
    print('/PetaLinux/components/ deletion error: %s' % (e.strerror))

#Delete PetaLinux .Xil folder
try:
    shutil.rmtree('./.Xil/')
    print('.Xil has been deleted.')
except OSError as e:
    print('/PetaLinux/.Xil deletion error: %s' % (e.strerror))

#Delete Scripts .Xil folder
try:
    shutil.rmtree('../../Scripts/.Xil/')
    print('.Xil has been deleted.')
except OSError as e:
    print('/Scripts/.Xil deletion error: %s' % (e.strerror))


#Delete usage_statistics and usage_statistics_token
try:
    os.remove('./.petalinux/usage_statistics')
    os.remove('./.petalinux/usage_statistics_token')
    print('Deleted usage statistics files from /PetaLinux/.petalinux/')
except OSError as e:
    print('usage_statistics deletion error: %s' % (e.strerror))

#Delete bit stream and hdf/xsa files in /project-spec/hw-description/
hw_files1 = glob.glob('./project-spec/hw-description/*.bit')
hw_files2 = glob.glob('./project-spec/hw-description/*.hdf')#For 2019.1 and before
hw_files3 = glob.glob('./project-spec/hw-description/*.xsa')#For 2019.2 and after
hw_files = hw_files1 + hw_files2 + hw_files3

for x in hw_files:
    try:
        os.remove(x)
    except OSError as e:
        print('Error deleting /project-spec/hw-description/ hw files: %s : %s' % (hw_files, e.strerror))

#Delete meta-plnx-generated folder
try:
    shutil.rmtree('./project-spec/meta-plnx-generated/')
    print('meta-plnx-generated has been deleted.')
except OSError as e:
    print('meta-plnx-generated deletion error: %s' % (e.strerror))

#Delete python files in /PetaLinux/project-spec
python_files = glob.glob('./project-spec/*.py')

for x in python_files:
    try:
        os.remove(x)
        print('Delete python files in /project-spec/')
    except OSError as e:
        print('Error deleting python files: %s : %s' % (python_files, e.strerror))

#Delete old config files in /project-spec/configs
config_files = glob.glob('./project-spec/configs/*.old')

for x in config_files:
    try:
        os.remove(x)
        print('Deleted old config files from /project-spec/configs')
    except OSError as e:
        print('Error deleting config files: %s : %s' % (config_files, e.strerror))