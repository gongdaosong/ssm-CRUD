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

import javax.validation.Valid;
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
     *
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

    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){

        //引入分页插件pagehelper，传入页码，以及每页显示数据
        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.getAll();
        // f分装了分页信息，包括查询的数据，传入连续显示的页数
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageinfo",pageInfo);

        return "list";
    }
}
