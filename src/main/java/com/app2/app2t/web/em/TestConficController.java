package com.app2.app2t.web.em;

import org.springframework.roo.addon.web.mvc.controller.json.RooWebJson;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RequestMapping("/testfic")
@Controller
public class TestConficController {

	protected Logger LOGGER = LoggerFactory.getLogger(TestConficController.class);

    @RequestMapping(value="/testfic",method = RequestMethod.GET, produces = "text/html")
    public String testfic(Model uiModel) {
    	LOGGER.debug("in testfic");
        return "testfic/testfic";
    }

    
}
