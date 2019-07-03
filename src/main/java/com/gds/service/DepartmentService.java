package com.gds.service;

import com.gds.bean.Department;
import com.gds.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author 龚道松
 * @Date 2019/7/2 18:08
 * @Wersion 1.0
 **/
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }

}
