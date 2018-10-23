package cn.ohwin.controller;

import cn.ohwin.pojo.Employee;
import cn.ohwin.pojo.Msg;
import cn.ohwin.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping(value = "/emps", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(name = "pagenumber", defaultValue = "1") Integer pageNumber){

        // 使用pageHelper进行分页
        PageHelper.startPage(pageNumber, 12);
        List<Employee> emps = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(emps, 10);
        //model.addAttribute("pageInfo", pageInfo);
        return Msg.success().add("pageInfo", pageInfo);
    }

    @RequestMapping(value = "/emps", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    @RequestMapping(value = "/emps/{empId}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable(name = "empId") Integer id) {
        System.out.println(id);
        employeeService.deleteEmpByID(id);
        return Msg.success();
    }

    @RequestMapping(value = "/emps/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg changeEmpById(@PathVariable(name = "empId") Integer id, Employee employee) {
        employee.setEmpId(id);
        System.out.println(employee);
        employeeService.changeEmpByID(employee);
        return Msg.success();
    }


}
