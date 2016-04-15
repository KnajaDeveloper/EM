package com.app2.app2t.domain.em;
import com.app2.app2t.base.BaseEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.json.RooJson;
import javax.validation.constraints.Size;

@RooJavaBean
@RooToString
@RooJpaActiveRecord(inheritanceType = "TABLE_PER_CLASS")
@RooJson
public class EMTeam extends BaseEntity {

    /**
     */
    @Size(max = 15)
    private String teamCode;

    /**
     */
    @Size(max = 40)
    private String teamName;


}
