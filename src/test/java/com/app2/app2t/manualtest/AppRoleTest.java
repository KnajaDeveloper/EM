package com.app2.app2t.manualtest;

import com.app2.app2t.domain.em.EMEmployee;
import com.app2.app2t.domain.em.EMPosition;
import com.app2.app2t.domain.em.EMTeam;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import static org.hamcrest.core.Is.is;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@Transactional
@ContextConfiguration({"classpath:META-INF/spring/applicationContext*.xml", "file:src/main/webapp/WEB-INF/spring/webmvc-config.xml"})
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class AppRoleTest {
    private Logger LOGGER = LoggerFactory.getLogger(AppRoleTest.class);
    @Autowired
    protected WebApplicationContext wac;
    protected MockMvc mockMvc;
    public void insertDataTodateBase (String teamCode,String teamName,String positionCode,String positionName,String code,String firstName,String lastName,String roleCode)throws Exception{
        EMTeam emTeam = new EMTeam();
        emTeam.setTeamCode(teamCode);
        emTeam.setTeamName(teamName);
        emTeam.persist();

        EMPosition position = new EMPosition();
        position.setPositionCode(positionCode);
        position.setPositionName(positionName);
        position.persist();

        EMEmployee emEmployee = new EMEmployee();
        emEmployee.setEmpCode(code);
        emEmployee.setEmpFirstName(firstName);
        emEmployee.setEmpLastName(lastName);
        emEmployee.setEmTeam(emTeam);
        emEmployee.setEmPosition(position);
        emEmployee.setRoleCode(roleCode);
        emEmployee.persist();
    }
    @Before
    public void setup()throws Exception
    {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
        insertDataTodateBase("T001","Lomanoi","P001","DEV","EMP001","Pote","Burn","RL001");
        insertDataTodateBase("T002","Soft Soft","P002","DEV","EMP002","Jai","Burn",null);
        insertDataTodateBase("T003","Changnoimommam","P003","DEV","EMP003","Mas","Burn","RL002");
        insertDataTodateBase("T004","Finally","P004","DEV","EMP004","Game","Burn",null);
        insertDataTodateBase("T005","YenD","P005","DEV","EMP005","Ahmad","Burn","RL001");
    }
    @After
    public void logger()throws Exception{
        LOGGER.debug("**************************************************************************************************");
    }
    @Test
    public void selectAll ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","")
                .param("empFirstName","")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empCode",is("EMP001")))
                .andExpect(jsonPath("$[1].empCode",is("EMP002")))
                .andExpect(jsonPath("$[2].empCode",is("EMP003")))
                .andExpect(jsonPath("$[3].empCode",is("EMP004")))
                .andExpect(jsonPath("$[4].empCode",is("EMP005")))
                .andReturn()
                ;

    }
    @Test
    public void selectAll_roleIsNull ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","")
                .param("empFirstName","")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","2")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empCode",is("EMP002")))
                .andExpect(jsonPath("$[1].empCode",is("EMP004")))

                .andReturn()
                ;

    }
    @Test
    public void selectAll_roleIsNotNull ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","")
                .param("empFirstName","")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","1")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empCode",is("EMP001")))
                .andExpect(jsonPath("$[1].empCode",is("EMP003")))
                .andExpect(jsonPath("$[2].empCode",is("EMP005")))

                .andReturn()
                ;

    }
    @Test
    public void selectEmpCode ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","EMP001")
                .param("empFirstName","")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empCode",is("EMP001")))
                .andReturn()
                ;

    }
    @Test
    public void selectEmpCode_ ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","EMP")
                .param("empFirstName","")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empCode",is("EMP001")))
                .andExpect(jsonPath("$[1].empCode",is("EMP002")))
                .andExpect(jsonPath("$[2].empCode",is("EMP003")))
                .andExpect(jsonPath("$[3].empCode",is("EMP004")))
                .andReturn()
                ;

    }
    @Test
    public void selectFirstName ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","")
                .param("empFirstName","Pote")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empFirstName",is("Pote")))
                .andReturn()
                ;

    }
    @Test
    public void selectFirstName_ ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","")
                .param("empFirstName","a")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empFirstName",is("Jai")))
                .andExpect(jsonPath("$[1].empFirstName",is("Mas")))
                .andExpect(jsonPath("$[2].empFirstName",is("Game")))
                .andReturn()
                ;

    }
    @Test
    public void selectLastName ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","")
                .param("empFirstName","")
                .param("empLastName","Burn")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empLastName",is("Burn")))
                .andExpect(jsonPath("$[1].empLastName",is("Burn")))
                .andExpect(jsonPath("$[2].empLastName",is("Burn")))
                .andReturn()
                ;

    }
    @Test
    public void selectLastName_ ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","")
                .param("empFirstName","")
                .param("empLastName","u")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empLastName",is("Burn")))
                .andExpect(jsonPath("$[1].empLastName",is("Burn")))
                .andExpect(jsonPath("$[2].empLastName",is("Burn")))
                .andReturn()
                ;

    }
    @Test
    public void selectEmpCode_isEmpty ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","Em")
                .param("empFirstName","")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andReturn()
                ;
        Assert.assertEquals(mvcResult.getResponse().getContentAsString(),"[]");

    }
    @Test
    public void selectEmpFirstName_isEmpty ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","")
                .param("empFirstName","ว")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andReturn()
                ;
        Assert.assertEquals(mvcResult.getResponse().getContentAsString(),"[]");

    }
    @Test
    public void selectEmpLastName_isEmpty ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","")
                .param("empFirstName","")
                .param("empLastName","o")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andReturn()
                ;
        Assert.assertEquals(mvcResult.getResponse().getContentAsString(),"[]");

    }
    @Test
    public void selectEmTeam ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","")
                .param("empFirstName","")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","Lomanoi")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].emTeam.teamName",is("Lomanoi")))
                .andReturn()
                ;

    }
    @Test
    public void selectEmPosition ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","")
                .param("empFirstName","")
                .param("empLastName","")
                .param("emPosition","DEV")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].emPosition.positionName",is("DEV")))
                .andExpect(jsonPath("$[0].empCode",is("EMP001")))
                .andExpect(jsonPath("$[4].emPosition.positionName",is("DEV")))
                .andExpect(jsonPath("$[4].empCode",is("EMP005")))
                .andReturn()
                ;

    }
    @Test
    public void selectEmpCode_FirstName ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","EMP001")
                .param("empFirstName","Pote")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empCode",is("EMP001")))
                .andExpect(jsonPath("$[0].empFirstName",is("Pote")))
                .andReturn()
                ;

    }
    @Test
    public void selectEmpCode_FirstName_LastName ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","EMP001")
                .param("empFirstName","Pote")
                .param("empLastName","Burn")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empCode",is("EMP001")))
                .andExpect(jsonPath("$[0].empFirstName",is("Pote")))
                .andExpect(jsonPath("$[0].empLastName",is("Burn")))
                .andReturn()
                ;

    }
    @Test
    public void selectEmpCode_FirstName_LastName_Team ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","EMP002")
                .param("empFirstName","Jai")
                .param("empLastName","Burn")
                .param("emPosition","")
                .param("emTeam","Soft Soft")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empCode",is("EMP002")))
                .andExpect(jsonPath("$[0].empFirstName",is("Jai")))
                .andExpect(jsonPath("$[0].empLastName",is("Burn")))
                .andExpect(jsonPath("$[0].emTeam.teamName",is("Soft Soft")))
                .andReturn()
                ;

    }
    @Test
    public void selectEmpCode_FirstName_LastName_Team_Position ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","EMP002")
                .param("empFirstName","Jai")
                .param("empLastName","Burn")
                .param("emPosition","DEV")
                .param("emTeam","Soft Soft")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empCode",is("EMP002")))
                .andExpect(jsonPath("$[0].empFirstName",is("Jai")))
                .andExpect(jsonPath("$[0].empLastName",is("Burn")))
                .andExpect(jsonPath("$[0].emTeam.teamName",is("Soft Soft")))
                .andExpect(jsonPath("$[0].emPosition.positionName",is("DEV")))
                .andReturn()
                ;

    }
    @Test
    public void selectEmpCode_FirstName_LastName_Team_Position_addedRole ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","EMP002")
                .param("empFirstName","Jai")
                .param("empLastName","Burn")
                .param("emPosition","DEV")
                .param("emTeam","Soft Soft")
                .param("appRoleHave","2")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].empCode",is("EMP002")))
                .andExpect(jsonPath("$[0].empFirstName",is("Jai")))
                .andExpect(jsonPath("$[0].empLastName",is("Burn")))
                .andExpect(jsonPath("$[0].emTeam.teamName",is("Soft Soft")))
                .andExpect(jsonPath("$[0].emPosition.positionName",is("DEV")))
                .andReturn()
                ;

    }
    @Test
    public void selectEmpCode_FirstName_LastName_Team_Position_addedRole_isEmpty ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findselectDataAddRole")
                .param("empCode","EMP002")
                .param("empFirstName","Jai")
                .param("empLastName","Burn")
                .param("emPosition","DEV")
                .param("emTeam","Soft Soft")
                .param("appRoleHave","1")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andReturn()
                ;
        Assert.assertEquals(mvcResult.getResponse().getContentAsString(),"[]");

    }
    @Test
    public void selectAllPaggingSize ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/addRolePaggingSize")
                .param("empCode","")
                .param("empFirstName","")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$.size",is(5)))
                .andReturn()
                ;

    }
    @Test
    public void selectEmpCodePaggingSize ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/addRolePaggingSize")
                .param("empCode","EMP001")
                .param("empFirstName","")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$.size",is(1)))
                .andReturn()
                ;

    }
    @Test
    public void selectEmpCodeTeamPaggingSize ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/addRolePaggingSize")
                .param("empCode","EMP001")
                .param("empFirstName","")
                .param("empLastName","")
                .param("emPosition","")
                .param("emTeam","YenD")
                .param("appRoleHave","3")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$.size",is(0)))
                .andReturn()
                ;

    }
    @Test
    public void findappRoleAll ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findappRoleName")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].roleCode",is("RL001")))
                .andExpect(jsonPath("$[1].roleCode",is("RL002")))
                .andReturn()
                ;

    }
    @Test
    public void saveOrUpdateAppRoleCode ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(post("/ememployees/saveOrUpdateAppRoleCode")
                .param("arrEmpCode","EMP001")
                .param("arrRoleCode","RL002")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].roleCode",is("RL002")))
                .andReturn()
                ;

    }
}
