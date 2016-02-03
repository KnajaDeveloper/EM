// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.web.em;

import com.app2.app2t.domain.em.EMEmployee;
import com.app2.app2t.domain.em.EMPosition;
import com.app2.app2t.domain.em.EMTeam;
import com.app2.app2t.web.em.EMEmployeeController;
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

privileged aspect EMEmployeeController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String EMEmployeeController.create(@Valid EMEmployee EMEmployee_, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, EMEmployee_);
            return "ememployees/create";
        }
        uiModel.asMap().clear();
        EMEmployee_.persist();
        return "redirect:/ememployees/" + encodeUrlPathSegment(EMEmployee_.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String EMEmployeeController.createForm(Model uiModel) {
        populateEditForm(uiModel, new EMEmployee());
        return "ememployees/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String EMEmployeeController.show(@PathVariable("id") Long id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("ememployee_", EMEmployee.findEMEmployee(id));
        uiModel.addAttribute("itemId", id);
        return "ememployees/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String EMEmployeeController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("ememployees", EMEmployee.findEMEmployeeEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) EMEmployee.countEMEmployees() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("ememployees", EMEmployee.findAllEMEmployees(sortFieldName, sortOrder));
        }
        addDateTimeFormatPatterns(uiModel);
        return "ememployees/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String EMEmployeeController.update(@Valid EMEmployee EMEmployee_, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, EMEmployee_);
            return "ememployees/update";
        }
        uiModel.asMap().clear();
        EMEmployee_.merge();
        return "redirect:/ememployees/" + encodeUrlPathSegment(EMEmployee_.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String EMEmployeeController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, EMEmployee.findEMEmployee(id));
        return "ememployees/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String EMEmployeeController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        EMEmployee EMEmployee_ = EMEmployee.findEMEmployee(id);
        EMEmployee_.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/ememployees";
    }
    
    void EMEmployeeController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("EMEmployee__createddate_date_format", "dd/MM/yyyy");
        uiModel.addAttribute("EMEmployee__updateddate_date_format", "dd/MM/yyyy");
    }
    
    void EMEmployeeController.populateEditForm(Model uiModel, EMEmployee EMEmployee_) {
        uiModel.addAttribute("EMEmployee_", EMEmployee_);
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("empositions", EMPosition.findAllEMPositions());
        uiModel.addAttribute("emteams", EMTeam.findAllEMTeams());
    }
    
    String EMEmployeeController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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