package com.app2.app2t.domain.em;
import com.app2.app2t.base.BaseEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import org.springframework.roo.addon.json.RooJson;

@RooJavaBean
@RooToString
@RooJpaActiveRecord(inheritanceType = "TABLE_PER_CLASS")
@RooJson
public class EMEmployee extends BaseEntity {

    /**
     */
    private String empCode;

    /**
     */
    private String empName;

    /**
     */
    private String empFirstName;

    /**
     */
    private String empLastName;

    /**
     */
    private String empNickName;

    /**
     */
    private String email;

    /**
     */
    private String userName;

    /**
     */
    private String password;

    /**
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "emPosition")
    private EMPosition emPosition;

    /**
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "emTeam")
    private EMTeam emTeam;

    /**
     */
    private String roleCode;
}
