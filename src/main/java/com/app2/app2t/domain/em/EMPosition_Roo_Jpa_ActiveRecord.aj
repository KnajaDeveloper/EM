// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.domain.em;

import com.app2.app2t.domain.em.EMPosition;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;

privileged aspect EMPosition_Roo_Jpa_ActiveRecord {
    
    public static final List<String> EMPosition.fieldNames4OrderClauseFilter = java.util.Arrays.asList("positionCode", "positionName");
    
    public static long EMPosition.countEMPositions() {
        return entityManager().createQuery("SELECT COUNT(o) FROM EMPosition o", Long.class).getSingleResult();
    }
    
    public static List<EMPosition> EMPosition.findAllEMPositions() {
        return entityManager().createQuery("SELECT o FROM EMPosition o", EMPosition.class).getResultList();
    }
    
    public static List<EMPosition> EMPosition.findAllEMPositions(String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM EMPosition o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, EMPosition.class).getResultList();
    }
    
    public static EMPosition EMPosition.findEMPosition(Long id) {
        if (id == null) return null;
        return entityManager().find(EMPosition.class, id);
    }
    
    public static List<EMPosition> EMPosition.findEMPositionEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM EMPosition o", EMPosition.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    public static List<EMPosition> EMPosition.findEMPositionEntries(int firstResult, int maxResults, String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM EMPosition o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, EMPosition.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public EMPosition EMPosition.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        EMPosition merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}
