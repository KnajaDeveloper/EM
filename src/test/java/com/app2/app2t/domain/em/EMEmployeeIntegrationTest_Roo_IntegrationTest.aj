// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.domain.em;

import com.app2.app2t.domain.em.EMEmployee;
import com.app2.app2t.domain.em.EMEmployeeDataOnDemand;
import com.app2.app2t.domain.em.EMEmployeeIntegrationTest;
import java.util.Iterator;
import java.util.List;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect EMEmployeeIntegrationTest_Roo_IntegrationTest {
    
    declare @type: EMEmployeeIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: EMEmployeeIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: EMEmployeeIntegrationTest: @Transactional;
    
    @Autowired
    EMEmployeeDataOnDemand EMEmployeeIntegrationTest.dod;
    
    @Test
    public void EMEmployeeIntegrationTest.testCountEMEmployees() {
        Assert.assertNotNull("Data on demand for 'EMEmployee' failed to initialize correctly", dod.getRandomEMEmployee());
        long count = EMEmployee.countEMEmployees();
        Assert.assertTrue("Counter for 'EMEmployee' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void EMEmployeeIntegrationTest.testFindEMEmployee() {
        EMEmployee obj = dod.getRandomEMEmployee();
        Assert.assertNotNull("Data on demand for 'EMEmployee' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'EMEmployee' failed to provide an identifier", id);
        obj = EMEmployee.findEMEmployee(id);
        Assert.assertNotNull("Find method for 'EMEmployee' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'EMEmployee' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void EMEmployeeIntegrationTest.testFindAllEMEmployees() {
        Assert.assertNotNull("Data on demand for 'EMEmployee' failed to initialize correctly", dod.getRandomEMEmployee());
        long count = EMEmployee.countEMEmployees();
        Assert.assertTrue("Too expensive to perform a find all test for 'EMEmployee', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<EMEmployee> result = EMEmployee.findAllEMEmployees();
        Assert.assertNotNull("Find all method for 'EMEmployee' illegally returned null", result);
        Assert.assertTrue("Find all method for 'EMEmployee' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void EMEmployeeIntegrationTest.testFindEMEmployeeEntries() {
        Assert.assertNotNull("Data on demand for 'EMEmployee' failed to initialize correctly", dod.getRandomEMEmployee());
        long count = EMEmployee.countEMEmployees();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<EMEmployee> result = EMEmployee.findEMEmployeeEntries(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'EMEmployee' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'EMEmployee' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void EMEmployeeIntegrationTest.testFlush() {
        EMEmployee obj = dod.getRandomEMEmployee();
        Assert.assertNotNull("Data on demand for 'EMEmployee' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'EMEmployee' failed to provide an identifier", id);
        obj = EMEmployee.findEMEmployee(id);
        Assert.assertNotNull("Find method for 'EMEmployee' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyEMEmployee(obj);
        Integer currentVersion = obj.getVersion();
        obj.flush();
        Assert.assertTrue("Version for 'EMEmployee' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void EMEmployeeIntegrationTest.testMergeUpdate() {
        EMEmployee obj = dod.getRandomEMEmployee();
        Assert.assertNotNull("Data on demand for 'EMEmployee' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'EMEmployee' failed to provide an identifier", id);
        obj = EMEmployee.findEMEmployee(id);
        boolean modified =  dod.modifyEMEmployee(obj);
        Integer currentVersion = obj.getVersion();
        EMEmployee merged = (EMEmployee)obj.merge();
        obj.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'EMEmployee' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void EMEmployeeIntegrationTest.testPersist() {
        Assert.assertNotNull("Data on demand for 'EMEmployee' failed to initialize correctly", dod.getRandomEMEmployee());
        EMEmployee obj = dod.getNewTransientEMEmployee(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'EMEmployee' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'EMEmployee' identifier to be null", obj.getId());
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
        Assert.assertNotNull("Expected 'EMEmployee' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void EMEmployeeIntegrationTest.testRemove() {
        EMEmployee obj = dod.getRandomEMEmployee();
        Assert.assertNotNull("Data on demand for 'EMEmployee' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'EMEmployee' failed to provide an identifier", id);
        obj = EMEmployee.findEMEmployee(id);
        obj.remove();
        obj.flush();
        Assert.assertNull("Failed to remove 'EMEmployee' with identifier '" + id + "'", EMEmployee.findEMEmployee(id));
    }
    
}
