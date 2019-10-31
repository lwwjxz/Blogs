支持断点传续          
rsync -avz --bwlimit=3000 zbox omsadmin@10.111.12.119:/data/zbox

猜测是因为支持断点传续的原理是因为是通过比较文件实现的断点传序。        
