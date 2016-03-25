// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.domain.em;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.*;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.EntityManager;
import java.util.List;

privileged aspect EMEmployee_Custom_Jpa_ActiveRecord {
    protected static Logger LOGGER = LoggerFactory.getLogger(EMEmployee_Custom_Jpa_ActiveRecord.class);

    public static List<EMEmployee> EMEmployee.findProjectByemTeam(Long emTeam) {
        EntityManager ent = EMEmployee.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMEmployee.class, "emEmployee");
        criteria.createAlias("emEmployee.emTeam", "emTeam");
        try {

            criteria.add(Restrictions.eq("emTeam.id", emTeam));
            List<EMEmployee> emEmployees = criteria.list();
//            EMEmployee emEmployee = emEmployees.get(0);
//            System.out.print( emEmployee.getPassword());
        } catch (Exception e) {
            System.out.print(e);
            return criteria.list();
        }
        return criteria.list();
    }


    public static List<EMEmployee> EMEmployee.findProjectByempCode(String empCode) {
        EntityManager ent = EMEmployee.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMEmployee.class);
        criteria.add(Restrictions.eq("empCode", empCode));
        return criteria.list();
    }


//---------getEmpNameByEmpCode-----------------------------------------------------------------------------------------------------------

    public static List<EMEmployee> EMEmployee.findEmpNameByEmpCode(String empCode) {
        EntityManager ent = EMEmployee.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMEmployee.class);
        criteria.add(Restrictions.eq("empCode", empCode));
        return criteria.list();
    }

    public static EMEmployee EMEmployee.findAppRoleByUserName(String userName) {
        EntityManager ent = EMEmployee.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMEmployee.class);
        criteria.add(Restrictions.eq("userName", userName));
        List<EMEmployee> listEmployee = criteria.list();
        return listEmployee.get(0);
    }

    //---------getEmpNameByUsername-----------------------------------------------------------------------------------------------------------
    public static List<EMEmployee> EMEmployee.findEMNameByUserName(String userName) {
        EntityManager ent = EMEmployee.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMEmployee.class);
        criteria.add(Restrictions.eq("userName", userName));
        return criteria.list();
    }

    public static Criteria EMEmployee.findselectDataAddRole(String empCode, String empFirstName, String empLastName, String emPosition, String emTeam, String appRoleHave) {
        EntityManager ent = EMEmployee.entityManager();
        try {
            Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMEmployee.class, "emEmployee");
            criteria.createAlias("emEmployee.emTeam", "emTeam");
            criteria.createAlias("emEmployee.emPosition", "emPosition");
            criteria.add(Restrictions.like("emEmployee.empCode", "%" + empCode + "%"));
            criteria.add(Restrictions.like("emEmployee.empFirstName", "%" + empFirstName + "%"));
            criteria.add(Restrictions.like("emEmployee.empLastName", "%" + empLastName + "%"));
            if (appRoleHave.equals("1")) {
                criteria.add(Restrictions.isNotNull("emEmployee.roleCode"));
            } else if (appRoleHave.equals("2")) {
                criteria.add(Restrictions.isNull("emEmployee.roleCode"));
            }

            criteria.add(Restrictions.like("emPosition.positionName", "%" + emPosition + "%"));
            criteria.add(Restrictions.like("emTeam.teamName", "%" + emTeam + "%"));
            return criteria;
        }
        catch (Exception e)
        {
            LOGGER.error("{}:"+e);
        }
        return null;
    }


    public static List<EMEmployee> EMEmployee.findSaveOrUpdateAppRoleCode(String empCode,String roleCode) {
        EntityManager ent = EMEmployee.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMEmployee.class);
        criteria.add(Restrictions.eq("empCode", empCode));
        List<EMEmployee> emEmployees = criteria.list();
        EMEmployee emEmployee = emEmployees.get(0);
//        LOGGER.error(emEmployees.get(0)+">>>>>>>>>>>>>>>>>>>>>>><");
        emEmployee.setRoleCode(roleCode);
        emEmployee.merge();
        return criteria.list();
    }

    public static List<EMEmployee> EMEmployee.findselectDataAddRole(String empCode,String empFirstName,
                                                                         String empLastName,String emPosition,
                                                                         String emTeam,String appRoleHave,
                                                                         Integer maxResult,Integer firstResult

    ){
        Criteria criteria = EMEmployee.findselectDataAddRole(empCode,empFirstName,empLastName,emPosition,emTeam,appRoleHave)
                .setFirstResult(firstResult)
                .setMaxResults(maxResult);
        return criteria.list();
    }

    public static  Long EMEmployee.finProjectOfDataPagingSize(String empCode,String empFirstName,
                                                              String empLastName,String emPosition,
                                                              String emTeam,String appRoleHave
    ){
        Criteria criteria = EMEmployee.findselectDataAddRole(empCode,empFirstName,empLastName,emPosition,emTeam,appRoleHave)
                .setProjection(Projections.rowCount());
        return (Long) criteria.uniqueResult();
    }

    public static Long EMEmployee.findEMPositionByID(Long emPosition) {
        Session session = (Session) EMEmployee.entityManager().getDelegate();
        Criteria criteria = session.createCriteria(EMEmployee.class, "emEmployee");
        criteria.createAlias("emEmployee.emPosition", "emPosition");
        criteria.add(Restrictions.eq("emPosition.id", emPosition));
        criteria.setProjection(Projections.rowCount());
        return (Long) criteria.uniqueResult();
    }

    public static List<EMEmployee> EMEmployee.findEmployeeByTextLov(String text) {
        Session session = (Session) EMEmployee.entityManager().getDelegate();
        Criteria criteria = session.createCriteria(EMEmployee.class);
        criteria.add(Restrictions.disjunction()
        .add(Restrictions.ilike("empCode","%"+text+"%"))
        .add(Restrictions.ilike("empName","%"+text+"%"))
        .add(Restrictions.ilike("empFirstName","%"+text+"%"))
        .add(Restrictions.ilike("empLastName","%"+text+"%"))
        .add(Restrictions.ilike("empNickName","%"+text+"%")));
        return criteria.list();
    }

    public static List<String> EMEmployee.findDistinctRoleCode() {
        Session session = (Session) EMEmployee.entityManager().getDelegate();
        Criteria criteria = session.createCriteria(EMEmployee.class);
        criteria.add(Restrictions.isNotNull("roleCode"));
        criteria.setProjection(Projections.distinct(Projections.property("roleCode")));
        return criteria.list();
    }
}
