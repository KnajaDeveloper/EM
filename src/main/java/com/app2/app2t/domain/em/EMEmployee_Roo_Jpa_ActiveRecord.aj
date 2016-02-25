// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.domain.em;

import com.app2.app2t.domain.em.EMEmployee;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;

privileged aspect EMEmployee_Roo_Jpa_ActiveRecord {
    
    public static final List<String> EMEmployee.fieldNames4OrderClauseFilter = java.util.Arrays.asList("empCode", "empName", "empFirstName", "empLastName", "empNickName", "email", "userName", "password", "emPosition", "emTeam", "roleCode");
    
    public static long EMEmployee.countEMEmployees() {
        return entityManager().createQuery("SELECT COUNT(o) FROM EMEmployee o", Long.class).getSingleResult();
    }
    
    public static List<EMEmployee> EMEmployee.findAllEMEmployees() {
        return entityManager().createQuery("SELECT o FROM EMEmployee o", EMEmployee.class).getResultList();
    }
    
    public static List<EMEmployee> EMEmployee.findAllEMEmployees(String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM EMEmployee o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, EMEmployee.class).getResultList();
    }
    
    public static EMEmployee EMEmployee.findEMEmployee(Long id) {
        if (id == null) return null;
        return entityManager().find(EMEmployee.class, id);
    }
    
    public static List<EMEmployee> EMEmployee.findEMEmployeeEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM EMEmployee o", EMEmployee.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    public static List<EMEmployee> EMEmployee.findEMEmployeeEntries(int firstResult, int maxResults, String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM EMEmployee o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, EMEmployee.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public EMEmployee EMEmployee.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        EMEmployee merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}
