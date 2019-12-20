[paper](https://static.googleusercontent.com/media/research.google.com/zh-CN//archive/mapreduce-osdi04.pdf)         
1. 处理大数据的编程模型。        
2. 大多数据需要处理的问题是简单直接的，但是计算分布在成百上千完成合理的时间。如何并行计算、分布数据和处理失败会使原始的简单计算变得模糊，需要处理大量复杂的代码处理这些问题。    
3. ![](https://github.com/lwwjxz/Blogs/blob/master/image/2B407098-918E-4F84-9528-E7869102E24A%7D_20191220135429.jpg)      
4. map把原始key/value转化为中间key/value。reduce把中间key/value归纳为最终的结果。       
