package com.app2.app2t.manualtest;

import com.app2.app2t.domain.em.*;
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

//     public void selectProjectReturnLong(long dateLong,String json,String stDatefrom,String stDate_To,String fnDateFrom,String fnDateTo,String costFrom,String costTo,String pm) throws Exception{
// //        insertDataTodateBase("1457456400000","1459357200000","PM1","ProjectTest1","PT01",20);//date 09/03/2016 - 31/03/2016
// //        insertDataTodateBase("1457456400000","1458061200000","PM2","ProjectTest2","PT02",30);//date 09/03/2016 - 16/03/2016
//         dateTest(dateLong,json,stDatefrom,stDate_To,fnDateFrom,fnDateTo,costFrom,costTo,pm);
//     }
//     public void selectProjectReturnInt(int dateLong,String json,String stDatefrom,String stDate_To,String fnDateFrom,String fnDateTo,String costFrom,String costTo,String pm) throws Exception{
// //        insertDataTodateBase("1457456400000","1459357200000","PM1","ProjectTest1","PT01",20);//date 09/03/2016 - 31/03/2016
// //        insertDataTodateBase("1457456400000","1458061200000","PM2","ProjectTest2","PT02",30);//date 09/03/2016 - 16/03/2016
//         dataTest(dateLong,json,stDatefrom,stDate_To,fnDateFrom,fnDateTo,costFrom,costTo,pm);
//     }

    public void insertDataTodateBase (String positionCode, String positionName)throws Exception{
        EMPosition emPosition = new EMPosition();
        emPosition.setPositionCode(positionCode);
        emPosition.setPositionName(positionName);
        emPosition.persist();
    }

    public void dateTest (String json, String dataJson, String positionCode, String positionName)throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/empositions/findPaggingData")
            .param("positionCode", positionCode)
            .param("positionName", positionName)
            .param("firstResult","0")
            .param("maxResult","15")
        ).andDo(print())
            .andExpect(status().isOk())
            .andExpect(content().contentType("application/json;charset=UTF-8"))
            .andExpect(jsonPath(json, is(dataJson)))
            .andReturn()
            ;
    }

//     public void dataTest  (int dataJson,String json,String stDatefrom,String stDateTo,String fnDateFrom,String fnDateTo,String costFrom,String costTo,String pm)throws Exception{
//         MvcResult mvcResult = this.mockMvc.perform(get("/projects/findProjectSearchData")
//                 .param("StDateBegin",stDatefrom)
//                 .param("StDateEnd",stDateTo)
//                 .param("FnDateBegin",fnDateFrom)
//                 .param("FnDateEnd",fnDateTo)
//                 .param("costStart",costFrom)
//                 .param("costEnd",costTo)
//                 .param("projectManage",pm)
//                 .param("maxResult","15")
//                 .param("firstResult","0")
//         ).andDo(print())
//                 .andExpect(status().isOk())
//                 .andExpect(content().contentType("application/json;charset=UTF-8"))
//                 .andExpect(jsonPath(json, is(dataJson)))
//                 .andReturn()
//                 ;
//     }

    String positionCode[] = {"P001", "P002", "P003", "P004"};
    String positionName[] = {"Software Developer Trainee",
                                "Business Analysis",
                                "Software Developer",
                                "Project Manager"};

    // @Test 
    // public void select_Star_From_EMPOSITION() throws Exception{
    //     for(int i = 0; i < 4; i++){
    //         dateTest("$[" + i + "].positionCode", positionCode[i], "", "");
    //         dateTest("$[" + i + "].positionName", positionName[i], "", "");
    //     }
    // }

    // @Test 
    // public void select_Star_From_EMPOSITION_Where_PositionCode_Equal () throws Exception{
    //     dateTest("$[0].positionCode", "P001", "P001", "");
    // }

    // @Test 
    // public void select_Star_From_EMPOSITION_Where_PositionName_Equal () throws Exception{
    //     dateTest("$[0].positionName", "Project Manager", "", "Project Manager");
    // }

    @Test 
    public void select_Star_From_EMPOSITION_Where_PositionCode_Equal_And_PositionName_Equal () throws Exception{
        dateTest("$[0].positionCode" ,"Project Manager" ,"P001" ,"Software Developer Trainee");
        dateTest("$[0].positionName" ,"Software Developer Trainee" ,"P001" ,"Software Developer Trainee");
    }
//     @Test
//     public void selectWhereStDateTo () throws Exception{
//         selectProjectReturnLong(1457456400000L,"$[0].dateStart","","1458061200000","","","","","");//date = 16/03/2016
//     }
//     @Test
//     public void selectWhereStDateFrom_StDateTo () throws Exception{
//         selectProjectReturnLong(1457456400000L,"$[0].dateStart","1457456400000","1458061200000","","","","","");//date = 09/03/2016 - 16/03/2016
//     }
//     @Test
//     public void selectWhereEnDateFrom () throws Exception{
//         selectProjectReturnLong(1459357200000L,"$[0].dateEnd","","","1459357200000","","","","");//date = 31/03/2016
//     }
//     @Test
//     public void selectWhereEnDateTo () throws Exception{
//         selectProjectReturnLong(1458061200000L,"$[0].dateEnd","","","","1458061200000","","","");//date = 16/03/2016
//     }
//     @Test
//     public void selectWhereEnDateFrom_EnDateTo () throws Exception{
//         selectProjectReturnLong(1458061200000L,"$[0].dateEnd","","","1457456400000","1458061200000","","","");//date = 09/03/2016 - 16/03/2016
//     }
//     @Test
//     public void selectWhereCostFrom () throws Exception{
//         selectProjectReturnInt(20,"$[0].projectCost","","","","","20","","");
//     }
//     @Test
//     public void selectWhereCostTo () throws Exception{
//         selectProjectReturnInt(30,"$[1].projectCost","","","","","","30","");
//     }
//     @Test
//     public void selectWhereCostFrom_CostTo () throws Exception{
//         selectProjectReturnInt(30,"$[0].projectCost","","","","","30","31","");
//     }
//     @Test
//     public void selectWherePm () throws Exception{
//         selectProjectReturnInt(30,"$[0].projectCost","","","","","","","PM2");
//     }
//     ////////////////////////////////
//     @Test
//     public void checkModule() throws Exception{

//         MvcResult mvcResult = this.mockMvc.perform(get("/moduleprojects/findProjectCheckID")
//                 .param("projectId", "1")
//         ).andDo(print())
//                 .andExpect(status().isOk())
//                 .andExpect(content().contentType("application/json;charset=UTF-8"))
//                 .andReturn()
//                 ;
//         assertEquals(mvcResult.getResponse().getContentAsString(),"[]");

//     }
//     ////////////////////////////////
//     @Test
//     public void deleteProject() throws Exception{

//         MvcResult mvcResult = this.mockMvc.perform(get("/projects/deleteProjects")
//                 .param("deleteCode", "4")
//         ).andDo(print())
//                 .andExpect(status().isOk())
//                 .andExpect(content().contentType("application/json;charset=UTF-8"))
//                 .andReturn()
//                 ;

//         selectAll();
//     }
//     public void selectAll ()throws Exception{
//         selectProjectReturnLong(1457456400000L,"$[0].dateStart","","","","","","","");//date = 09/03/2016
//     }


}
