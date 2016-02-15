package com.app2.app2t.web.em;

import flexjson.JSONSerializer;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import  com.app2.app2t.domain.em.EMPosition;

import org.springframework.web.bind.annotation.*;

import java.util.*;

privileged aspect EMPositionController_Custom_Controller_Json {

    @RequestMapping(value = "/findAllProject",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> EMPositionController.findAllProject() {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMPosition> result = EMPosition.findAllProject();
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(result), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findProjectByposition",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> EMPositionController.findProjectByposition(
        @RequestParam(value = "positionCode", required = false) String positionCode
        ,@RequestParam(value = "positionName", required = false) String positionName
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMPosition> result = EMPosition.findProjectByposition(positionCode, positionName);
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(result), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findPaggingData", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> EMPositionController.findPaggingData(
        @RequestParam(value = "positionCode", required = false) String positionCode
        ,@RequestParam(value = "positionName", required = false) String positionName
        ,@RequestParam(value = "maxResult", required = false) Integer maxResult
        ,@RequestParam(value = "firstResult", required = false) Integer firstResult
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMPosition> result = EMPosition.findProjectByposition(positionCode, positionName);
            List<Map<String,String>> list = new ArrayList<>();
            for(int i=firstResult;i<maxResult + firstResult && i < result.size();i++){
                EMPosition ty = result.get(i);
                Map<String,String> map = new HashMap<>();
                map.put("code", ty.getPositionCode());
                map.put("name", ty.getPositionName());
                list.add(map);
            }
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(list), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error("findEvaPeriodTime :{}", e);
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findPaggingSize", method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> EMPositionController.findPaggingSize(
        @RequestParam(value = "positionCode", required = false) String positionCode
        ,@RequestParam(value = "positionName", required = false) String positionName
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMPosition> result = EMPosition.findProjectByposition(positionCode, positionName);
            Map data = new HashMap();
            data.put("size", result.size());
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(data), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error("findEvaPeriodTime :{}", e);
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findeditEMPosition",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> EMPositionController.findeditEMPosition(
        @RequestParam(value = "positionCode", required = false) String positionCode
        ,@RequestParam(value = "positionName", required = false) String positionName
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMPosition> result = EMPosition.findeditEMPosition(positionCode, positionName);
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(result), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findDeletePosition",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> EMPositionController.findDeletePosition(
        @RequestParam(value = "positionCode", required = false) String positionCode
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMPosition> result = EMPosition.findDeletePosition(positionCode);
            return  new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(result), headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findProjectBypositionCode",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> EMPositionController.findProjectBypositionCode(
        @RequestParam(value = "positionCode", required = false) String positionCode
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMPosition> result = EMPosition.findProjectBypositionCode(positionCode);
            return  new ResponseEntity<String>(result.size() + "", headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
