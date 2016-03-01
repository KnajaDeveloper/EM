package com.app2.app2t.web.em;

import com.app2.app2t.domain.em.EMEmployee;
import com.app2.app2t.service.EmRestService;
import com.app2.app2t.service.SecurityRestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.roo.addon.web.mvc.controller.json.RooWebJson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RequestMapping("/emmenus")
@Controller
public class EMMenuController {
	@Autowired
    EmRestService emRestService;
    @Autowired
    SecurityRestService securityRestService;
    protected Logger LOGGER = LoggerFactory.getLogger(EMEmployeeController.class);
}
