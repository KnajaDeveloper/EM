
-- EMPOSITION
-- INSERT INTO "APP2"."EMPOSITION" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,POSITION_CODE,POSITION_NAME) VALUES (100001,null,null,null,null,null,0,'P001','Software Developer Trainee');
-- INSERT INTO "APP2"."EMPOSITION" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,POSITION_CODE,POSITION_NAME) VALUES (100002,null,null,null,null,null,0,'P002','Business Analysis');
-- INSERT INTO "APP2"."EMPOSITION" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,POSITION_CODE,POSITION_NAME) VALUES (100003,null,null,null,null,null,0,'P003','Software Developer');
-- INSERT INTO "APP2"."EMPOSITION" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,POSITION_CODE,POSITION_NAME) VALUES (100004,null,null,null,null,null,0,'P004','Project Manager');

-- EMTEAM
-- INSERT INTO "APP2"."EMTEAM" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,TEAM_CODE,TEAM_NAME) VALUES (100001,null,null,null,null,null,0,'T001','Lomanoi');
-- INSERT INTO "APP2"."EMTEAM" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,TEAM_CODE,TEAM_NAME) VALUES (100002,null,null,null,null,null,0,'T002','Soft Soft');
-- INSERT INTO "APP2"."EMTEAM" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,TEAM_CODE,TEAM_NAME) VALUES (100003,null,null,null,null,null,0,'T003','Changnoimommam');
-- INSERT INTO "APP2"."EMTEAM" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,TEAM_CODE,TEAM_NAME) VALUES (100004,null,null,null,null,null,0,'T004','Finally');

-- EMEMPLOYEE
-- INSERT INTO "APP2"."EMEMPLOYEE" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,EMAIL,EMP_CODE,EMP_FIRST_NAME,EMP_LAST_NAME,EMP_NAME,EMP_NICK_NAME,PASSWORD,ROLE_CODE,USER_NAME,EM_POSITION,EM_TEAM) VALUES (100001,null,null,null,null,null,1,'a@email.com','EM001','กิตติศักดิ์','บำรุงเขต',null,'เอ','em001_kittisuk','RL002','em001_kittisuk',100001,100002);
-- INSERT INTO "APP2"."EMEMPLOYEE" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,EMAIL,EMP_CODE,EMP_FIRST_NAME,EMP_LAST_NAME,EMP_NAME,EMP_NICK_NAME,PASSWORD,ROLE_CODE,USER_NAME,EM_POSITION,EM_TEAM) VALUES (100002,null,null,null,null,null,1,'b@email.com','EM002','โฆสิต','พงษ์ไพร',null,'บี','em002_kosit','RL002','em002_kosit',100001,100002);
-- INSERT INTO "APP2"."EMEMPLOYEE" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,EMAIL,EMP_CODE,EMP_FIRST_NAME,EMP_LAST_NAME,EMP_NAME,EMP_NICK_NAME,PASSWORD,ROLE_CODE,USER_NAME,EM_POSITION,EM_TEAM) VALUES (100003,null,null,null,null,null,1,'c@email.com','EM003','ชยณัฐ','ลภนะพันธ์',null,'ซี','em003_chayanut','RL002','em003_chayanut',100001,100002);
-- INSERT INTO "APP2"."EMEMPLOYEE" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,EMAIL,EMP_CODE,EMP_FIRST_NAME,EMP_LAST_NAME,EMP_NAME,EMP_NICK_NAME,PASSWORD,ROLE_CODE,USER_NAME,EM_POSITION,EM_TEAM) VALUES (100004,null,null,null,null,null,1,'d@email.com','EM004','ชยธร','พัฒนศักดิ์ภิญโญ',null,'ดี','em004_chayathorn','RL002','em004_chayathorn',100003,100002);
-- INSERT INTO "APP2"."EMEMPLOYEE" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,EMAIL,EMP_CODE,EMP_FIRST_NAME,EMP_LAST_NAME,EMP_NAME,EMP_NICK_NAME,PASSWORD,ROLE_CODE,USER_NAME,EM_POSITION,EM_TEAM) VALUES (100005,null,null,null,null,null,1,'e@email.com','EM005','ณัฐดนัย','ศรีดาวงษ์',null,'อี','em005_nutdanai','RL002','em005_nutdanai',100003,100002);
-- INSERT INTO "APP2"."EMEMPLOYEE" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,EMAIL,EMP_CODE,EMP_FIRST_NAME,EMP_LAST_NAME,EMP_NAME,EMP_NICK_NAME,PASSWORD,ROLE_CODE,USER_NAME,EM_POSITION,EM_TEAM) VALUES (100006,null,null,null,null,null,1,'f@email.com','EM006','พรกนก','นิ่มสำลี',null,'เอฟ','em006_pornkanok','RL002','em006_pornkanok',100002,100002);
-- INSERT INTO "APP2"."EMEMPLOYEE" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,EMAIL,EMP_CODE,EMP_FIRST_NAME,EMP_LAST_NAME,EMP_NAME,EMP_NICK_NAME,PASSWORD,ROLE_CODE,USER_NAME,EM_POSITION,EM_TEAM) VALUES (100007,null,null,null,null,null,1,'g@email.com','EM007','พจน์','ปุญญฤทธิ์',null,'จี','em007_poog','RL002','em007_poog',100004,100002);
-- INSERT INTO "APP2"."EMEMPLOYEE" (ID,CREATED_BY,CREATED_DATE,STATUS,UPDATED_BY,UPDATED_DATE,VERSION,EMAIL,EMP_CODE,EMP_FIRST_NAME,EMP_LAST_NAME,EMP_NAME,EMP_NICK_NAME,PASSWORD,ROLE_CODE,USER_NAME,EM_POSITION,EM_TEAM) VALUES (100008,null,null,null,null,null,1,'f@email.com','EM008','ภัคพล','แสงมณี',null,'เอฟ','em008_pukkapon','RL002','em008_pukkapon',100004,100001);
