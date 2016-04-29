package com.app2.app2t.manualtest;

import com.app2.app2t.domain.em.EMTeam;
import com.app2.app2t.util.AuthorizeUtil;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@Transactional
@ContextConfiguration({"classpath:META-INF/spring/applicationContext*.xml", "file:src/main/webapp/WEB-INF/spring/webmvc-config.xml"})
public class EmTeamTest {
    private Logger LOGGER = LoggerFactory.getLogger(EmTeamTest.class);

    @Autowired
    protected WebApplicationContext wac;

    protected MockMvc mockMvc;
    public void insertDataTodateBase (String code,String name)throws Exception{

        EMTeam emTeam = new EMTeam();
        emTeam.setTeamCode(code);
        emTeam.setTeamName(name);
        emTeam.persist();

    }
    @Before
    public void setup()throws Exception
    {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
        AuthorizeUtil.setUserName("admin");
        insertDataTodateBase("T001","Lomanoi");
        insertDataTodateBase("T002","Soft Soft");
        insertDataTodateBase("T003","Changnoimommam");
        insertDataTodateBase("T004","Finally");
        insertDataTodateBase("T005","YenD");
    }
    @After
    public void logger()throws Exception{
        LOGGER.debug("**************************************************************************************************");
    }

    @Test
    public void selectAll ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/findProjectBytypeTeamCode")
                .param("searchCode","")
                .param("searchName","")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].teamCode",is("T001")))
                .andExpect(jsonPath("$[1].teamCode",is("T002")))
                .andExpect(jsonPath("$[2].teamCode",is("T003")))
                .andReturn()
                ;

    }
    @Test
    public void selectTeamCode ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/findProjectBytypeTeamCode")
                .param("searchCode","T001")
                .param("searchName","")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].teamCode",is("T001")))
                .andExpect(jsonPath("$[0].inUse",is("0")))
                .andReturn()
                ;

    }
    @Test
    public void selectTeamName ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/findProjectBytypeTeamCode")
                .param("searchCode","")
                .param("searchName","Lomanoi")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].teamName",is("Lomanoi")))
                .andExpect(jsonPath("$[0].inUse",is("0")))
                .andReturn()
                ;

    }
    @Test
    public void selectTeamName_ ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/findProjectBytypeTeamCode")
                .param("searchCode","")
                .param("searchName","L")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].teamName",is("Lomanoi")))
                .andExpect(jsonPath("$[0].inUse",is("0")))
                .andReturn()
                ;

    }
    @Test
    public void selectTeamCode_ ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/findProjectBytypeTeamCode")
                .param("searchCode","T")
                .param("searchName","")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].teamCode",is("T001")))
                .andExpect(jsonPath("$[1].teamCode",is("T002")))
                .andExpect(jsonPath("$[2].teamCode",is("T003")))
                .andReturn()
                ;

    }
    @Test
    public void selectTeamCode_isEmpty ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/findProjectBytypeTeamCode")
                .param("searchCode","X")
                .param("searchName","")
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
    public void selectTeamName_isEmpty ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/findProjectBytypeTeamCode")
                .param("searchCode","")
                .param("searchName","X")
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
    public void selectTeamName_TeamCode ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/findProjectBytypeTeamCode")
                .param("searchCode","T")
                .param("searchName","L")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].teamCode",is("T001")))
                .andExpect(jsonPath("$[0].teamName",is("Lomanoi")))
                .andReturn()
                ;

    }
    @Test
    public void selectTeamNameTeamCode ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/findProjectBytypeTeamCode")
                .param("searchCode","T002")
                .param("searchName","Soft Soft")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].teamCode",is("T002")))
                .andExpect(jsonPath("$[0].teamName",is("Soft Soft")))
                .andReturn()
                ;

    }
    ////////////
    @Test
    public void selectAllpaggingSize ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/teamPaggingSize")
                .param("searchCode","")
                .param("searchName","")
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
    public void selectTeamNameTeamCodepaggingSize ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/teamPaggingSize")
                .param("searchCode","T002")
                .param("searchName","Soft Soft")
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
    public void selectTeamCodepaggingSize ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/teamPaggingSize")
                .param("searchCode","T001")
                .param("searchName","")
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
    public void selectTeamCode_paggingSize ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/teamPaggingSize")
                .param("searchCode","T")
                .param("searchName","")
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
    public void selectTeamName_paggingSize ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/teamPaggingSize")
                .param("searchCode","")
                .param("searchName","Ch")
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
    public void selectTeamName_paggingSizeIsEmpty ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/teamPaggingSize")
                .param("searchCode","")
                .param("searchName","X")
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
    public void selectTeamCode_paggingSizeIsEmpty ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/teamPaggingSize")
                .param("searchCode","X")
                .param("searchName","")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$.size",is(0)))
                .andReturn()
                ;

    }
    ///////////////////
    @Test
    public void deleteTeam ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/deleteTeam")
                .param("deleteCode","T001")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andReturn()
                ;
        this.mockMvc.perform(get("/emteams/findProjectBytypeTeamCode")
                .param("searchCode","T001")
                .param("searchName","")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andReturn()
                ;
        Assert.assertEquals(mvcResult.getResponse().getContentAsString(),"[]");
    }
    //////////////////
    @Test
    public void editTeam ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/editTeam")
                .param("editCode","T005")
                .param("editName","YennoyCpe")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andReturn()
                ;
        this.mockMvc.perform(get("/emteams/findProjectBytypeTeamCode")
                .param("searchCode","T005")
                .param("searchName","")
                .param("maxResult","15")
                .param("firstResult","0")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andExpect(jsonPath("$[0].teamName",is("YennoyCpe")))
                .andReturn()
        ;
    }
    //////////////////
    @Test
    public void checkUse ()throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/emteams/findCheck")
                .param("teamCode","T005")
        ).andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json;charset=UTF-8"))
                .andReturn()
                ;
        Assert.assertNotEquals(mvcResult.getResponse().getContentAsString(),"[]");
    }
}
