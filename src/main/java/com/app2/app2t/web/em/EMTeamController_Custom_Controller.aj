
package com.app2.app2t.web.em;

import com.app2.app2t.domain.em.EMTeam;
import com.app2.app2t.web.em.EMTeamController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect EMTeamController_Custom_Controller {
    
   
     @RequestMapping(value = "/addTeam", produces = "text/html")
    public String EMTeamController.addTheam( Model uiModel) {

        return "emteams/addTeam";
    }

}
