package cn.ohwin.service;

import cn.ohwin.dao.DepartmentMapper;
import cn.ohwin.pojo.Department;
import cn.ohwin.pojo.DepartmentExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getAll() {
        List<Department> list = departmentMapper.selectByExample(new DepartmentExample());
        return list;
    }
}
