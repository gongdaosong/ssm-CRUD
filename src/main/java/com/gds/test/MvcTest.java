package com.gds.test;

import com.gds.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @Author 龚道松
 * @Date 2019/7/1 21:23
 * @Wersion 1.0
 *      使用Spring提供的测试请求功能，测试CRUD请求的正确性
 **/

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MvcTest {

    // 传入springMVC的ioc
    @Autowired
    WebApplicationContext context;
    // 虚拟mvc请求，获取处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
         mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    // 测试分页的方法
    @Test
    public void testPage() throws Exception {
        // 模拟请求，拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "3")).andReturn();
        // 请求成功后。请求域中会有pageinfo，取出pageinfo验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageinfo");
        System.out.println("当前页码"+pi.getPageNum());
        System.out.println("总页码"+pi.getPages());
        System.out.println("总记录数"+pi.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int[] nums = pi.getNavigatepageNums();
        for (int i : nums){
            System.out.print(""+i);
        }
        // 获取员工数据
        List<Employee> list = pi.getList();
        for (Employee employee : list){
            System.out.println("ID:"+employee.getdId()+"NAME："+employee.getEmpName()+"");
        }

    }
}
