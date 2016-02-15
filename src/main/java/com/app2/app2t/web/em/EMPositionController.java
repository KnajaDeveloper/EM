package com.app2.app2t.web.em;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.app2.app2t.domain.em.EMPosition;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.roo.addon.web.mvc.controller.json.RooWebJson;

@RequestMapping("/empositions")
@Controller
@RooWebScaffold(path = "empositions", formBackingObject = EMPosition.class)
@RooWebJson(jsonObject = EMPosition.class)
public class EMPositionController {
	protected Logger LOGGER = LoggerFactory.getLogger(EMPositionController.class);
}
