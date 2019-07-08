package com.gds.test;

import com.alibaba.druid.support.spring.stat.SpringStatUtils;
import com.gds.bean.Department;
import com.gds.bean.Employee;
import com.gds.dao.DepartmentMapper;
import com.gds.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.naming.Name;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @Author 龚道松
 * @Date 2019/6/30 11:32
 * @Wersion 1.0
 * 推荐使用Spring的项目就可以使用Spring的单元测试，可以自动注入我们的组件
 * 1，导入springTest，模块
 * 2，使用注解@ContextConfiguration指定spring配置文件位置
 * 3，直接autowired要用到的组件即可
 **/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    SqlSession sqlSession;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    DepartmentMapper departmentMapper;
    @Test
    public void testCrud() {
        System.out.println(departmentMapper);
        List<Employee> employees = employeeMapper.selectByExample(null);
        System.out.println(employees);
        // 插入部门
       /* departmentMapper.insert(new Department(null, "开发部"));
        departmentMapper.insert(new Department(null, "测试部"));*/
//        departmentMapper.updateByPrimaryKey(new Department(6, "后勤部"));
//        departmentMapper.updateByPrimaryKey(new Department(7, "前台"));
//        departmentMapper.updateByPrimaryKey(new Department(8, "web"));
      //  departmentMapper.deleteByPrimaryKey(1);
       /*List<Department> list = new ArrayList<>();
        Department select = departmentMapper.selectByPrimaryKey(2);
        Department select1 = departmentMapper.selectByPrimaryKey(3);
        list.add(select);
        list.add(select1);
        System.out.println(list);

        Employee employee = employeeMapper.selectByPrimaryKeyWithDept(1);
        System.out.println(employee);*/

        // 部门插入
    // departmentMapper.insertSelective(new Department(null, "研发部"));
   //     employeeMapper.insertSelective(new Employee(null,"zhangsan","M","123456@qq.com",3));
        // 测试员工插入
    //    employeeMapper.insert(new Employee(null,"李四","m","123456@qq.com",2));

        // 批量插入多个员工，使用可以实现批量操作的sqlsession

        // for循环查就不是一个批量的插入
        /*for (){
            employeeMapper.insert(new Employee(null,"M","123456@qq.com",2));
        }*/
        // 批量插入多个员工，使用可以实现批量操作的sqlsession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i<1000; i++){
            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Employee(null,uid,"F",uid+"@qq.com",2));
        }

    }
}
