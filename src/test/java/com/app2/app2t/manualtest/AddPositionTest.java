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

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.*;
import org.springframework.expression.spel.ast.Projection;
import org.springframework.test.annotation.DirtiesContext;
import javax.persistence.EntityManager;

import java.text.SimpleDateFormat;
import java.util.*;
import java.io.*;

import com.app2.app2t.util.AuthorizeUtil;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
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
        AuthorizeUtil.setUserName("POTE");
        this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
        EMPosition position1 = insertDataTodateBaseEMPosition("P001", "Software Developer Trainee");
        EMPosition position2 = insertDataTodateBaseEMPosition("P002", "Business Analysis");
        EMPosition position3 = insertDataTodateBaseEMPosition("P003", "Software Developer");
        EMPosition position4 = insertDataTodateBaseEMPosition("P004", "Project Manager");
        EMPosition position5 = insertDataTodateBaseEMPosition("P005", "Administrator");
        EMPosition position6 = insertDataTodateBaseEMPosition("P006", "System Analyst");

        EMTeam team1 = insertDataTodateBaseEMTeam("T001", "Soft Square 1999");
        EMTeam team2 = insertDataTodateBaseEMTeam("T002", "SoftPlus");
        EMTeam team3 = insertDataTodateBaseEMTeam("T003", "HongSron Software");
        EMTeam team4 = insertDataTodateBaseEMTeam("T004", "Soft Square International");

        insertDataTodateBaseEMEmployee("EM001",	"กิตติศักดิ์", "บำรุงเขต", "เอ", "a@email.com", "admin", "admin", position5, team2, "ADMIN");
        insertDataTodateBaseEMEmployee("EM002",	"โฆสิต", "พงษ์ไพร", "บี", "b@email.com", "58060", "58060", position1, team2, "USER");
        insertDataTodateBaseEMEmployee("EM003",	"ชยณัฐ", "ลภนะพันธ์", "ซี", "c@email.com", "58024", "58024", position1, team2, "USER");
        insertDataTodateBaseEMEmployee("EM004",	"ชยธร", "พัฒนศักดิ์ภิญโญ", "ดี", "d@email.com", "em004", "em004", position3, team2, "USER");
        insertDataTodateBaseEMEmployee("EM005",	"ณัฐดนัย", "ศรีดาวงษ์", "อี", "e@email.com", "em005", "em005", position3, team2, "USER");
        insertDataTodateBaseEMEmployee("EM006",	"พรกนก", "นิ่มสำลี", "เอฟ", "f@email.com", "em006", "em006", position2, team2, "USER");
        insertDataTodateBaseEMEmployee("EM007",	"พจน์", "ปุญญฤทธิ์", "จี", "g@email.com", "em007", "em007", position1, team2, "USER");
        insertDataTodateBaseEMEmployee("EM008",	"ภัคพล", "แสงมณี", "เอช", "h@email.com", "em008", "em008", position1, team1, "USER");
        insertDataTodateBaseEMEmployee("EM009",	"รักดี", "มีรักเดียว", "ไอ", "i@email.com", "em009", "em009", position1, team1, "USER");
        insertDataTodateBaseEMEmployee("EM010",	"สมบูรณ์", "อัชฌาสัย", "เจ", "j@email.com", "em010", "em010", position1, team1, "USER");
        insertDataTodateBaseEMEmployee("EM011",	"ชูศักดิ์", "เกียรติเฉลิมคุณ", "เค", "k@email.com", "em011", "em011", position1, team1, "USER");
        insertDataTodateBaseEMEmployee("EM012",	"ดำรงค์", "ปคุณวานิช", "แอล", "l@email.com", "em012", "em012", position1, team1, "USER");
        insertDataTodateBaseEMEmployee("EM013",	"นุปกรณ์", "ภูวดล", "เอ็ม", "m@email.com", "em013", "em013", position1, team1, "USER");
        insertDataTodateBaseEMEmployee("EM014",	"สมหวัง", "จตุรงค์", "เอ็น", "n@email.com", "em014", "em014", position1, team1, "USER");
        insertDataTodateBaseEMEmployee("EM015",	"สุมาลี", "วงศาวัฒน์", "โอ", "o@email.com", "em015", "em015", position1, team1, "USER");
        insertDataTodateBaseEMEmployee("EM016",	"ทรงพล", "อาริยวัฒน์", "พี", "p@email.com", "em016", "em016", position4, team1, "USER");
        insertDataTodateBaseEMEmployee("EM017",	"อรมนัส", "อยู่บุญสอ", "คิว", "q@email.com", "em017", "em017", position4, team2, "USER");
        insertDataTodateBaseEMEmployee("EM018",	"สมใจ", "หาญเรืองเกียรติ", "อาร์", "r@email.com", "em018", "em018", position4, team3, "USER");
    }

    public EMPosition insertDataTodateBaseEMPosition (String positionCode, String positionName)throws Exception{
        EMPosition emPosition = new EMPosition();
        emPosition.setPositionCode(positionCode);
        emPosition.setPositionName(positionName);
        emPosition.persist();
        return emPosition;
    }

    public EMTeam insertDataTodateBaseEMTeam (String teamCode, String teamName)throws Exception{
        EMTeam emTeam = new EMTeam();
        emTeam.setTeamCode(teamCode);
        emTeam.setTeamName(teamName);
        emTeam.persist();
        return emTeam;
    }

    public void insertDataTodateBaseEMEmployee (
        String empCode
        , String empFirstName
        , String empLastName
        , String empNickName
        , String email
        , String userName
        , String password
        , EMPosition emPosition
        , EMTeam emTeam
        , String roleCode
    )throws Exception{
        EMEmployee emEmployee = new EMEmployee();
        emEmployee.setEmpCode(empCode);
        emEmployee.setEmpFirstName(empFirstName);
        emEmployee.setEmpLastName(empLastName);
        emEmployee.setEmpNickName(empNickName);
        emEmployee.setEmail(email);
        emEmployee.setUserName(userName);
        emEmployee.setPassword(password);
        emEmployee.setEmPosition(emPosition);
        emEmployee.setEmTeam(emTeam);
        emEmployee.setRoleCode(roleCode);
        emEmployee.persist();
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

    String positionCode[] = {"P001", "P002", "P003", "P004", "P005", "P006"};
    String positionName[] = {"Software Developer Trainee",
                                "Business Analysis",
                                "Software Developer",
                                "Project Manager",
								"Administrator",
								"System Analyst"};

    @Test
    public void select_Star_From_EMPOSITION() throws Exception{
        dateTestFindPaggingData("$[0].positionCode", positionCode[0], "", "");
        dateTestFindPaggingData("$[1].positionName", positionName[1], "", "");
        dateTestFindPaggingSize("size", 6, "", "");
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
        deleteDataTodateBase("6");
        dateTestIsEmpty("$[5].positionCode", "[]", positionCode[5], positionName[5]);
    }

    @Test
    public void select_Count_PositionCode_EMPOSITION_Where_PositionCode_Equal () throws Exception{
        dateTestFindCheckPositionCode(positionCode[0]);
    }

    @Test
    public void select_Inuse_From_EMPOSITION_Where_PositionCode_Equal () throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findEMPositionByID")
            .param("emPosition", "1")
        ).andDo(print())
            .andExpect(status().isOk())
            .andExpect(content().contentType("application/json;charset=UTF-8"))
            .andExpect(jsonPath("size", is(11)))
            .andReturn();
    }

    @Test
    public void Select_EmpCode_EmpFirstName_EmpLastName_EmpPositionName_From_EMEMPLOYEE_Where_EmpCode_Equal () throws Exception{
        MvcResult mvcResult = this.mockMvc.perform(get("/ememployees/findEmployeeByEmpCode")
            .param("empCode", "EM001")
        ).andDo(print())
            .andExpect(status().isOk())
            .andExpect(content().contentType("application/json;charset=UTF-8"))
            .andExpect(jsonPath("$[0].empCode", is("EM001")))
            .andExpect(jsonPath("$[0].empFirstName", is("กิตติศักดิ์")))
            .andExpect(jsonPath("$[0].empLastName", is("บำรุงเขต")))
            .andExpect(jsonPath("$[0].empPositionName", is("Administrator")))
            .andReturn();
    }
}