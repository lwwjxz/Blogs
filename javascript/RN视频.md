1. https://www.bilibili.com/video/BV1sJ411V77g?p=7     
2. 组件化: 从UI的角度把页面拆分为互不相关的小组件。解耦并方便复用    
3. 模块化: 从js(代码的角度)去分析问题把编程时候的业务逻辑分割到不同的模块中便于复用。   
4. DOM: js表示的UI元素。   
5. 核心代码     
    1. 虚拟dom: dom的渲染是最耗费资源的(最慢的)，所以用js对象模拟dom(就是虚拟dom树)，跟新dom的时候可以用比较新旧虚拟dom然后尽可能少的更新真实的dom。实现真实dom的高效更新。     
    2. diff算法: 
      1. tree diff。     
      2. component diff。     
      3. element diff。     
6. 世界上最好的结果定义语言html。    
6. jsx: 由于页面结构都是非常复杂的如果让用户用js手写，效率会很低而且不直观用户会疯掉(思考成本太大)所以有了更html比较像的jsx。运行时还会转化(编译)为js的。       
7. 使用jsx 必须先安装依赖  `npm i babel-preset-react -D`  .    
8. jsx: 
    1. className 对应html中的 class    
    2. htmlFor 对应html中的 for    
    3. {}可以写任何合法的js    
    4. jsx中必须有且只有一个根标签
    5. 注释要放在{}中，相当于js代码。    
9. 在React中构造函数就是一个基本的组件。   
10. React解析jsx的标签是是安装标签首字母的大小写区分的，如果标签首字母为小写就按照html标签解析，如果为大写安装组件解析。   
11. ```...obj``` ES6中的属性扩散，表示将对象展开放到这个位置。
    ```
    var person = {
    name:'erdan',
    age:5,
    gender:'男'
    }
    
    ...person相当于 name=person.name  age = person.age gender = person.gender
    
    ```
