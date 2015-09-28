# -*- coding: utf-8 -*-
# 用于将不同类别的文件夹下的图片搬到某个文件夹，并在文件前面加上目录名字:
#比如caltech256，里面有256个文件夹，每个文件夹放的都是一类，用movefiles.py可以生成一个database的文件夹，
#这个文件夹把databaseClassified的图片都搬到里面来，并且生成待查询的图片queryImgs.txt和databaseClasses.txt
# python movefiles.py

import os
import fnmatch
import shutil
import random
import math

query_number_percent = 0.5 # 设置每类拿百分之多少出来作为查询

directory = "database"  # 设置新路径
databaseClasses = 'databaseClassified'

if not os.path.exists(directory):
    os.makedirs(directory)

newImgDBPath = os.path.abspath(directory)

# walk through the folder
f = open("./databaseClasses.txt", "w")
g = open("./queryImgs.txt", "w")
for root, dirs, files in os.walk(databaseClasses):
    for i, str_each_folder in enumerate(dirs):
        # we get the directory path
        str_the_path = '/'.join([root, str_each_folder])

        files_number = len((os.listdir(str_the_path))) #子目录下文件数目
        # 生成查询图片实例
        index = random.sample(range(0, files_number), int(math.floor(query_number_percent*files_number)))
        # list all the files using directory path
        for ind, str_each_file in enumerate(os.listdir(str_the_path)):
            # now add the new one
            str_new_name = '{0:03}'.format(i+1) +'_'+ str_each_folder + '_' + str_each_file
            if ind in index:
                g.writelines('%s\n' % str_new_name)
                # full path for both files
            str_old_name = '/'.join([str_the_path, str_each_file])
            str_new_name = '/'.join([newImgDBPath, str_new_name])

            # now rename using the two above strings and the full path to the files
            # os.rename(str_old_name, str_new_name) # 搬运原文件到设置的新目录下
            shutil.copy2(str_old_name, str_new_name)  # 拷贝原文件到设置的新目录下

        #  we can print the folder name so we know that all files in the folder are done
        print '%s, %d images' % (str_each_folder, files_number)
        f.writelines('%s %d\n' % ('{0:03}'.format(i+1)+'_'+str_each_folder, files_number))
g.close
f.close
