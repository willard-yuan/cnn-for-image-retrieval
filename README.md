## CNN for Image Retrieval

博文：[Image retrieval using MatconvNet and pre-trained imageNet](http://yongyuan.name/blog/image-retrieval-using-MatconvNet-and-pre-trained-imageNet.html)，对应web演示主页[picSearch](http://yongyuan.name/pic)。

**注意**：其中文件夹matconvnet-1.0-beta17是已经编译好了的，鉴于MatConvNet只能在**Matlab 2014**及其以上以及系统必须是**64位**，所以在使用此工具箱之前得满足这两个条件。如果是Pythoner，推荐使用[flask-keras-cnn-image-retrieval](https://github.com/willard-yuan/flask-keras-cnn-image-retrieval)，纯Python，非常易于写成在线图像搜索应用。

<p align="center">示例：Caltech-256图像数据库</p>
<p align="center"><img src="http://www.vision.caltech.edu/VisionWiki/images/thumb/2/23/Caltech256a_crop.png/537px-Caltech256a_crop.png" alt="caltech256"/></p>
<p align="center">Caltech-256图像数据库上搜索结果</p>
<p align="center"><img src="http://yongyuan.name/images/posts/2015-04-02/airplane-image-retrieval.jpg"  width = 600 alt="search result"/></p>

### 运行步骤

1). 如果不需要计算mAP的话，那就直接把你的图像库文件夹名字命名为`database`，并将图片全部放在放在`database`文件夹下即可。如果你要在后面计算MAP（平均检索精度）的话，要确保图像数据库做成文件夹`databaseClassified`中的形式，然后执行下面命令：

```sh
python movefiles.py
```

2). 接着便可以抽取特征。运行`extractCNN.m`，要用parfor并行的话，直接修改注释部分即可。

3). 检索可视化。这一步运行`queryInDatabaseDemo.m`即可。

4). 计算mAP。不需要计算MAP的这步略过。运行`compute_MAP.m`，关于mAP的计算，请参阅我画的mAP计算过程示意图：[信息检索评价指标](http://yongyuan.name/blog/evaluation-of-information-retrieval.html)，这个计算mAP的脚本是按照那个流程中定义的mAP计算方式来写的。

### 降维

> 非常的amazing, 除了验证降维到128D后损失不减外，惊奇地发现4096D的CNN降维到128D后精度还有提高，一种可能的解释：CNN特征也有一定的信息冗余，信息冗余所带来的影响比降维所带来的损失的影响要更大。结论：You should reduce the dimension of CNN when you use if.

<p align="center">PCA降维对CNN特征的影响</p>
<p align="center"><img src="http://i300.photobucket.com/albums/nn17/willard-yuan/PCA-CNN_zps9gzhmg4q.png"  width = 500 alt="search result"/></p>

上面实验使用的是本项目代码，图像数据集使用的是Caltech101。

关于PCA对PCA降维的影响，[Neural Codes for Image Retrieval](http://arxiv.org/pdf/1404.1777v2.pdf)中也有探讨，以及曾跟Adrian Rosebrock也有过这方面的交流：
>ANN is really fantastic, it makes such much easier. You could also try something like PCA on your 4096-d vector and try to get it down to 128-d. It would save some space and (ideally) not hurt accuracy.

所以，如果采用了CNN特征的话，推荐将其降维到128D。

**2015/12/31更新**：添加对MatConvNet最新版version 1.0-beta17的支持，预训练的模型请到Matconvnet官网下载最新的模型。

**2015/10/20更新**：Web演示部分代码公开[CNN-Web-Demo-for-Image-Retrieval](https://github.com/willard-yuan/CNN-Web-Demo-for-Image-Retrieval)。

**2015/09/24更新**：添加对MatConvNet最新版version 1.0-beta14的支持。

**2015/12/31更新**：添加对[MatConvNet](http://www.vlfeat.org/matconvnet/)最新版version 1.0-beta17的支持，删掉原来的版本(预训练的模型请到matconvnet官网下载最新的模型)。

**2015/06/29更新**：添加对[MatConvNet](http://www.vlfeat.org/matconvnet/)最新版version 1.0-beta12的支持。

## CNN资源列表

### C++

[conv-net-version-3](https://github.com/xingdi-eric-yuan/conv-net-version-3),对应博客[Convolutional Neural Networks III](http://eric-yuan.me/cnn3/)

### Python

[Keras](https://github.com/fchollet/keras)，强力推荐

Keras资源列表：

[DeepLearning tutorial（6）易用的深度学习框架Keras简介](http://blog.csdn.net/u012162613/article/details/45397033)

[DeepLearning tutorial（7）深度学习框架Keras的使用-进阶](http://blog.csdn.net/u012162613/article/details/45581421)

[Keras VGG-16模型 VGG16 model for Keras](https://gist.github.com/baraldilorenzo/07d7802847aaad0a35d3)

[PDNN](https://github.com/yajiemiao/pdnn)，对应主页[PDNN: A Python Toolkit for Deep Learning](http://www.cs.cmu.edu/~ymiao/pdnntk.html)

### Matlab

[GoogLeNet](http://vision.princeton.edu/pvt/GoogLeNet/), A GPU Implementation of GoogLeNet.


