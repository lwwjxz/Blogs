1. 每种class的loader如果加载过都会被缓存起到静态变量(静态变量就是全局的)com.alibaba.dubbo.common.extension.ExtensionLoader#EXTENSION_LOADERS
2. 