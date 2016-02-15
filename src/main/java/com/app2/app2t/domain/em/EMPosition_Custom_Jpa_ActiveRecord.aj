package com.app2.app2t.domain.em;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.EntityManager;
import java.util.List;

privileged aspect EMPosition_Custom_Jpa_ActiveRecord {

    protected static Logger LOGGER = LoggerFactory.getLogger(EMPosition_Custom_Jpa_ActiveRecord.class);

    public static List<EMPosition> EMPosition.findAllProject() {
        EntityManager ent = EMPosition.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMPosition.class);
        return criteria.list();
    }

    public static List<EMPosition> EMPosition.findProjectByposition(String positionCode, String positionName) {
        EntityManager ent = EMPosition.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMPosition.class);
        criteria.add(Restrictions.like("positionCode", "%" + positionCode + "%"));
        criteria.add(Restrictions.like("positionName", "%" + positionName + "%"));
        return criteria.list();
    }

    public static List<EMPosition> EMPosition.findeditEMPosition(String positionCode, String positionName) {
        EntityManager ent = EMPosition.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMPosition.class);
        criteria.add(Restrictions.eq("positionCode", positionCode));
        List<EMPosition> em = criteria.list();
        EMPosition edEMPosition = em.get(0);
        edEMPosition.setPositionName(positionName);
        edEMPosition.merge();
        return criteria.list();
    }

    public static List<EMPosition> EMPosition.findDeletePosition(String positionCode) {
        EntityManager ent = EMPosition.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMPosition.class);
        criteria.add(Restrictions.eq("positionCode", positionCode));
        List<EMPosition> em = criteria.list();
        EMPosition deEMPosition = em.get(0);
        deEMPosition.remove();
        return criteria.list();
    }

    public static List<EMPosition> EMPosition.findProjectBypositionCode(String positionCode) {
        EntityManager ent = EMPosition.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMPosition.class);
        criteria.add(Restrictions.eq("positionCode", positionCode));
        return criteria.list();
    }
}