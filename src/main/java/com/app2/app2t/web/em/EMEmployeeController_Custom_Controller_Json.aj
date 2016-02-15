// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.web.em;

import com.app2.app2t.domain.em.EMEmployee;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.app2.app2t.domain.em.EMEmployee;
import com.app2.app2t.web.em.EMEmployeeController;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.util.UriComponentsBuilder;
import flexjson.JSONSerializer;
import org.springframework.web.bind.annotation.*;

import java.util.*;
privileged aspect EMEmployeeController_Custom_Controller_Json {

    @RequestMapping(value = "/findProjectByemPosition", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json" )
    public ResponseEntity<String> EMEmployeeController.findProjectByemPosition(
            @RequestParam(value = "empCode", required = false) String empCode
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8" );
        try {
            List<EMEmployee> result = EMEmployee.findProjectByemPosition(empCode);
            List<Map<String, String>> list = new ArrayList<>();
            for (int i = 0; i < result.size(); i++) {
                EMEmployee ty = result.get(i);
                Map<String, String> map = new HashMap<>();
                map.put("code", ty.getEmPosition().getPositionCode());
                list.add(map);
                //System.out.println("Code : "+ty.getEmPosition().getPositionCode()+"\n==================");
            }

            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class" ).deepSerialize(list), headers, HttpStatus.OK);


        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @RequestMapping(value = "/findProjectByemTeam", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json" )
    public ResponseEntity<String> EMEmployeeController.findProjectByemTeam(
            @RequestParam(value = "empCode", required = false) String empCode
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8" );
        try {
            List<EMEmployee> result = EMEmployee.findProjectByemTeam(empCode);
            List<Map<String, String>> list = new ArrayList<>();
            for (int i = 0; i < result.size(); i++) {
                EMEmployee ty = result.get(i);
                Map<String, String> map = new HashMap<>();
                map.put("code", ty.getEmTeam().getTeamCode());
                list.add(map);
                //System.out.println("Code : "+ty.getEmPosition().getPositionCode()+"\n==================");
            }

            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class" ).deepSerialize(list), headers, HttpStatus.OK);


        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
    
