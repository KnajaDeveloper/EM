// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.domain.em;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.List;

privileged aspect EMTeam_Custom_Jpa_ActiveRecord {

    protected static Logger LOGGER = LoggerFactory.getLogger(EMTeam_Custom_Jpa_ActiveRecord.class);

    public static Criteria EMTeam.findProjectBytypeTeamCode(String teamCode, String teamName) {
        EntityManager ent = EMTeam.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMTeam.class);
        try {
        if(teamCode == "" && teamName =="") {

            criteria.list();
        }
        else if(teamCode != "" && teamName !="") {
            criteria.add(Restrictions.like("teamCode", "%"+teamCode+"%" ));
            criteria.add(Restrictions.like("teamName", "%"+teamName+"%"));
        }
        else if(teamCode != "" )
        {
            criteria.add(Restrictions.like("teamCode",  "%"+teamCode+"%"));
        }
        else if(teamName != "" )
        {
            criteria.add(Restrictions.like("teamName",  "%"+teamName+"%"));
        }

//            List<EMTeam> emTeams = criteria.list();
//            EMTeam emTeam = emTeams.get(0);
//            emTeam.getId();
            return criteria ;
        }
        catch (Exception e){
            LOGGER.error("{}:" + e);
        }

        return null;
    }

    @Transactional
    public static List<EMTeam> EMTeam.findDeleteTeam(String teamCode) {
        EntityManager ent = EMTeam.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMTeam.class);
        criteria.add(Restrictions.eq("teamCode", teamCode));
        List<EMTeam> emTeams = criteria.list();
        EMTeam emTeam = emTeams.get(0);
        emTeam.remove();
        return criteria.list();
    }


    @Transactional
    public static List<EMTeam> EMTeam.findEditTeam(String editCode,String editName) {
        EntityManager ent = EMTeam.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMTeam.class);
        criteria.add(Restrictions.eq("teamCode", editCode));
        List<EMTeam> emTeams = criteria.list();
        EMTeam emTeam = emTeams.get(0);
        emTeam.setTeamName(editName);
        emTeam.merge();
        return criteria.list();
    }

    @Transactional
    public static List<EMTeam> EMTeam.findCheck(String teamCode) {
        EntityManager ent = EMTeam.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMTeam.class);
        try {
            criteria.add(Restrictions.eq("teamCode", teamCode));
            List<EMTeam> emTeams = criteria.list();
            EMTeam emTeam = emTeams.get(0);
//            System.out.print( emTeam.getTeamCode());
        }catch (IndexOutOfBoundsException e)
        {

            return criteria.list();

        }

        return criteria.list();
    }

    public static List<EMTeam> EMTeam.finTeamOfDataPagingData(String teamCode,
                                                                 String teamName,
                                                                   Integer maxResult,
                                                                   Integer firstResult

    ){
        Criteria criteria = EMTeam.findProjectBytypeTeamCode(teamCode,teamName)
                .setFirstResult(firstResult)
                .setMaxResults(maxResult);
        return criteria.list();
    }
    public static  Long EMTeam.finTeamOfDataPagingSize(String teamCode,
                                                       String teamName
    ){
        Criteria criteria = EMTeam.findProjectBytypeTeamCode(teamCode,teamName)
                .setProjection(Projections.rowCount());
        return (Long) criteria.uniqueResult();
    }
}
