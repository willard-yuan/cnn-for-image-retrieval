## CNN for Image Retrieval

博文：[Image retrieval using MatconvNet and pre-trained imageNet](http://yongyuan.name/blog/image-retrieval-using-MatconvNet-and-pre-trained-imageNet.html)，对应web演示主页[picSearch](http://search.yongyuan.name/)。web部分会在后面有时间整理了开源。

**2015/06/29更新**：添加对[MatConvNet](http://www.vlfeat.org/matconvnet/)最新版version 1.0-beta12的支持。

**注意**：其中文件夹matconvnet-1.0-beta10是已经编译好了的，所以你在Matlab13下无法编译时，可以使用这个编译了的。

<p align="center"><img src="http://yongyuan.name/images/posts/2015-04-02/airplane-image-retrieval.jpg" alt="precision-recall-64bits"/></p>

### 运行步骤

- 首先你的图像数据库做成文件夹databaseClassified中的形式，以方便后面计算mAP。如果不需要计算mAP的话，那你就直接把你的图像库文件夹名字命名为database,并放在该路径下。

```
python movefiles.py
```

- 接着便可以抽取特征。运行`extractCNN.m`，要用parfor并行的话，直接修改注释部分即可。
- 检索可视化。这一步运行`queryInDatabaseDemo.m`即可。
- 计算mAP。运行`compute_MAP.m`，关于mAP的计算，请参阅我画的mAP计算过程示意图：[信息检索评价指标](http://yongyuan.name/blog/evaluation-of-information-retrieval.html)

**如果你在公开的数据集上测试CNN，可以把你跑的mAP提交上来，避免大家再做重复的测试**

| 方法 | 数据维数 | 模型 | MAP |
|:-----:|:-------:|:-----:|:-----:|
|  |  |  |  |
|  |  |  |  |
|  |  | |  |

## CNN资源列表

### C++

[conv-net-version-3](https://github.com/xingdi-eric-yuan/conv-net-version-3),对应博客[Convolutional Neural Networks III](http://eric-yuan.me/cnn3/)

### Python

[Keras](https://github.com/fchollet/keras)，强力推荐

Keras资源列表：

[DeepLearning tutorial（6）易用的深度学习框架Keras简介](http://blog.csdn.net/u012162613/article/details/45397033)

[DeepLearning tutorial（7）深度学习框架Keras的使用-进阶](http://blog.csdn.net/u012162613/article/details/45581421)

[PDNN](https://github.com/yajiemiao/pdnn)，对应主页[PDNN: A Python Toolkit for Deep Learning](http://www.cs.cmu.edu/~ymiao/pdnntk.html)

### Matlab

[GoogLeNet](http://vision.princeton.edu/pvt/GoogLeNet/), A GPU Implementation of GoogLeNet.


