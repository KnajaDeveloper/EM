package com.app2.app2t.web.em;
import com.app2.app2t.domain.em.EMEmployee;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.roo.addon.web.mvc.controller.json.RooWebJson;

@RequestMapping("/ememployees")
@Controller
@RooWebScaffold(path = "ememployees", formBackingObject = EMEmployee.class)
@RooWebJson(jsonObject = EMEmployee.class)
public class EMEmployeeController {
}
