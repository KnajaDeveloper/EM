package com.app2.app2t.domain.em;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.expression.spel.ast.Projection;
import javax.persistence.EntityManager;
import java.util.List;

privileged aspect EMPosition_Custom_Jpa_ActiveRecord {

    protected static Logger LOGGER = LoggerFactory.getLogger(EMPosition_Custom_Jpa_ActiveRecord.class);

    public static Criteria EMPosition.queryPositionPagging(
        String positionCode
        ,String positionName
    ){
        Session session = (Session) EMPosition.entityManager().getDelegate();
        Criteria criteria = session.createCriteria(EMPosition.class);
        criteria.add(Restrictions.like("positionCode", "%" + positionCode + "%"));
        criteria.add(Restrictions.like("positionName", "%" + positionName + "%"));
        return criteria;
    }

    public static  List<EMPosition> EMPosition.findPositionDataPagingData(
        String positionCode
        ,String positionName
        ,Integer firstResult
        ,Integer maxResult
    ){
        Criteria criteria = EMPosition.queryPositionPagging(positionCode, positionName)
                .setFirstResult(firstResult)
                .setMaxResults(maxResult);
        return criteria.list();
    }

    public static  Long EMPosition.findPositionDataPagingSize(
        String positionCode
        ,String positionName
    ){
        Criteria criteria = EMPosition.queryPositionPagging(positionCode, positionName)
                .setProjection(Projections.rowCount());
        return (Long) criteria.uniqueResult();
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

    public static EMPosition EMPosition.findDeletePosition(Long positionID) {
        EntityManager ent = EMPosition.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMPosition.class);
        criteria.add(Restrictions.eq("id", positionID));
        List<EMPosition> em = criteria.list();
        EMPosition emPositions = em.get(0);
        emPositions.remove();
        return emPositions;
    }

    public static List<EMPosition> EMPosition.findCheckPositionCode(String positionCode) {
        EntityManager ent = EMPosition.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMPosition.class);
        criteria.add(Restrictions.eq("positionCode", positionCode));
        return criteria.list();
    }
    public static List<EMPosition> EMPosition.findPositionByID(Long emPosition) {
        EntityManager ent = EMPosition.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMPosition.class);
        criteria.add(Restrictions.eq("id", emPosition));
        return criteria.list();
    }
}