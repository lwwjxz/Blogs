1. 监听到web容器(tomcat等)启动，加载WebApplicationContext rootContext。
2. web容器(tomcat等)初始化DispatcherServlet，生成一个新的WebApplicationContext其中该容器的父容器为rootContext。
3. 如果一个bean A同时被父子容器加载，当子容器中的bean需要引用A时首先会在本容器中找，找不到才会去父容器中找。
4. 被DispatcherServlet初始化的容器默认会找WEB_INF/*servlet.xml。