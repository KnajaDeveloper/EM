// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.web.em;

import com.app2.app2t.domain.em.EMEmployee;
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

privileged aspect EMEmployeeController_Custom_Controller_Json {

    protected static Logger LOGGER = LoggerFactory.getLogger(EMEmployeeController_Custom_Controller_Json.class);

    @RequestMapping(value = "/findProjectByemTeam", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json" )
    public ResponseEntity<String> EMEmployeeController.findProjectByemTeam(
            @RequestParam(value = "emTeam", required = false) long emTeam
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8" );
        try {
            List<EMEmployee> result = EMEmployee.findProjectByemTeam(emTeam);
            List<Map<String, String>> list = new ArrayList<>();
            for (int i = 0; i < result.size(); i++) {
                EMEmployee ty = result.get(i);
                Map<String, String> map = new HashMap<>();
                map.put("code", ty.getEmTeam().getTeamCode());
                list.add(map);
                //System.out.println("Code : "+ty.getEmPosition().getPositionCode()+"\n==================");
            }
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class" ).deepSerialize(result), headers, HttpStatus.OK);

        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findProjectByempCode",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> EMEmployeeController.findProjectByempCode(
        @RequestParam(value = "empCode", required = false) String empCode
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMEmployee> result = EMEmployee.findProjectByempCode(empCode);
            return  new ResponseEntity<String>(result.size() + "", headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

//---------getEmpNameByEmpCode-----------------------------------------------------------------------------------------------------------
@RequestMapping(value = "/findEmpNameByEmpCode",method = RequestMethod.GET)
public ResponseEntity<String> EMEmployeeController.findEmpNameByEmpCode(
        @RequestParam(value = "empCode", required = false) String empcode
) {

    HttpHeaders headers = new HttpHeaders();
    headers.add("Content-Type", "application/json;charset=UTF-8");
    try {
        List<EMEmployee> result = EMEmployee.findEmpNameByEmpCode(empcode);
        List<Map<String, String>> list = new ArrayList<>();
        for (int i = 0; i < result.size(); i++) {
            EMEmployee ty = result.get(i);
            Map<String, String> map = new HashMap<>();
            map.put("Fname", ty.getEmpFirstName());
            map.put("Lname", ty.getEmpLastName());
            list.add(map);
            //System.out.println("Code : "+ty.getEmPosition().getPositionCode()+"\n==================");
        }
        return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class" ).deepSerialize(list), headers, HttpStatus.OK);
    } catch (Exception e) {
        LOGGER.error(e.getMessage(), e);
        return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}



    //---------getEmpNameByUserName-----------------------------------------------------------------------------------------------------------

    @RequestMapping(value = "/findEMNameByUserName",method = RequestMethod.GET)
    public ResponseEntity<String> EMEmployeeController.findEMNameByUserName(
            @RequestParam(value = "userName", required = false) String userName
    ) {

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMEmployee> result = EMEmployee.findEMNameByUserName(userName);
            List<Map<String, String>> list = new ArrayList<>();
            for (int i = 0; i < result.size(); i++) {
                EMEmployee ty = result.get(i);
                Map<String, String> map = new HashMap<>();
                map.put("UFname", ty.getEmpFirstName());
                map.put("ULname", ty.getEmpLastName());
                list.add(map);

            }
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class" ).deepSerialize(list), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findEmployeeByUserName",method = RequestMethod.GET)
    public ResponseEntity<String> EMEmployeeController.findEmployeeByUserName(
            @RequestParam(value = "userName", required = false) String userName
    ) {

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMEmployee> empList = EMEmployee.findEMNameByUserName(userName);
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class" ).deepSerialize(empList), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @RequestMapping(value = "/findAppRoleByUserName", method = RequestMethod.GET)
    public ResponseEntity<String> EMEmployeeController.findAppRoleByUserName(
            @RequestParam(value = "userName", required = false) String userName
    ) {

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {

            EMEmployee emp = EMEmployee.findAppRoleByUserName(userName);
            Map<String, Object> map = new HashMap<>();
            map.put("appRole", emp.getRoleCode());
            LOGGER.debug(map+"");
            List<Map<String, Object>> result = new ArrayList<>();
            result.add(map);

            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class" ).deepSerialize(result), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findselectDataAddRole",method = RequestMethod.GET, headers = "Accept=application/json")
    public ResponseEntity<String> EMEmployeeController.findselectDataAddRole(
            @RequestParam(value="empCode",required=false)String empCode,
            @RequestParam(value="empFirstName",required=false)String empFirstName,
            @RequestParam(value="empLastName",required=false)String empLastName,
            @RequestParam(value="emPosition",required=false)String emPosition,
            @RequestParam(value="emTeam",required=false)String emTeam,
            @RequestParam(value="appRoleHave",required=false)String appRoleHave,
            @RequestParam(value = "maxResult", required = false) Integer maxResult,
            @RequestParam(value = "firstResult", required = false) Integer firstResult
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMEmployee> result = EMEmployee.findselectDataAddRole(empCode,empFirstName,empLastName,emPosition,emTeam,appRoleHave,maxResult,firstResult);
            List<Map<String,Object>> list = new ArrayList<>();
            for(EMEmployee emEmployee : result){
                Map<String,Object> map = new HashMap<>();
                map.put("empCode", emEmployee.getEmpCode());
                map.put("empFirstName", emEmployee.getEmpFirstName());
                map.put("empLastName", emEmployee.getEmpLastName());
                map.put("emPosition", emEmployee.getEmPosition());
                map.put("emTeam", emEmployee.getEmTeam());
                map.put("roleCode", emEmployee.getRoleCode());
                list.add(map);
            }
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(list), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @RequestMapping(value = "/addRolePaggingSize", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> EMEmployeeController.addRolePaggingSize(
            @RequestParam(value="empCode",required=false)String empCode,
            @RequestParam(value="empFirstName",required=false)String empFirstName,
            @RequestParam(value="empLastName",required=false)String empLastName,
            @RequestParam(value="emPosition",required=false)String emPosition,
            @RequestParam(value="emTeam",required=false)String emTeam,
            @RequestParam(value="appRoleHave",required=false)String appRoleHave
            ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            Long result = EMEmployee.finProjectOfDataPagingSize(empCode,empFirstName,empLastName,emPosition,emTeam,appRoleHave);
            Map dataSendToFront = new HashMap();
            dataSendToFront.put("size",result);
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(dataSendToFront), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error("findEvaPeriodTime :{}", e);
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findappRoleName",method = RequestMethod.GET)
    public ResponseEntity<String> EMEmployeeController.findappRoleName() {

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<Map> list = securityRestService.getAppRoleService();
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class" ).deepSerialize(list), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/saveOrUpdateAppRoleCode",method = RequestMethod.POST, produces = "text/html", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> EMEmployeeController.saveOrUpdateAppRoleCode(
            @RequestParam(value="arrEmpCode",required=false)String empCode,
            @RequestParam(value="arrRoleCode",required=false)String roleCode
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
             List<EMEmployee> result = EMEmployee.findSaveOrUpdateAppRoleCode(empCode,roleCode);
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class" ).deepSerialize(result), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(">>>><<<<{}:"+e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findEMPositionByID", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> EMEmployeeController.findEMPositionByID(
        @RequestParam(value = "emPosition", required = false) Long emPosition
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            Long size = EMEmployee.findEMPositionByID(emPosition);
            Map sizeEMPosition = new HashMap();
            sizeEMPosition.put("size", size);
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(sizeEMPosition), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error("findEvaPeriodTime :{}", e);
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findRoleCode", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> EMEmployeeController.findRoleCode() {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<String> listRoleCode = EMEmployee.findDistinctRoleCode();
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(listRoleCode), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error("=============> findRoleCode :{}", e);
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findEmployeeByTextLov", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> EMEmployeeController.findEmployeeByTextLov(
            @RequestParam(value = "text", required = false) String text
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMEmployee> employee = EMEmployee.findEmployeeByTextLov(text);
            List<Map> list = new ArrayList<>();
            for(EMEmployee em : employee){
                Map map = new HashMap();
                map.put("empCode",em.getEmpCode());
                map.put("empFirstName",em.getEmpFirstName());
                map.put("empLastName",em.getEmpLastName());
                map.put("empNickName",em.getEmpNickName());
                list.add(map);
            }
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(employee), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error("findEvaPeriodTime :{}", e);
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findEmployeeByText", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> EMEmployeeController.findEmployeeByText(
            @RequestParam(value = "text", required = false) String text
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<Map> employee = emRestService.findEmployeeByTextLov(text);
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(employee), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error("findEvaPeriodTime :{}", e);
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}