package cn.ohwin.dao;

import cn.ohwin.pojo.Employee;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class EmployeeMapperTest {

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    @Test
    public void countByExample() {
    }

    @Test
    public void deleteByExample() {
    }

    @Test
    public void deleteByPrimaryKey() {
    }

    @Test
    public void insert() {

    }

    @Test
    public void insertSelective() {
        System.out.println(employeeMapper);
//        employeeMapper.insertSelective(new Employee(null, "ohwin", "F", "ohwin520@gmail.com", 1, null));
//        employeeMapper.insertSelective(new Employee(null, "jerry", "M", "jerry@gmail.com", 2, null));
        EmployeeMapper mapper = sqlSessionTemplate.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 100; i++) {
            String uuid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uuid, "M", uuid + "@gmail.com", 2, null));
        }
    }

    @Test
    public void selectByExample() {
    }

    @Test
    public void selectByPrimaryKey() {
    }

    @Test
    public void selectByExampleWithDept() {

    }

    @Test
    public void selectByPrimaryKeyWithDept() {
    }

    @Test
    public void updateByExampleSelective() {
    }

    @Test
    public void updateByExample() {
    }

    @Test
    public void updateByPrimaryKeySelective() {

    }

    @Test
    public void updateByPrimaryKey() {
    }
}