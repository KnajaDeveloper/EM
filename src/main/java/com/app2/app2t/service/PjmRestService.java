package com.app2.app2t.service;


import com.app2.app2t.util.AuthorizeUtil;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class PjmRestService extends AbstractAPP2Service {
    private static Logger LOGGER = LoggerFactory.getLogger(PjmRestService.class);

    public PjmRestService() {
        this.APP2Server  = connectProperties.getProperty("PJM-APP2Server");///test/test
    }

    public Boolean checkEMCodeInPjm(String empCode) {
        Boolean result = false;
        try {
            setWebServicesString("http://" + this.APP2Server + "/pjm/checkEMCodeInPjm?empCode=" + empCode);
            result =  Boolean.parseBoolean(getResultString()) ;

            return result;
        }
         catch (Exception e) {
            LOGGER.error("Error : {}", e.getMessage());
            return result;
        }
    }


}
