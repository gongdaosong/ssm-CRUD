package com.gds.controller;

import com.gds.bean.Employee;
import com.gds.bean.Msg;
import com.gds.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.swing.*;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 龚道松
 * @Date 2019/7/1 20:34
 * @Wersion 1.0
 * 处理员工CRUD
 * 添加jackson包
 **/

@Controller
public class EmployeeCotroller {

    @Autowired
    EmployeeService employeeService;


    /**
     * 删除员工信息
     * 单个删除
     * 批量删除
     * @param 。employee
     * @return
     */
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg DeleteEmp(@PathVariable("ids") String ids){

        // 批量删除
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<Integer>();
            String[] str_ids = ids.split("-");
            // 组装id的集合
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else {
        Integer id = Integer.parseInt(ids);
        employeeService.deleteEmp(id);

        }
        return Msg.success();
    }

    /**
     * 更新员工
     * 如果直接发送ajax=PUT请求封装的数据一个都进不来
     * 【empId=1015，empName=null，gender=null，email=null，dId=null】
     *
     * 问题：
     * 请求体中有数据
     * 但是employe对象封装不上
     * update tbl_emp where emp_id = 1015
     *
     * 原因：
     * Tomcat：
     *      1，将请求体中的数据，封装到map中，
     *      2，request.getParameter("empName")就会从map中取值，
     *      3，springMVC封装POJO对象的时候，会把POJO中每个属性的值，request.getParameter("empName")拿到
     *  AJAX发送put请求引起的血案：
     *      put请求，请求体中的数据request.getParameter("empName")拿不到，
     *      Tomcat看是put请求就不会封装请求数据为map，只有post形式的请求才封装请求体为map
     *    解决方案
     *  我们要支持直接发送put请求还要封装请求体中的数据，
     *      1，配置HttpPutFormContentFilter
     *      2，他的作用是将请求体中的数据解析包装成一个map，request被重新包装，
     *      3，request.getParameter()被重写，就会从自己封装的map中取数据
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }
    /**
     *  根据id查询用户
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    // 检查用户名是否可用
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){

        // 后端校验用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9]{6,16}$)|(^[\\u4e00-\\u9fa5]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是6到16位的英文数字组合或2到5位的中文！");
        }
        boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }

    }

    /**
     * 保存员工数据
     * @param employee
     * @return
     * 支持jsr303校验
     * 导入hibernate validator
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){

        if(result.hasErrors()){
            // 校验失败，应该返回失败在模态框中显示失败的信息
            Map<String,Object> map = new HashMap<String, Object>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误信息名字: "+fieldError.getField());
                System.out.println("错误提示信息: "+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    /**
     * 获取员工数据
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn){

        //引入分页插件pagehelper，传入页码，以及每页显示数据
        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.getAll();
        // f分装了分页信息，包括查询的数据，传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageinfo",page);
    }

//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){

        //引入分页插件pagehelper，传入页码，以及每页显示数据
        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.getAll();
        // 封装了分页信息，包括查询的数据，传入连续显示的页数
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageinfo",pageInfo);
        return "list";
    }
}
