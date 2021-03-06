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
import java.util.Map;

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
    public static List<EMTeam> EMTeam.deleteTeam(String teamCode) {
        EntityManager ent = EMTeam.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMTeam.class);
        criteria.add(Restrictions.eq("teamCode", teamCode));
        List<EMTeam> emTeams = criteria.list();
        EMTeam emTeam = emTeams.get(0);
        emTeam.remove();
        return criteria.list();
    }


    @Transactional
    public static boolean EMTeam.editTeam(String editCode,String editName,Integer version) {
        boolean status = false;
        EntityManager ent = EMTeam.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMTeam.class);
        criteria.add(Restrictions.eq("teamCode", editCode));
        List<EMTeam> emTeams = criteria.list();
        EMTeam emTeam = emTeams.get(0);
        if(emTeam.getVersion() == version){
            emTeam.setTeamName(editName);
            emTeam.merge();
            status = true ;
        }

        return status ;
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
    public static long EMEmployee.findEMEmployeeCheckID(long projectId) {
        EntityManager ent = EMEmployee.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMEmployee.class, "emEmployee");
        criteria.createAlias("emEmployee.emTeam", "emTeam");
        criteria.add(Restrictions.eq("emTeam.id", projectId));
        criteria.setProjection(Projections.rowCount());
        return (long) criteria.uniqueResult();
    }

    public static List<EMTeam> EMTeam.findTeamAll() {
        EntityManager ent = EMTeam.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMTeam.class);
        return criteria.list();
    }
    public static List<EMTeam> EMTeam.findTeamByID(Long emTeam) {
        EntityManager ent = EMTeam.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMTeam.class);
        criteria.add(Restrictions.eq("id", emTeam));
        return criteria.list();
    }

    public static List<EMTeam> EMTeam.findAllEmployeeByTeamId(Long emTeam) {
        EntityManager ent = EMTeam.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMEmployee.class, "emEmployee");
        criteria.createAlias("emEmployee.emTeam", "emTeam");
        criteria.add(Restrictions.eq("emTeam.id", emTeam));
        criteria.setProjection(Projections.property("emEmployee.empCode"));
        List<EMTeam> listEm =  criteria.list();
        return listEm;
    }

}
