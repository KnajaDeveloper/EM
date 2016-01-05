// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.domain.em;

import com.app2.app2t.domain.em.EMEmployee;
import com.app2.app2t.domain.em.EMEmployeeDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Component;

privileged aspect EMEmployeeDataOnDemand_Roo_DataOnDemand {
    
    declare @type: EMEmployeeDataOnDemand: @Component;
    
    private Random EMEmployeeDataOnDemand.rnd = new SecureRandom();
    
    private List<EMEmployee> EMEmployeeDataOnDemand.data;
    
    public EMEmployee EMEmployeeDataOnDemand.getNewTransientEMEmployee(int index) {
        EMEmployee obj = new EMEmployee();
        setCreatedBy(obj, index);
        setCreatedDate(obj, index);
        setEmail(obj, index);
        setEmpCode(obj, index);
        setEmpFirstName(obj, index);
        setEmpLastName(obj, index);
        setEmpName(obj, index);
        setEmpNickName(obj, index);
        setPassword(obj, index);
        setStatus(obj, index);
        setUpdatedBy(obj, index);
        setUpdatedDate(obj, index);
        setUserName(obj, index);
        return obj;
    }
    
    public void EMEmployeeDataOnDemand.setCreatedBy(EMEmployee obj, int index) {
        String createdBy = "createdBy_" + index;
        obj.setCreatedBy(createdBy);
    }
    
    public void EMEmployeeDataOnDemand.setCreatedDate(EMEmployee obj, int index) {
        Date createdDate = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setCreatedDate(createdDate);
    }
    
    public void EMEmployeeDataOnDemand.setEmail(EMEmployee obj, int index) {
        String email = "foo" + index + "@bar.com";
        obj.setEmail(email);
    }
    
    public void EMEmployeeDataOnDemand.setEmpCode(EMEmployee obj, int index) {
        String empCode = "empCode_" + index;
        obj.setEmpCode(empCode);
    }
    
    public void EMEmployeeDataOnDemand.setEmpFirstName(EMEmployee obj, int index) {
        String empFirstName = "empFirstName_" + index;
        obj.setEmpFirstName(empFirstName);
    }
    
    public void EMEmployeeDataOnDemand.setEmpLastName(EMEmployee obj, int index) {
        String empLastName = "empLastName_" + index;
        obj.setEmpLastName(empLastName);
    }
    
    public void EMEmployeeDataOnDemand.setEmpName(EMEmployee obj, int index) {
        String empName = "empName_" + index;
        obj.setEmpName(empName);
    }
    
    public void EMEmployeeDataOnDemand.setEmpNickName(EMEmployee obj, int index) {
        String empNickName = "empNickName_" + index;
        obj.setEmpNickName(empNickName);
    }
    
    public void EMEmployeeDataOnDemand.setPassword(EMEmployee obj, int index) {
        String password = "password_" + index;
        obj.setPassword(password);
    }
    
    public void EMEmployeeDataOnDemand.setStatus(EMEmployee obj, int index) {
        String status = "status_" + index;
        obj.setStatus(status);
    }
    
    public void EMEmployeeDataOnDemand.setUpdatedBy(EMEmployee obj, int index) {
        String updatedBy = "updatedBy_" + index;
        obj.setUpdatedBy(updatedBy);
    }
    
    public void EMEmployeeDataOnDemand.setUpdatedDate(EMEmployee obj, int index) {
        Date updatedDate = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setUpdatedDate(updatedDate);
    }
    
    public void EMEmployeeDataOnDemand.setUserName(EMEmployee obj, int index) {
        String userName = "userName_" + index;
        obj.setUserName(userName);
    }
    
    public EMEmployee EMEmployeeDataOnDemand.getSpecificEMEmployee(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        EMEmployee obj = data.get(index);
        Long id = obj.getId();
        return EMEmployee.findEMEmployee(id);
    }
    
    public EMEmployee EMEmployeeDataOnDemand.getRandomEMEmployee() {
        init();
        EMEmployee obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return EMEmployee.findEMEmployee(id);
    }
    
    public boolean EMEmployeeDataOnDemand.modifyEMEmployee(EMEmployee obj) {
        return false;
    }
    
    public void EMEmployeeDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = EMEmployee.findEMEmployeeEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'EMEmployee' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<EMEmployee>();
        for (int i = 0; i < 10; i++) {
            EMEmployee obj = getNewTransientEMEmployee(i);
            try {
                obj.persist();
            } catch (final ConstraintViolationException e) {
                final StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    final ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
                }
                throw new IllegalStateException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
