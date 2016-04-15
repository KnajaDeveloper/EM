package com.app2.app2t.domain.em;
import com.app2.app2t.base.BaseEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import org.springframework.roo.addon.json.RooJson;
import javax.validation.constraints.Size;

@RooJavaBean
@RooToString
@RooJpaActiveRecord(inheritanceType = "TABLE_PER_CLASS")
@RooJson
public class EMEmployee extends BaseEntity {

    /**
     */
    @Size(max = 15)
    private String empCode;

    /**
     */
    @Size(max = 40)
    private String empName;

    /**
     */
    @Size(max = 40)
    private String empFirstName;

    /**
     */
    @Size(max = 40)
    private String empLastName;

    /**
     */
    @Size(max = 40)
    private String empNickName;

    /**
     */
    @Size(max = 40)
    private String email;

    /**
     */
    @Size(max = 40)
    private String userName;

    /**
     */
    @Size(max = 40)
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
    @Size(max = 40)
    private String roleCode;
}
