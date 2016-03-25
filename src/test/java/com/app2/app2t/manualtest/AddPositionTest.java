package com.app2.app2t.manualtest;

import com.app2.app2t.domain.em.EMPosition;
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

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.*;
import org.springframework.expression.spel.ast.Projection;
import org.springframework.test.annotation.DirtiesContext;
import javax.persistence.EntityManager;

import java.text.SimpleDateFormat;
import java.util.*;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@Transactional
@ContextConfiguration({"classpath:META-INF/spring/applicationContext*.xml", "file:src/main/webapp/WEB-INF/spring/webmvc-config.xml"})
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
public class AddPositionTest {

    private Logger LOGGER = LoggerFactory.getLogger(AddPositionTest.class);
    @Autowired
    protected WebApplicationContext wac;

    protected MockMvc mockMvc;

    @Before
    public void setup()throws Exception{
        this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
        insertDataTodateBase("P001", "Software Developer Trainee");
        insertDataTodateBase("P002", "Business Analysis");
        insertDataTodateBase("P003", "Software Developer");
        insertDataTodateBase("P004", "Project Manager");
    }

    public void insertDataTodateBase (String positionCode, String positionName)throws Exception{
        EMPosition emPosition = new EMPosition();
        emPosition.setPositionCode(positionCode);
        emPosition.setPositionName(positionName);
        emPosition.persist();
    }

    public void editDataTodateBase (String positionCode, String positionName)throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/empositions/findeditEMPosition")
            .param("positionCode", positionCode)
            .param("positionName", positionName)
        ).andDo(print())
            .andExpect(status().isOk())
            .andExpect(content().contentType("application/json;charset=UTF-8"))
            .andReturn();
    }

    public void deleteDataTodateBase (String positionID)throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/empositions/findDeletePosition")
            .param("positionID", positionID)
        ).andDo(print())
            .andExpect(status().isOk())
            .andExpect(content().contentType("application/json;charset=UTF-8"))
            .andReturn();
    }

    public void dateTestFindPaggingData (String json, String dataJson, String positionCode, String positionName)throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/empositions/findPaggingData")
            .param("positionCode", positionCode)
            .param("positionName", positionName)
            .param("firstResult","0")
            .param("maxResult","15")
        ).andDo(print())
            .andExpect(status().isOk())
            .andExpect(content().contentType("application/json;charset=UTF-8"))
            .andExpect(jsonPath(json, is(dataJson)))
            .andReturn();
    }

    public void dateTestFindPaggingSize (String json, int dataJson, String positionCode, String positionName)throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/empositions/findPaggingSize")
            .param("positionCode", positionCode)
            .param("positionName", positionName)
        ).andDo(print())
            .andExpect(status().isOk())
            .andExpect(content().contentType("application/json;charset=UTF-8"))
            .andExpect(jsonPath(json, is(dataJson)))
            .andReturn();
    }

    public void dateTestIsEmpty (String json, String dataJson, String positionCode, String positionName)throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/empositions/findPaggingData")
            .param("positionCode", positionCode)
            .param("positionName", positionName)
            .param("firstResult","0")
            .param("maxResult","15")
        ).andDo(print())
            .andExpect(status().isOk())
            .andExpect(content().contentType("application/json;charset=UTF-8"))
            .andReturn();

            assertEquals(mvcResult.getResponse().getContentAsString(), dataJson);
    }

    public void dateTestFindCheckPositionCode (String positionCode)throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/empositions/findCheckPositionCode")
            .param("positionCode", positionCode)
        ).andDo(print())
            .andExpect(status().isOk())
            .andExpect(content().contentType("application/json;charset=UTF-8"))
            .andReturn();
    }

    String positionCode[] = {"P001", "P002", "P003", "P004"};
    String positionName[] = {"Software Developer Trainee",
                                "Business Analysis",
                                "Software Developer",
                                "Project Manager"};

    @Test
    public void select_Star_From_EMPOSITION() throws Exception{
        dateTestFindPaggingData("$[0].positionCode", positionCode[0], "", "");
        dateTestFindPaggingData("$[1].positionName", positionName[1], "", "");
        dateTestFindPaggingSize("size", 4, "", "");
    }

    @Test
    public void select_Star_From_EMPOSITION_Where_PositionCode_Equal () throws Exception{
         dateTestFindPaggingData("$[0].positionCode", positionCode[0], positionCode[0], "");
         dateTestFindPaggingSize("size", 1, positionCode[0], "");
    }

    @Test
    public void select_Star_From_EMPOSITION_Where_PositionName_Equal () throws Exception{
         dateTestFindPaggingData("$[0].positionName", positionName[1], "", positionName[1]);
         dateTestFindPaggingSize("size", 1, "", positionName[1]);
    }

    @Test
    public void select_Star_From_EMPOSITION_Where_PositionCode_Equal_And_PositionName_Equal () throws Exception{
         dateTestFindPaggingData("$[0].positionCode" ,positionCode[0] ,positionCode[0] ,positionName[0]);
         dateTestFindPaggingData("$[0].positionName" ,positionName[0] ,positionCode[0] ,positionName[0]);
         dateTestFindPaggingSize("size", 1, positionCode[0], positionName[0]);
    }

    @Test
    public void update_From_EMPOSITION_set_PositionName_Equal_Where_PositionCode_Equal () throws Exception{
        editDataTodateBase(positionCode[0], "A");
        dateTestFindPaggingData("$[0].positionName", "A", positionCode[0], "A");
    }

    @Test
    public void delete_From_EMPOSITION_Where_PositionCode_Equal () throws Exception{
        deleteDataTodateBase("4");
        dateTestIsEmpty("$[3].positionCode", "[]", positionCode[3], positionName[3]);
    }

    @Test
    public void select_Count_PositionCode_EMPOSITION_Where_PositionCode_Equal () throws Exception{
        dateTestFindCheckPositionCode(positionCode[0]);
    }

    @Test
    public void select_Inuse_From_EMPOSITION_Where_PositionCode_Equal () throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/empositions/findPaggingData")
            .param("positionCode", positionCode[0])
            .param("positionName", "")
            .param("firstResult","0")
            .param("maxResult","15")
        ).andDo(print())
            .andExpect(status().isOk())
            .andExpect(content().contentType("application/json;charset=UTF-8"))
            .andExpect(jsonPath("$[0].inUse", is(0)))
            .andReturn();
    }
}