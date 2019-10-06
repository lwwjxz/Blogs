1. [参考](https://blog.csdn.net/aitangyong/article/details/50629525)    
    1. id name alias都是单例实例的标识符，id 和 name有优先级 如果id和name都没有设置则默认id为类的全名，如果id设置了name没有设置则id为设置的值，
如果id设置了name也设置了则id为id设置的值，name设置的值为别名。如果id没有设置name设置了则第一个name为id其他name为别名。alias也可以单独设置。
    2. id name alias都必须全局唯一
1. spring解析bean的时候id和name是一回事。     
    
    ```
    org.springframework.beans.factory.xml.BeanDefinitionParserDelegate#parseBeanDefinitionElement(org.w3c.dom.Element, org.springframework.beans.factory.config.BeanDefinition){
        String id = ele.getAttribute(ID_ATTRIBUTE);
		···

		String beanName = id;
    
    }
    ```
    
