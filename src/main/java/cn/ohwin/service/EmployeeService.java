package cn.ohwin.service;

import cn.ohwin.dao.EmployeeMapper;
import cn.ohwin.pojo.Employee;
import cn.ohwin.pojo.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll(){
        EmployeeExample employeeExample = new EmployeeExample();
        employeeExample.setOrderByClause("emp_id");
        List<Employee> emps = employeeMapper.selectByExampleWithDept(employeeExample);
        return emps;
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public void deleteEmpByID(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void changeEmpByID(Employee employee) {
        employeeMapper.updateByPrimaryKey(employee);
    }
}
