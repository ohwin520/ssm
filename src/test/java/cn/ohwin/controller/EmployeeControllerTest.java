package cn.ohwin.controller;

import cn.ohwin.pojo.Employee;
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
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(value = {"classpath:applicationContext.xml", "classpath:dispacher-servlet.xml"})
public class EmployeeControllerTest {

    @Autowired
    WebApplicationContext context;

    MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void getEmps() throws Exception {
        // 模拟请求，拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pagenumber", "1")).andReturn();

        PageInfo pageInfo = (PageInfo) result.getRequest().getAttribute("pageInfo");

        System.out.println("当前页码: " + pageInfo.getPageNum());
        System.out.println("总页数: " + pageInfo.getPages());
        System.out.println("总记录数：" + pageInfo.getTotal());
        System.out.print("页面显示的页码：");
        int[] nums = pageInfo.getNavigatepageNums();
        for (Integer num: nums) {
            System.out.print(num + " ");
        }
        System.out.print("\n页面显示的记录：\n");
        List<Employee> employees = pageInfo.getList();

        for ( Employee employee: employees) {
            System.out.println(employee.toString());
        }
    }
}