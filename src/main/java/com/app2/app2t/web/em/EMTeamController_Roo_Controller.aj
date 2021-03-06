// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

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

privileged aspect EMTeamController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String EMTeamController.create(@Valid EMTeam EMTeam_, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, EMTeam_);
            return "emteams/create";
        }
        uiModel.asMap().clear();
        EMTeam_.persist();
        return "redirect:/emteams/" + encodeUrlPathSegment(EMTeam_.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String EMTeamController.createForm(Model uiModel) {
        populateEditForm(uiModel, new EMTeam());
        return "emteams/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String EMTeamController.show(@PathVariable("id") Long id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("emteam_", EMTeam.findEMTeam(id));
        uiModel.addAttribute("itemId", id);
        return "emteams/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String EMTeamController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("emteams", EMTeam.findEMTeamEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) EMTeam.countEMTeams() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("emteams", EMTeam.findAllEMTeams(sortFieldName, sortOrder));
        }
        addDateTimeFormatPatterns(uiModel);
        return "emteams/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String EMTeamController.update(@Valid EMTeam EMTeam_, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, EMTeam_);
            return "emteams/update";
        }
        uiModel.asMap().clear();
        EMTeam_.merge();
        return "redirect:/emteams/" + encodeUrlPathSegment(EMTeam_.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String EMTeamController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, EMTeam.findEMTeam(id));
        return "emteams/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String EMTeamController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        EMTeam EMTeam_ = EMTeam.findEMTeam(id);
        EMTeam_.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/emteams";
    }
    
    void EMTeamController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("EMTeam__createddate_date_format", "dd/MM/yyyy");
        uiModel.addAttribute("EMTeam__updateddate_date_format", "dd/MM/yyyy");
    }
    
    void EMTeamController.populateEditForm(Model uiModel, EMTeam EMTeam_) {
        uiModel.addAttribute("EMTeam_", EMTeam_);
        addDateTimeFormatPatterns(uiModel);
    }
    
    String EMTeamController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
