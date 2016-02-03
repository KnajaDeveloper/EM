package com.app2.app2t.web.em;
import com.app2.app2t.domain.em.EMTeam;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.roo.addon.web.mvc.controller.json.RooWebJson;

@RequestMapping("/emteams")
@Controller
@RooWebScaffold(path = "emteams", formBackingObject = EMTeam.class)
@RooWebJson(jsonObject = EMTeam.class)
public class EMTeamController {
}
