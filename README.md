# SSM小书城整合，新手框架整合练习

[![license](https://badgen.net/github/license/laowenruo/SSM-library?color=green)](https://github.com/laowenruo/SSM-library/blob/main/LICENSE)
[![stars](https://badgen.net/github/stars/laowenruo/SSM-library)](https://github.com/laowenruo/SSM-library/stargazers)
[![contributors](https://badgen.net/github/contributors/laowenruo/SSM-library)](https://github.com/laowenruo/SSM-library/graphs/contributors)
[![help-wanted](https://badgen.net/github/label-issues/laowenruo/SSM-library/help%20wanted/open)](https://github.com/laowenruo/SSM-library/labels/help%20wanted)
[![issues](https://badgen.net/github/open-issues/laowenruo/SSM-library)](https://github.com/laowenruo/SSM-library/issues)
[![PRs Welcome](https://badgen.net/badge/PRs/welcome/green)](http://makeapullrequest.com)

本项目主要用于用于新手刚入门Spring，Mybatis,SpringMVC框架后，需要小练手整合一下，熟悉完框架之后，还是可以深入学习一下或者学下Springboot等内容(如果本项目对您有帮助，请 watch、star、fork 素质三连一波，鼓励一下作者，谢谢）

## 数据库环境

- 创建一个存放书籍数据的数据库表
- 文件为数据库.sql

## 基本环境搭建

- 新建一Maven项目！ 添加web的支持
- 导入相关的pom依赖！
- 文件为pom.xml
- 文件为Maven资源过滤设置,静态资源导出问题

<build>
   <resources>
       <resource>
           <directory>src/main/java</directory>
           <includes>
               <include>**/*.properties</include>
               <include>**/*.xml</include>
           </includes>
           <filtering>false</filtering>
       </resource>
       <resource>
           <directory>src/main/resources</directory>
           <includes>
               <include>**/*.properties</include>
               <include>**/*.xml</include>
           </includes>
           <filtering>false</filtering>
       </resource>
   </resources>
</build>

- 建立基本结构和配置框架！

  ![](\项目结构.png)

## Mybatis层编写

- 数据库配置文件 database.properties

  ```
  jdbc.driver=com.mysql.jdbc.Driver
  # &serverTimezone=Asia/Shanghai
  jdbc.url=jdbc:mysql://localhost:3306/ssmbuild?useSSL=true&useUnicode=true&characterEncoding=utf8
  jdbc.username=root
  jdbc.password=123456
  ```

- 编写MyBatis的核心配置文件  mybatis-config.xml

  ```
  <?xml version="1.0" encoding="UTF-8" ?>
  <!DOCTYPE configuration
         PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
         "http://mybatis.org/dtd/mybatis-3-config.dtd">
  <configuration>
  
     <typeAliases>
         <package name="com.kuang.pojo"/>
     </typeAliases>
     <mappers>
         <mapper resource="com/kuang/dao/BookMapper.xml"/>
     </mappers>
  
  </configuration>
  ```

- 编写数据库对应的实体类 com.pojo.Books，可使用lombok插件！

- 编写Dao层的 Mapper接口！

- 编写接口对应的 Mapper.xml 文件。需要导入MyBatis的包；

- 编写Service层的接口和实现类

## Spring层

- 配置Spring整合MyBatis，我们这里数据源使用c3p0连接池；

- 我们去编写Spring整合Mybatis的相关的配置文件；spring-dao.xml

- ```
  <?xml version="1.0" encoding="UTF-8"?>
  <beans xmlns="http://www.springframework.org/schema/beans"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:context="http://www.springframework.org/schema/context"
        xsi:schemaLocation="http://www.springframework.org/schema/beans
         http://www.springframework.org/schema/beans/spring-beans.xsd
         http://www.springframework.org/schema/context
         https://www.springframework.org/schema/context/spring-context.xsd">
  
     <!-- 配置整合mybatis -->
     <!-- 1.关联数据库文件 -->
     <context:property-placeholder location="classpath:database.properties"/>
  
     <!-- 2.数据库连接池 -->
     <!--数据库连接池
         dbcp 半自动化操作 不能自动连接
         c3p0 自动化操作（自动的加载配置文件 并且设置到对象里面）
     -->
     <bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
         <!-- 配置连接池属性 -->
         <property name="driverClass" value="${jdbc.driver}"/>
         <property name="jdbcUrl" value="${jdbc.url}"/>
         <property name="user" value="${jdbc.username}"/>
         <property name="password" value="${jdbc.password}"/>
  
         <!-- c3p0连接池的私有属性 -->
         <property name="maxPoolSize" value="30"/>
         <property name="minPoolSize" value="10"/>
         <!-- 关闭连接后不自动commit -->
         <property name="autoCommitOnClose" value="false"/>
         <!-- 获取连接超时时间 -->
         <property name="checkoutTimeout" value="10000"/>
         <!-- 当获取连接失败重试次数 -->
         <property name="acquireRetryAttempts" value="2"/>
     </bean>
  
     <!-- 3.配置SqlSessionFactory对象 -->
     <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
         <!-- 注入数据库连接池 -->
         <property name="dataSource" ref="dataSource"/>
         <!-- 配置MyBaties全局配置文件:mybatis-config.xml -->
         <property name="configLocation" value="classpath:mybatis-config.xml"/>
     </bean>
  
     <!-- 4.配置扫描Dao接口包，动态实现Dao接口注入到spring容器中 -->
     <!--解释 ：https://www.cnblogs.com/jpfss/p/7799806.html-->
     <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
         <!-- 注入sqlSessionFactory -->
         <property name="sqlSessionFactoryBeanName" value="sqlSessionFactory"/>
         <!-- 给出需要扫描Dao接口包 -->
         <property name="basePackage" value="com.kuang.dao"/>
     </bean>
  
  </beans>
  ```

- Spring整合service层，Spring-service.xml文件编写

  ```
  <?xml version="1.0" encoding="UTF-8"?>
  <beans xmlns="http://www.springframework.org/schema/beans"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:context="http://www.springframework.org/schema/context"
        xsi:schemaLocation="http://www.springframework.org/schema/beans
     http://www.springframework.org/schema/beans/spring-beans.xsd
     http://www.springframework.org/schema/context
     http://www.springframework.org/schema/context/spring-context.xsd">
  
     <!-- 扫描service相关的bean -->
     <context:component-scan base-package="com.service" />
  
     <!--BookServiceImpl注入到IOC容器中-->
     <bean id="BookServiceImpl" class="com.service.BookServiceImpl">
         <property name="bookMapper" ref="bookMapper"/>
     </bean>
  
     <!-- 配置事务管理器 -->
     <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
         <!-- 注入数据库连接池 -->
         <property name="dataSource" ref="dataSource" />
     </bean>
  
  </beans>
  ```

## SpringMVC层

- web.xml编写

  ```
  <?xml version="1.0" encoding="UTF-8"?>
  <web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
          version="4.0">
  
     <!--DispatcherServlet-->
     <servlet>
         <servlet-name>DispatcherServlet</servlet-name>
         <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
         <init-param>
             <param-name>contextConfigLocation</param-name>
             <!--一定要注意:我们这里加载的是总的配置文件，之前被这里坑了！-->
             <param-value>classpath:applicationContext.xml</param-value>
         </init-param>
         <load-on-startup>1</load-on-startup>
     </servlet>
     <servlet-mapping>
         <servlet-name>DispatcherServlet</servlet-name>
         <url-pattern>/</url-pattern>
     </servlet-mapping>
  
     <!--encodingFilter-->
     <filter>
         <filter-name>encodingFilter</filter-name>
         <filter-class>
            org.springframework.web.filter.CharacterEncodingFilter
         </filter-class>
         <init-param>
             <param-name>encoding</param-name>
             <param-value>utf-8</param-value>
         </init-param>
     </filter>
     <filter-mapping>
         <filter-name>encodingFilter</filter-name>
         <url-pattern>/*</url-pattern>
     </filter-mapping>
  
     <!--Session过期时间-->
     <session-config>
         <session-timeout>15</session-timeout>
     </session-config>
  
  </web-app>
  ```

  

- spring-mvc.xml编写

  ```
  <?xml version="1.0" encoding="UTF-8"?>
  <beans xmlns="http://www.springframework.org/schema/beans"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:context="http://www.springframework.org/schema/context"
        xmlns:mvc="http://www.springframework.org/schema/mvc"
        xsi:schemaLocation="http://www.springframework.org/schema/beans
     http://www.springframework.org/schema/beans/spring-beans.xsd
     http://www.springframework.org/schema/context
     http://www.springframework.org/schema/context/spring-context.xsd
     http://www.springframework.org/schema/mvc
     https://www.springframework.org/schema/mvc/spring-mvc.xsd">
  
     <!-- 配置SpringMVC -->
     <!-- 1.开启SpringMVC注解驱动 -->
     <mvc:annotation-driven />
     <!-- 2.静态资源默认servlet配置-->
     <mvc:default-servlet-handler/>
  
     <!-- 3.配置jsp 显示ViewResolver视图解析器 -->
     <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
         <property name="viewClass" value="org.springframework.web.servlet.view.JstlView" />
         <property name="prefix" value="/WEB-INF/jsp/" />
         <property name="suffix" value=".jsp" />
     </bean>
  
     <!-- 4.扫描web相关的bean -->
     <context:component-scan base-package="com.kuang.controller" />
  
  </beans>
  ```

  

### 最后的最后，大整合

- applicationContext.xml

  ```
  <?xml version="1.0" encoding="UTF-8"?>
  <beans xmlns="http://www.springframework.org/schema/beans"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.springframework.org/schema/beans
         http://www.springframework.org/schema/beans/spring-beans.xsd">
  
     <import resource="spring-dao.xml"/>
     <import resource="spring-service.xml"/>
     <import resource="spring-mvc.xml"/>
  
  </beans>
  
  ```

  

### 接下来就是自由的编写Controller以及视图层了，这里就不写了

- 本项目主要是基于狂神说的SpringMVC整合书城项目编写，额外的就是试了下PageHelper的插件，实现了分页
