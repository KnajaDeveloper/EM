// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.web.em;

import com.app2.app2t.domain.em.EMEmployee;
import com.app2.app2t.domain.em.EMTeam;
import flexjson.JSONSerializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

privileged aspect EMTeamController_Custom_Controller_Json {

    protected static Logger LOGGER = LoggerFactory.getLogger(EMTeamController_Custom_Controller_Json.class);



    @RequestMapping(value = "/findProjectBytypeTeamCode",method = RequestMethod.GET, headers = "Accept=application/json")
    public ResponseEntity<String> EMTeamController.findProjectBytypeTeamCode(
            @RequestParam(value="searchCode",required=false)String searchCode,
            @RequestParam(value="searchName",required=false)String searchName,
            @RequestParam(value = "maxResult", required = false) Integer maxResult
            ,@RequestParam(value = "firstResult", required = false) Integer firstResult
            ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {

            List<EMTeam> result = EMTeam.finTeamOfDataPagingData(searchCode,searchName,maxResult,firstResult );
            List<Map<String,String>> list = new ArrayList<>();
            for(EMTeam emTeam : result){
                Map<String,String> map = new HashMap<>();
                map.put("teamCode",emTeam.getTeamCode());
                map.put("teamName",emTeam.getTeamName());
                map.put("id",emTeam.getId().toString());
                map.put("inUse", String.valueOf(EMEmployee.findEMEmployeeCheckID(emTeam.getId())));
                list.add(map);

            }


            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(list), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @RequestMapping(value = "/teamPaggingSize", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> EMTeamController.teamPaggingSize(
            @RequestParam(value="searchCode",required=false)String searchCode,
            @RequestParam(value="searchName",required=false)String searchName) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            Long result = EMTeam.finTeamOfDataPagingSize( searchCode,searchName );
            Map dataSendToFront = new HashMap();
            dataSendToFront.put("size",result);
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(dataSendToFront), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error("findEvaPeriodTime :{}", e);
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/deleteTeam",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> EMTeamController.findDeleteTeam(
            @RequestParam(value = "deleteCode", required = false) String deleteCode
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMTeam> result = EMTeam.deleteTeam(deleteCode);
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(result), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/editTeam",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> EMTeamController.findEditTeam(
            @RequestParam(value = "editCode", required = false) String editCode,
            @RequestParam(value = "editName", required = false) String editName
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMTeam> result = EMTeam.editTeam(editCode,editName);
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(result), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findCheck",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> EMTeamController.findCheck(
            @RequestParam(value = "teamCode", required = false) String teamCode) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMTeam> result = EMTeam.findCheck(teamCode);
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(result), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    //--------------------------findTeamAll-----------------------------------------------------
    @RequestMapping(value = "/findTeamAll",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> EMTeamController.findTeamAll() {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMTeam> result = EMTeam.findTeamAll();
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(result), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findAllEmployeeByTeamId",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> EMTeamController.findAllEmployeeByTeamId(
            @RequestParam(value = "teamId", required = false) String teamId
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMTeam> employee = EMTeam.findAllEmployeeByTeamId(Long.parseLong(teamId));
            List<Map> list = new ArrayList<>();
            for(int i = 0 ; i < employee.size() ; i++){
                Map map = new HashMap();
                map.put("empCode", employee.get(i));
                list.add(map);
            }
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(list), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }




}
