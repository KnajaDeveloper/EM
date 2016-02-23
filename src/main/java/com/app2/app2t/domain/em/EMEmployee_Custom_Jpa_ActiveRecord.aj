// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.app2.app2t.domain.em;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import javax.persistence.EntityManager;
import java.util.List;

privileged aspect EMEmployee_Custom_Jpa_ActiveRecord {
    public static List<EMEmployee> EMEmployee.findProjectByemPosition(String empCode) {
        EntityManager ent = EMEmployee.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMEmployee.class);
        criteria.add(Restrictions.like("empCode", "%" + empCode + "%"));
        criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        return criteria.list();

    }

    public static List<EMEmployee> EMEmployee.findProjectByemTeam(Long emTeam) {
        EntityManager ent = EMEmployee.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMEmployee.class, "emEmployee");
        criteria.createAlias("emEmployee.emTeam", "emTeam");
        try {

            criteria.add(Restrictions.eq("emTeam.id", emTeam));
            List<EMEmployee> emEmployees = criteria.list();
//            EMEmployee emEmployee = emEmployees.get(0);
//            System.out.print( emEmployee.getPassword());
        } catch (IndexOutOfBoundsException e) {
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

    //---------getEmpNameByUsername-----------------------------------------------------------------------------------------------------------
    public static List<EMEmployee> EMEmployee.findEMNameByUserName(String userName) {
        EntityManager ent = EMEmployee.entityManager();
        Criteria criteria = ((Session) ent.getDelegate()).createCriteria(EMEmployee.class);
        criteria.add(Restrictions.eq("userName", userName));
        return criteria.list();
    }
}
