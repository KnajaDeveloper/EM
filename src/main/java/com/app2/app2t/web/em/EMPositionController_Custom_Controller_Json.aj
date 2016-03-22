package com.app2.app2t.web.em;

import flexjson.JSONSerializer;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import  com.app2.app2t.domain.em.*;

import org.springframework.web.bind.annotation.*;

import java.util.*;

privileged aspect EMPositionController_Custom_Controller_Json {

    @RequestMapping(value = "/findPaggingData",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> EMPositionController.findPaggingData(
        @RequestParam(value = "positionCode", required = false) String positionCode
        ,@RequestParam(value = "positionName", required = false) String positionName
        ,@RequestParam(value = "firstResult",required = false) Integer firstResult
        ,@RequestParam(value = "maxResult",required = false) Integer maxResult
    ){
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try{
            List<Map<String,Object>> resultSearch = new ArrayList<>();
            List<EMPosition> emPositions = EMPosition.findPositionDataPagingData(positionCode, positionName, firstResult, maxResult);
            for (EMPosition emPosition: emPositions) {
                Map<String,Object> buffer = new HashMap<>();
                buffer.put("id", emPosition.getId());
                buffer.put("positionCode", emPosition.getPositionCode());
                buffer.put("positionName", emPosition.getPositionName());
                buffer.put("inUse", EMEmployee.findEMPositionByID(emPosition.getId()));
                resultSearch.add(buffer);
            }
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(resultSearch), headers, HttpStatus.OK);
        }catch (Exception e){
            return new ResponseEntity<String>("{\"ERROR\":" + e.getMessage() + "\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findPaggingSize",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> EMPositionController.findPaggingSize(
        @RequestParam(value = "positionCode", required = false) String positionCode
        ,@RequestParam(value = "positionName", required = false) String positionName
    ){
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try{
            Long size = EMPosition.findPositionDataPagingSize(positionCode, positionName);
            Map dataSendToFront = new HashMap();
            dataSendToFront.put("size",size);
            return new ResponseEntity<String>(new JSONSerializer().exclude("*.class").deepSerialize(dataSendToFront), headers, HttpStatus.OK);
        }catch (Exception e){
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
            EMPosition emPositions = EMPosition.findDeletePosition(positionCode);
            return  new ResponseEntity<String>(headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/findCheckPositionCode",method = RequestMethod.GET, produces = "text/html", headers = "Accept=application/json")
    public ResponseEntity<String> EMPositionController.findCheckPositionCode(
        @RequestParam(value = "positionCode", required = false) String positionCode
    ) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        try {
            List<EMPosition> result = EMPosition.findCheckPositionCode(positionCode);
            return  new ResponseEntity<String>(result.size() + "", headers, HttpStatus.OK);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
            return new ResponseEntity<String>("{\"ERROR\":"+e.getMessage()+"\"}", headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
