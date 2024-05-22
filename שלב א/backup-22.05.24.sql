prompt PL/SQL Developer Export Tables for user SYSTEM@XE
prompt Created by User on יום רביעי 22 מאי 2024
set feedback off
set define off

prompt Creating POSITIONS...
create table POSITIONS
(
  positionsid   NUMBER(38) not null,
  positionsname VARCHAR2(255) not null,
  requirements  VARCHAR2(600) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table POSITIONS
  add constraint PK_POSITIONS primary key (POSITIONSID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DEPARTMENT...
create table DEPARTMENT
(
  departmentid   NUMBER(38) not null,
  departmentname VARCHAR2(255) not null,
  numofworkers   NUMBER(38) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DEPARTMENT
  add constraint PK_DEPARTMENT primary key (DEPARTMENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating EMPLOYEE...
create table EMPLOYEE
(
  employeeid   NUMBER(38) not null,
  positionid   NUMBER(38) not null,
  first_name   VARCHAR2(255) not null,
  last_name    VARCHAR2(255) not null,
  departmentid NUMBER(38) not null,
  salary       NUMBER(38) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMPLOYEE
  add constraint PK_EMPLOYEE primary key (EMPLOYEEID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMPLOYEE
  add constraint FK_EMPLOYEE_DEPARTMENT foreign key (DEPARTMENTID)
  references DEPARTMENT (DEPARTMENTID) on delete cascade;
alter table EMPLOYEE
  add constraint FK_EMPLOYEE_POSITION foreign key (POSITIONID)
  references POSITIONS (POSITIONSID) on delete cascade;

prompt Creating ATTENDANCE...
create table ATTENDANCE
(
  employeeid NUMBER(38) not null,
  aten_date  DATE not null,
  status     VARCHAR2(255) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ATTENDANCE
  add constraint PK_ATTENDANCE primary key (EMPLOYEEID, ATEN_DATE)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ATTENDANCE
  add constraint FK_ATTENDANCE foreign key (EMPLOYEEID)
  references EMPLOYEE (EMPLOYEEID);

prompt Creating DEVELOPMENT...
create table DEVELOPMENT
(
  developmentid   NUMBER(38) not null,
  departmentid    NUMBER(38) not null,
  initiative_type VARCHAR2(255) not null,
  initiative_date DATE not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DEVELOPMENT
  add constraint PK_DEVELOPMENT primary key (DEVELOPMENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DEVELOPMENT
  add constraint FK_DEVELOPMENT foreign key (DEPARTMENTID)
  references DEPARTMENT (DEPARTMENTID);

prompt Creating HUMAN_RESOURCE_MANAGEMENT...
create table HUMAN_RESOURCE_MANAGEMENT
(
  hractionid  NUMBER(38) not null,
  actiontype  VARCHAR2(255) not null,
  hra_date    DATE not null,
  description VARCHAR2(600) not null,
  employeeid  NUMBER(38) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HUMAN_RESOURCE_MANAGEMENT
  add constraint PK_HUMAN_RESOURCE_MANAGEMENT primary key (HRACTIONID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HUMAN_RESOURCE_MANAGEMENT
  add constraint FK_HUMAN_RESOURCE_MANAGEMENT foreign key (EMPLOYEEID)
  references EMPLOYEE (EMPLOYEEID) on delete cascade;

prompt Disabling triggers for POSITIONS...
alter table POSITIONS disable all triggers;
prompt Disabling triggers for DEPARTMENT...
alter table DEPARTMENT disable all triggers;
prompt Disabling triggers for EMPLOYEE...
alter table EMPLOYEE disable all triggers;
prompt Disabling triggers for ATTENDANCE...
alter table ATTENDANCE disable all triggers;
prompt Disabling triggers for DEVELOPMENT...
alter table DEVELOPMENT disable all triggers;
prompt Disabling triggers for HUMAN_RESOURCE_MANAGEMENT...
alter table HUMAN_RESOURCE_MANAGEMENT disable all triggers;
prompt Disabling foreign key constraints for EMPLOYEE...
alter table EMPLOYEE disable constraint FK_EMPLOYEE_DEPARTMENT;
alter table EMPLOYEE disable constraint FK_EMPLOYEE_POSITION;
prompt Disabling foreign key constraints for ATTENDANCE...
alter table ATTENDANCE disable constraint FK_ATTENDANCE;
prompt Disabling foreign key constraints for DEVELOPMENT...
alter table DEVELOPMENT disable constraint FK_DEVELOPMENT;
prompt Disabling foreign key constraints for HUMAN_RESOURCE_MANAGEMENT...
alter table HUMAN_RESOURCE_MANAGEMENT disable constraint FK_HUMAN_RESOURCE_MANAGEMENT;
prompt Deleting HUMAN_RESOURCE_MANAGEMENT...
delete from HUMAN_RESOURCE_MANAGEMENT;
commit;
prompt Deleting DEVELOPMENT...
delete from DEVELOPMENT;
commit;
prompt Deleting ATTENDANCE...
delete from ATTENDANCE;
commit;
prompt Deleting EMPLOYEE...
delete from EMPLOYEE;
commit;
prompt Deleting DEPARTMENT...
delete from DEPARTMENT;
commit;
prompt Deleting POSITIONS...
delete from POSITIONS;
commit;
prompt Loading POSITIONS...
insert into POSITIONS (positionsid, positionsname, requirements)
values (1, 'Coordinator', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (2, 'Team Lead', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.' || chr(10) || '' || chr(10) || 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (3, 'Specialist', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (4, 'Manager', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (5, 'Specialist', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (6, 'Specialist', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (7, 'Specialist', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (8, 'Manager', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (9, 'Specialist', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (10, 'Specialist', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (11, 'Team Lead', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (12, 'Coordinator', 'Fusce consequat. Nulla nisl. Nunc nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (13, 'Specialist', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.' || chr(10) || '' || chr(10) || 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (14, 'Manager', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (15, 'Supervisor', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' || chr(10) || '' || chr(10) || 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (16, 'Specialist', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (17, 'Specialist', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.' || chr(10) || '' || chr(10) || 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (18, 'Supervisor', 'In congue. Etiam justo. Etiam pretium iaculis justo.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (19, 'Specialist', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.' || chr(10) || '' || chr(10) || 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (20, 'Team Lead', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (21, 'Manager', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' || chr(10) || '' || chr(10) || 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (22, 'Supervisor', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (23, 'Team Lead', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (24, 'Supervisor', 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (25, 'Manager', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (26, 'Manager', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (27, 'Coordinator', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (28, 'Specialist', 'In congue. Etiam justo. Etiam pretium iaculis justo.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (29, 'Supervisor', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (30, 'Manager', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.' || chr(10) || '' || chr(10) || 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (31, 'Specialist', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (32, 'Manager', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (33, 'Manager', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (34, 'Coordinator', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (35, 'Coordinator', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (36, 'Supervisor', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' || chr(10) || '' || chr(10) || 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (37, 'Coordinator', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (38, 'Manager', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.' || chr(10) || '' || chr(10) || 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (39, 'Specialist', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (40, 'Team Lead', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (41, 'Team Lead', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.' || chr(10) || '' || chr(10) || 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (42, 'Supervisor', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (43, 'Specialist', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (44, 'Coordinator', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (45, 'Team Lead', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (46, 'Team Lead', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (47, 'Manager', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (48, 'Coordinator', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (49, 'Manager', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' || chr(10) || '' || chr(10) || 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (50, 'Manager', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (51, 'Manager', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (52, 'Supervisor', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (53, 'Manager', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (54, 'Specialist', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.' || chr(10) || '' || chr(10) || 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.' || chr(10) || '' || chr(10) || 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (55, 'Specialist', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (56, 'Manager', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.' || chr(10) || '' || chr(10) || 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (57, 'Team Lead', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (58, 'Supervisor', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (59, 'Coordinator', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (60, 'Team Lead', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (61, 'Team Lead', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.' || chr(10) || '' || chr(10) || 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (62, 'Specialist', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (63, 'Team Lead', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (64, 'Specialist', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (65, 'Team Lead', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (66, 'Manager', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (67, 'Team Lead', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (68, 'Team Lead', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.' || chr(10) || '' || chr(10) || 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (69, 'Team Lead', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (70, 'Manager', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (71, 'Specialist', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (72, 'Manager', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.' || chr(10) || '' || chr(10) || 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (73, 'Coordinator', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (74, 'Manager', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (75, 'Coordinator', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (76, 'Team Lead', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.' || chr(10) || '' || chr(10) || 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (77, 'Manager', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (78, 'Supervisor', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (79, 'Team Lead', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (80, 'Manager', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (81, 'Specialist', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (82, 'Specialist', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (83, 'Specialist', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (84, 'Supervisor', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' || chr(10) || '' || chr(10) || 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (85, 'Coordinator', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (86, 'Coordinator', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (87, 'Supervisor', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.' || chr(10) || '' || chr(10) || 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (88, 'Manager', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (89, 'Specialist', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' || chr(10) || '' || chr(10) || 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (90, 'Specialist', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.' || chr(10) || '' || chr(10) || 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (91, 'Manager', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (92, 'Supervisor', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (93, 'Team Lead', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (94, 'Coordinator', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (95, 'Manager', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (96, 'Supervisor', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (97, 'Coordinator', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.' || chr(10) || '' || chr(10) || 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (98, 'Coordinator', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (99, 'Specialist', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (100, 'Specialist', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (101, 'Manager', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (102, 'Supervisor', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (103, 'Supervisor', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (104, 'Team Lead', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (105, 'Team Lead', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (106, 'Specialist', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (107, 'Supervisor', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (108, 'Manager', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.' || chr(10) || '' || chr(10) || 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (109, 'Manager', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (110, 'Team Lead', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (111, 'Team Lead', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (112, 'Manager', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (113, 'Team Lead', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.' || chr(10) || '' || chr(10) || 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (114, 'Team Lead', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (115, 'Supervisor', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (116, 'Team Lead', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.' || chr(10) || '' || chr(10) || 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (117, 'Supervisor', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (118, 'Supervisor', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (119, 'Specialist', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (120, 'Manager', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (121, 'Supervisor', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.' || chr(10) || '' || chr(10) || 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.' || chr(10) || '' || chr(10) || 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (122, 'Team Lead', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (123, 'Supervisor', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (124, 'Team Lead', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (125, 'Team Lead', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.' || chr(10) || '' || chr(10) || 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (126, 'Supervisor', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (127, 'Coordinator', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (128, 'Manager', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (129, 'Team Lead', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (130, 'Coordinator', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (131, 'Coordinator', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' || chr(10) || '' || chr(10) || 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (132, 'Specialist', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (133, 'Team Lead', 'Fusce consequat. Nulla nisl. Nunc nisl.' || chr(10) || '' || chr(10) || 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (134, 'Specialist', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (135, 'Team Lead', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' || chr(10) || '' || chr(10) || 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (136, 'Specialist', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (137, 'Specialist', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' || chr(10) || '' || chr(10) || 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (138, 'Team Lead', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (139, 'Manager', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (140, 'Specialist', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (141, 'Manager', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.' || chr(10) || '' || chr(10) || 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (142, 'Specialist', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (143, 'Supervisor', 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (144, 'Coordinator', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (145, 'Team Lead', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.' || chr(10) || '' || chr(10) || 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.' || chr(10) || '' || chr(10) || 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (146, 'Manager', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (147, 'Coordinator', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.' || chr(10) || '' || chr(10) || 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (148, 'Team Lead', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (149, 'Coordinator', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (150, 'Manager', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (151, 'Specialist', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (152, 'Specialist', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (153, 'Team Lead', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (154, 'Manager', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (155, 'Specialist', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (156, 'Manager', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (157, 'Supervisor', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (158, 'Team Lead', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.' || chr(10) || '' || chr(10) || 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (159, 'Manager', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.' || chr(10) || '' || chr(10) || 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (160, 'Supervisor', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (161, 'Supervisor', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.' || chr(10) || '' || chr(10) || 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (162, 'Team Lead', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (163, 'Specialist', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (164, 'Coordinator', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' || chr(10) || '' || chr(10) || 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (165, 'Coordinator', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (166, 'Manager', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (167, 'Coordinator', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (168, 'Manager', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (169, 'Team Lead', 'In congue. Etiam justo. Etiam pretium iaculis justo.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (170, 'Manager', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (171, 'Supervisor', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.' || chr(10) || '' || chr(10) || 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (172, 'Coordinator', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (173, 'Specialist', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (174, 'Team Lead', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (175, 'Supervisor', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (176, 'Supervisor', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (177, 'Team Lead', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (178, 'Supervisor', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (179, 'Supervisor', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.' || chr(10) || '' || chr(10) || 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (180, 'Manager', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (181, 'Coordinator', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.' || chr(10) || '' || chr(10) || 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (182, 'Coordinator', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.' || chr(10) || '' || chr(10) || 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (183, 'Coordinator', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (184, 'Supervisor', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (185, 'Manager', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (186, 'Manager', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.' || chr(10) || '' || chr(10) || 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (187, 'Supervisor', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (188, 'Manager', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' || chr(10) || '' || chr(10) || 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (189, 'Manager', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (190, 'Manager', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (191, 'Supervisor', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (192, 'Team Lead', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (193, 'Team Lead', 'Fusce consequat. Nulla nisl. Nunc nisl.' || chr(10) || '' || chr(10) || 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (194, 'Specialist', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.' || chr(10) || '' || chr(10) || 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (195, 'Coordinator', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (196, 'Specialist', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (197, 'Coordinator', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.' || chr(10) || '' || chr(10) || 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (198, 'Supervisor', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (199, 'Coordinator', 'In congue. Etiam justo. Etiam pretium iaculis justo.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.' || chr(10) || '' || chr(10) || 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (200, 'Team Lead', 'Fusce consequat. Nulla nisl. Nunc nisl.' || chr(10) || '' || chr(10) || 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (201, 'Manager', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (202, 'Coordinator', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (203, 'Specialist', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (204, 'Specialist', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (205, 'Manager', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (206, 'Manager', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (207, 'Team Lead', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (208, 'Team Lead', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (209, 'Specialist', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (210, 'Coordinator', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (211, 'Team Lead', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (212, 'Coordinator', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (213, 'Specialist', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (214, 'Supervisor', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (215, 'Supervisor', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (216, 'Supervisor', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (217, 'Specialist', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (218, 'Coordinator', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (219, 'Supervisor', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (220, 'Specialist', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (221, 'Coordinator', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (222, 'Coordinator', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (223, 'Specialist', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (224, 'Specialist', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (225, 'Specialist', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (226, 'Specialist', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (227, 'Team Lead', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.' || chr(10) || '' || chr(10) || 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (228, 'Supervisor', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (229, 'Team Lead', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (230, 'Team Lead', 'Fusce consequat. Nulla nisl. Nunc nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (231, 'Specialist', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (232, 'Manager', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (233, 'Coordinator', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' || chr(10) || '' || chr(10) || 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (234, 'Supervisor', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (235, 'Supervisor', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' || chr(10) || '' || chr(10) || 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (236, 'Supervisor', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (237, 'Manager', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (238, 'Manager', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (239, 'Team Lead', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (240, 'Specialist', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.' || chr(10) || '' || chr(10) || 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (241, 'Specialist', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (242, 'Specialist', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (243, 'Supervisor', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (244, 'Specialist', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.' || chr(10) || '' || chr(10) || 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (245, 'Specialist', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (246, 'Specialist', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (247, 'Manager', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (248, 'Coordinator', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (249, 'Specialist', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' || chr(10) || '' || chr(10) || 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (250, 'Specialist', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (251, 'Supervisor', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (252, 'Coordinator', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (253, 'Coordinator', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' || chr(10) || '' || chr(10) || 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (254, 'Coordinator', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (255, 'Coordinator', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (256, 'Supervisor', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (257, 'Team Lead', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (258, 'Coordinator', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.' || chr(10) || '' || chr(10) || 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (259, 'Team Lead', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (260, 'Coordinator', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (261, 'Coordinator', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (262, 'Coordinator', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' || chr(10) || '' || chr(10) || 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (263, 'Coordinator', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (264, 'Coordinator', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (265, 'Team Lead', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (266, 'Specialist', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.' || chr(10) || '' || chr(10) || 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (267, 'Supervisor', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' || chr(10) || '' || chr(10) || 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (268, 'Supervisor', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.' || chr(10) || '' || chr(10) || 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (269, 'Specialist', 'In congue. Etiam justo. Etiam pretium iaculis justo.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (270, 'Coordinator', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (271, 'Specialist', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (272, 'Specialist', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (273, 'Coordinator', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (274, 'Manager', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (275, 'Team Lead', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.' || chr(10) || '' || chr(10) || 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (276, 'Specialist', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (277, 'Supervisor', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (278, 'Supervisor', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (279, 'Team Lead', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (280, 'Supervisor', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' || chr(10) || '' || chr(10) || 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (281, 'Team Lead', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (282, 'Manager', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (283, 'Coordinator', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (284, 'Manager', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (285, 'Supervisor', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (286, 'Specialist', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (287, 'Manager', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (288, 'Supervisor', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (289, 'Coordinator', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (290, 'Specialist', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.' || chr(10) || '' || chr(10) || 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (291, 'Supervisor', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (292, 'Manager', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.' || chr(10) || '' || chr(10) || 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (293, 'Team Lead', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (294, 'Specialist', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (295, 'Team Lead', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (296, 'Supervisor', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (297, 'Team Lead', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (298, 'Team Lead', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (299, 'Team Lead', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (300, 'Team Lead', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.' || chr(10) || '' || chr(10) || 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (301, 'Manager', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.' || chr(10) || '' || chr(10) || 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (302, 'Specialist', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (303, 'Team Lead', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (304, 'Team Lead', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.' || chr(10) || '' || chr(10) || 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (305, 'Supervisor', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (306, 'Specialist', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (307, 'Coordinator', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (308, 'Coordinator', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (309, 'Coordinator', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (310, 'Coordinator', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (311, 'Supervisor', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (312, 'Coordinator', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (313, 'Specialist', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (314, 'Manager', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.' || chr(10) || '' || chr(10) || 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (315, 'Team Lead', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (316, 'Specialist', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (317, 'Coordinator', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (318, 'Specialist', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.' || chr(10) || '' || chr(10) || 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (319, 'Team Lead', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (320, 'Specialist', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.' || chr(10) || '' || chr(10) || 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (321, 'Coordinator', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (322, 'Team Lead', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (323, 'Team Lead', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (324, 'Coordinator', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (325, 'Manager', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (326, 'Team Lead', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (327, 'Team Lead', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (328, 'Manager', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (329, 'Team Lead', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (330, 'Supervisor', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (331, 'Specialist', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (332, 'Supervisor', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (333, 'Manager', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.' || chr(10) || '' || chr(10) || 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (334, 'Specialist', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (335, 'Manager', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (336, 'Manager', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (337, 'Specialist', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (338, 'Team Lead', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (339, 'Supervisor', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (340, 'Coordinator', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (341, 'Manager', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (342, 'Supervisor', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (343, 'Supervisor', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (344, 'Team Lead', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' || chr(10) || '' || chr(10) || 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (345, 'Manager', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (346, 'Supervisor', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (347, 'Supervisor', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' || chr(10) || '' || chr(10) || 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (348, 'Team Lead', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.' || chr(10) || '' || chr(10) || 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (349, 'Team Lead', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.' || chr(10) || '' || chr(10) || 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (350, 'Specialist', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (351, 'Coordinator', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.' || chr(10) || '' || chr(10) || 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (352, 'Manager', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.' || chr(10) || '' || chr(10) || 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (353, 'Team Lead', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (354, 'Supervisor', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (355, 'Manager', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (356, 'Manager', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (357, 'Specialist', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (358, 'Specialist', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (359, 'Team Lead', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (360, 'Team Lead', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (361, 'Manager', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (362, 'Manager', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (363, 'Specialist', 'In congue. Etiam justo. Etiam pretium iaculis justo.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (364, 'Supervisor', 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (365, 'Team Lead', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (366, 'Manager', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (367, 'Supervisor', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (368, 'Supervisor', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (369, 'Specialist', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (370, 'Coordinator', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' || chr(10) || '' || chr(10) || 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (371, 'Team Lead', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (372, 'Coordinator', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (373, 'Specialist', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (374, 'Supervisor', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (375, 'Team Lead', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.' || chr(10) || '' || chr(10) || 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (376, 'Manager', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.' || chr(10) || '' || chr(10) || 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (377, 'Specialist', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (378, 'Coordinator', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (379, 'Manager', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.' || chr(10) || '' || chr(10) || 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.' || chr(10) || '' || chr(10) || 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (380, 'Specialist', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (381, 'Supervisor', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (382, 'Manager', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (383, 'Team Lead', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (384, 'Specialist', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (385, 'Supervisor', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (386, 'Team Lead', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (387, 'Coordinator', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (388, 'Supervisor', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.' || chr(10) || '' || chr(10) || 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (389, 'Team Lead', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (390, 'Supervisor', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.' || chr(10) || '' || chr(10) || 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (391, 'Specialist', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (392, 'Coordinator', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (393, 'Coordinator', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (394, 'Specialist', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.' || chr(10) || '' || chr(10) || 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (395, 'Manager', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (396, 'Coordinator', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (397, 'Team Lead', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.' || chr(10) || '' || chr(10) || 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (398, 'Specialist', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.' || chr(10) || '' || chr(10) || 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (399, 'Supervisor', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
insert into POSITIONS (positionsid, positionsname, requirements)
values (400, 'Coordinator', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
commit;
prompt 400 records loaded
prompt Loading DEPARTMENT...
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (1, 'Sales', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (2, 'Marketing', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (3, 'Human Resources', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (4, 'Marketing', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (5, 'Marketing', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (6, 'Sales', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (7, 'Sales', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (8, 'Sales', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (9, 'Finance', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (10, 'Marketing', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (11, 'Human Resources', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (12, 'Sales', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (13, 'Human Resources', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (14, 'Human Resources', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (15, 'Finance', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (16, 'Finance', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (17, 'Human Resources', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (18, 'Finance', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (19, 'Marketing', 17);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (20, 'Marketing', 18);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (21, 'Sales', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (22, 'Human Resources', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (23, 'Finance', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (24, 'Sales', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (25, 'Marketing', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (26, 'Human Resources', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (27, 'Human Resources', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (28, 'Finance', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (29, 'Marketing', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (30, 'Sales', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (31, 'Marketing', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (32, 'Marketing', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (33, 'Finance', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (34, 'Marketing', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (35, 'Sales', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (36, 'Sales', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (37, 'Marketing', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (38, 'Sales', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (39, 'Human Resources', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (40, 'Finance', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (41, 'Finance', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (42, 'Finance', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (43, 'Marketing', 18);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (44, 'Sales', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (45, 'Sales', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (46, 'Sales', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (47, 'Marketing', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (48, 'Marketing', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (49, 'Finance', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (50, 'Finance', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (51, 'Finance', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (52, 'Finance', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (53, 'Finance', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (54, 'Human Resources', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (55, 'Sales', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (56, 'Finance', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (57, 'Sales', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (58, 'Marketing', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (59, 'Marketing', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (60, 'Human Resources', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (61, 'Sales', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (62, 'Finance', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (63, 'Finance', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (64, 'Finance', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (65, 'Marketing', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (66, 'Finance', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (67, 'Marketing', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (68, 'Finance', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (69, 'Human Resources', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (70, 'Marketing', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (71, 'Marketing', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (72, 'Finance', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (73, 'Marketing', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (74, 'Marketing', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (75, 'Finance', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (76, 'Marketing', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (77, 'Sales', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (78, 'Marketing', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (79, 'Marketing', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (80, 'Human Resources', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (81, 'Marketing', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (82, 'Human Resources', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (83, 'Marketing', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (84, 'Finance', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (85, 'Sales', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (86, 'Sales', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (87, 'Sales', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (88, 'Human Resources', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (89, 'Sales', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (90, 'Marketing', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (91, 'Finance', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (92, 'Finance', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (93, 'Marketing', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (94, 'Human Resources', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (95, 'Finance', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (96, 'Sales', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (97, 'Human Resources', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (98, 'Sales', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (99, 'Marketing', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (100, 'Human Resources', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (101, 'Sales', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (102, 'Marketing', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (103, 'Marketing', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (104, 'Sales', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (105, 'Marketing', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (106, 'Marketing', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (107, 'Human Resources', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (108, 'Marketing', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (109, 'Marketing', 18);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (110, 'Sales', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (111, 'Finance', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (112, 'Finance', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (113, 'Marketing', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (114, 'Finance', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (115, 'Human Resources', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (116, 'Marketing', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (117, 'Human Resources', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (118, 'Human Resources', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (119, 'Finance', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (120, 'Sales', 17);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (121, 'Finance', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (122, 'Finance', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (123, 'Finance', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (124, 'Sales', 17);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (125, 'Finance', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (126, 'Marketing', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (127, 'Finance', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (128, 'Sales', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (129, 'Marketing', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (130, 'Sales', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (131, 'Marketing', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (132, 'Sales', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (133, 'Human Resources', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (134, 'Human Resources', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (135, 'Marketing', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (136, 'Human Resources', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (137, 'Sales', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (138, 'Human Resources', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (139, 'Marketing', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (140, 'Human Resources', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (141, 'Marketing', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (142, 'Sales', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (143, 'Finance', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (144, 'Sales', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (145, 'Finance', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (146, 'Sales', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (147, 'Marketing', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (148, 'Sales', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (149, 'Finance', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (150, 'Sales', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (151, 'Marketing', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (152, 'Marketing', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (153, 'Finance', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (154, 'Finance', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (155, 'Finance', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (156, 'Human Resources', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (157, 'Finance', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (158, 'Human Resources', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (159, 'Marketing', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (160, 'Finance', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (161, 'Sales', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (162, 'Sales', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (163, 'Marketing', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (164, 'Finance', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (165, 'Human Resources', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (166, 'Finance', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (167, 'Sales', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (168, 'Marketing', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (169, 'Sales', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (170, 'Finance', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (171, 'Human Resources', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (172, 'Human Resources', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (173, 'Finance', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (174, 'Sales', 18);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (175, 'Sales', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (176, 'Human Resources', 18);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (177, 'Marketing', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (178, 'Sales', 17);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (179, 'Human Resources', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (180, 'Human Resources', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (181, 'Marketing', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (182, 'Marketing', 17);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (183, 'Human Resources', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (184, 'Finance', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (185, 'Sales', 18);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (186, 'Human Resources', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (187, 'Finance', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (188, 'Marketing', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (189, 'Sales', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (190, 'Sales', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (191, 'Human Resources', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (192, 'Sales', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (193, 'Marketing', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (194, 'Sales', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (195, 'Human Resources', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (196, 'Finance', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (197, 'Marketing', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (198, 'Human Resources', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (199, 'Sales', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (200, 'Marketing', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (201, 'Finance', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (202, 'Sales', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (203, 'Human Resources', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (204, 'Human Resources', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (205, 'Marketing', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (206, 'Finance', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (207, 'Finance', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (208, 'Human Resources', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (209, 'Human Resources', 17);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (210, 'Marketing', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (211, 'Human Resources', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (212, 'Finance', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (213, 'Human Resources', 17);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (214, 'Human Resources', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (215, 'Human Resources', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (216, 'Human Resources', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (217, 'Marketing', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (218, 'Finance', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (219, 'Marketing', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (220, 'Human Resources', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (221, 'Human Resources', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (222, 'Marketing', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (223, 'Marketing', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (224, 'Sales', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (225, 'Human Resources', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (226, 'Sales', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (227, 'Marketing', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (228, 'Finance', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (229, 'Marketing', 18);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (230, 'Finance', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (231, 'Marketing', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (232, 'Sales', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (233, 'Marketing', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (234, 'Marketing', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (235, 'Human Resources', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (236, 'Marketing', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (237, 'Sales', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (238, 'Human Resources', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (239, 'Finance', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (240, 'Finance', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (241, 'Marketing', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (242, 'Finance', 18);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (243, 'Finance', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (244, 'Sales', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (245, 'Finance', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (246, 'Finance', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (247, 'Finance', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (248, 'Sales', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (249, 'Marketing', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (250, 'Marketing', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (251, 'Marketing', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (252, 'Human Resources', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (253, 'Human Resources', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (254, 'Human Resources', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (255, 'Human Resources', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (256, 'Marketing', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (257, 'Sales', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (258, 'Sales', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (259, 'Human Resources', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (260, 'Finance', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (261, 'Sales', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (262, 'Sales', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (263, 'Human Resources', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (264, 'Marketing', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (265, 'Human Resources', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (266, 'Finance', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (267, 'Human Resources', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (268, 'Sales', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (269, 'Marketing', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (270, 'Human Resources', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (271, 'Sales', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (272, 'Human Resources', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (273, 'Marketing', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (274, 'Marketing', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (275, 'Sales', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (276, 'Finance', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (277, 'Sales', 18);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (278, 'Marketing', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (279, 'Sales', 17);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (280, 'Sales', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (281, 'Sales', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (282, 'Human Resources', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (283, 'Finance', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (284, 'Sales', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (285, 'Finance', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (286, 'Finance', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (287, 'Sales', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (288, 'Sales', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (289, 'Sales', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (290, 'Human Resources', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (291, 'Sales', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (292, 'Sales', 18);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (293, 'Marketing', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (294, 'Sales', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (295, 'Finance', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (296, 'Marketing', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (297, 'Marketing', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (298, 'Marketing', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (299, 'Finance', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (300, 'Marketing', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (301, 'Marketing', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (302, 'Sales', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (303, 'Human Resources', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (304, 'Sales', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (305, 'Human Resources', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (306, 'Human Resources', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (307, 'Human Resources', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (308, 'Finance', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (309, 'Human Resources', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (310, 'Human Resources', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (311, 'Human Resources', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (312, 'Finance', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (313, 'Finance', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (314, 'Human Resources', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (315, 'Human Resources', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (316, 'Sales', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (317, 'Marketing', 17);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (318, 'Human Resources', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (319, 'Sales', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (320, 'Human Resources', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (321, 'Human Resources', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (322, 'Human Resources', 17);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (323, 'Marketing', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (324, 'Human Resources', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (325, 'Human Resources', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (326, 'Marketing', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (327, 'Sales', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (328, 'Sales', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (329, 'Marketing', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (330, 'Finance', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (331, 'Human Resources', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (332, 'Human Resources', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (333, 'Human Resources', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (334, 'Human Resources', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (335, 'Human Resources', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (336, 'Sales', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (337, 'Human Resources', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (338, 'Marketing', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (339, 'Sales', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (340, 'Finance', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (341, 'Human Resources', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (342, 'Marketing', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (343, 'Human Resources', 18);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (344, 'Sales', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (345, 'Human Resources', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (346, 'Marketing', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (347, 'Marketing', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (348, 'Finance', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (349, 'Marketing', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (350, 'Finance', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (351, 'Finance', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (352, 'Sales', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (353, 'Finance', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (354, 'Sales', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (355, 'Sales', 18);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (356, 'Human Resources', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (357, 'Human Resources', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (358, 'Marketing', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (359, 'Marketing', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (360, 'Human Resources', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (361, 'Sales', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (362, 'Sales', 19);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (363, 'Marketing', 9);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (364, 'Marketing', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (365, 'Sales', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (366, 'Marketing', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (367, 'Finance', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (368, 'Sales', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (369, 'Marketing', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (370, 'Human Resources', 17);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (371, 'Finance', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (372, 'Marketing', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (373, 'Sales', 24);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (374, 'Sales', 12);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (375, 'Human Resources', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (376, 'Human Resources', 5);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (377, 'Human Resources', 18);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (378, 'Human Resources', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (379, 'Sales', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (380, 'Human Resources', 20);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (381, 'Marketing', 8);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (382, 'Marketing', 13);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (383, 'Marketing', 25);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (384, 'Marketing', 15);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (385, 'Finance', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (386, 'Finance', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (387, 'Sales', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (388, 'Human Resources', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (389, 'Human Resources', 11);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (390, 'Finance', 14);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (391, 'Marketing', 10);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (392, 'Human Resources', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (393, 'Finance', 23);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (394, 'Human Resources', 22);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (395, 'Human Resources', 21);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (396, 'Marketing', 6);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (397, 'Sales', 7);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (398, 'Sales', 17);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (399, 'Human Resources', 16);
insert into DEPARTMENT (departmentid, departmentname, numofworkers)
values (400, 'Finance', 22);
commit;
prompt 400 records loaded
prompt Loading EMPLOYEE...
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (1, 22, 'Jayme', 'MacLice', 347, 14306);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (2, 363, 'Stacia', 'Thunders', 309, 11297);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (3, 340, 'Delmer', 'Purcell', 367, 13555);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (4, 88, 'Selle', 'Rodd', 304, 10173);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (5, 209, 'Nikoletta', 'Lanham', 76, 25474);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (6, 238, 'Mellisa', 'Woolliams', 370, 14067);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (7, 329, 'Darrick', 'Redmile', 381, 14831);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (8, 100, 'Fitz', 'Voss', 76, 23737);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (9, 316, 'Dulcie', 'Lally', 148, 24597);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (10, 145, 'Gregorius', 'Schult', 67, 12161);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (11, 129, 'Delores', 'Hovenden', 398, 20348);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (12, 342, 'Lacie', 'Edmed', 278, 16356);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (13, 380, 'Karlie', 'Churn', 40, 29012);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (14, 208, 'Kandy', 'Otteridge', 30, 28157);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (15, 35, 'Stanton', 'Pettipher', 24, 10184);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (16, 106, 'Bjorn', 'Lenard', 139, 15459);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (17, 298, 'Maryjane', 'Oby', 305, 19600);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (18, 220, 'Mil', 'Pessler', 259, 20443);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (19, 353, 'Lily', 'Verma', 285, 23514);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (20, 167, 'Cora', 'Locksley', 72, 11937);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (21, 239, 'Boyce', 'Gulleford', 264, 12778);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (22, 396, 'Melesa', 'Spedroni', 177, 13561);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (23, 310, 'Fidel', 'Harbertson', 289, 24472);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (24, 94, 'Elbert', 'Bristoe', 86, 15756);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (25, 345, 'Salli', 'Clemoes', 270, 12711);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (26, 21, 'Myrtia', 'Ixer', 304, 17857);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (27, 296, 'Averil', 'Patton', 100, 22955);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (28, 198, 'Nathanael', 'Allridge', 42, 16880);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (29, 289, 'Ralph', 'Pamplin', 258, 21208);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (30, 166, 'Beverley', 'Reijmers', 36, 28238);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (31, 266, 'Humfrid', 'Barthelmes', 120, 25001);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (32, 121, 'Katherina', 'Donneely', 32, 11297);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (33, 114, 'Marji', 'Morit', 208, 18459);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (34, 327, 'Elnore', 'MacKintosh', 271, 29873);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (35, 269, 'Amelina', 'Bertram', 369, 25938);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (36, 148, 'Gardy', 'Brignall', 370, 18012);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (37, 125, 'Bell', 'Breewood', 321, 21129);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (38, 165, 'Otha', 'Kellaway', 219, 13071);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (39, 237, 'Aguie', 'Allonby', 4, 24957);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (40, 331, 'Jorge', 'Eva', 328, 15327);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (41, 304, 'Tiff', 'Daniell', 201, 22748);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (42, 176, 'Nikolaus', 'Hows', 169, 29975);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (43, 140, 'Emmy', 'Lovett', 394, 11041);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (44, 210, 'Henry', 'Nix', 245, 14975);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (45, 19, 'Thedric', 'Kerby', 108, 29902);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (46, 156, 'Linnea', 'Checkley', 70, 26906);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (47, 138, 'Alain', 'Sturrock', 296, 16389);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (48, 311, 'Mozes', 'Gunston', 245, 29817);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (49, 299, 'Marco', 'Withull', 324, 21522);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (50, 67, 'Nero', 'Tritton', 217, 24949);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (51, 64, 'Addi', 'Bernadot', 391, 26069);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (52, 324, 'Adina', 'Dunniom', 84, 24864);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (53, 103, 'Uta', 'Hungerford', 26, 13763);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (54, 188, 'Alison', 'Rubartelli', 282, 15808);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (55, 219, 'Cissy', 'Camel', 104, 27775);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (56, 17, 'Isabelle', 'Mayston', 56, 24446);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (57, 52, 'Raffarty', 'Delahunty', 70, 10064);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (58, 28, 'Gill', 'Chadband', 293, 10960);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (59, 373, 'Sayres', 'Heinschke', 341, 26034);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (60, 271, 'Shandeigh', 'Bastiman', 331, 27428);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (61, 351, 'Harriett', 'Bradnocke', 176, 23285);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (62, 7, 'Leilah', 'Catterill', 303, 15606);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (63, 34, 'Huntington', 'Inold', 92, 10933);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (64, 364, 'Julieta', 'Coucher', 11, 22190);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (65, 268, 'Albert', 'Ransome', 339, 29199);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (66, 212, 'Titos', 'Teresse', 148, 11914);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (67, 228, 'Symon', 'Clemson', 390, 13341);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (68, 295, 'Roxine', 'Stackbridge', 323, 12279);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (69, 215, 'Ruddie', 'Chipchase', 96, 20208);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (70, 387, 'Maribeth', 'Boultwood', 85, 23505);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (71, 126, 'Eachelle', 'Ardern', 193, 25157);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (72, 211, 'Lemar', 'Durnall', 36, 11828);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (73, 377, 'Biddy', 'Treven', 288, 15443);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (74, 119, 'Huberto', 'Adriano', 338, 26950);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (75, 205, 'Grady', 'Hugland', 92, 11692);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (76, 36, 'Robb', 'Joul', 213, 16532);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (77, 71, 'Orel', 'Brockett', 308, 16540);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (78, 395, 'Flin', 'Bottoms', 174, 26320);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (79, 246, 'Adlai', 'Everson', 295, 10656);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (80, 37, 'Angie', 'Waggatt', 143, 29179);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (81, 258, 'Gar', 'Davers', 308, 27407);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (82, 39, 'Cyb', 'Bletcher', 196, 10926);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (83, 47, 'Mordecai', 'Prinn', 327, 16995);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (84, 77, 'Orazio', 'Doone', 1, 13256);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (85, 89, 'Sophronia', 'Woolaston', 210, 14217);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (86, 116, 'Husein', 'Semkins', 274, 17953);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (87, 197, 'Roddie', 'Attenbrow', 379, 11429);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (88, 282, 'Marta', 'Busst', 247, 13776);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (89, 245, 'Aubree', 'Stanner', 110, 18458);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (90, 109, 'Salome', 'Southwood', 334, 16827);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (91, 11, 'Brien', 'Carff', 148, 10709);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (92, 68, 'Scot', 'Cooke', 357, 24393);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (93, 382, 'Kally', 'Ormshaw', 101, 28107);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (94, 305, 'Vicki', 'Winwood', 43, 29308);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (95, 104, 'Kaspar', 'Paulazzi', 378, 18430);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (96, 391, 'Winny', 'Solan', 65, 10712);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (97, 262, 'Nettie', 'Veryard', 47, 13186);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (98, 65, 'Aharon', 'Sandilands', 200, 14587);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (99, 128, 'Laina', 'Impey', 40, 22419);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (100, 191, 'Marylinda', 'Gallamore', 363, 27502);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (101, 59, 'Tam', 'Willcott', 161, 19476);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (102, 375, 'Stirling', 'Eim', 213, 12448);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (103, 38, 'Ardith', 'Borer', 180, 21576);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (104, 241, 'Waylon', 'Ilchuk', 346, 28581);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (105, 98, 'Boris', 'Simonato', 385, 29619);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (106, 321, 'Cymbre', 'Pridden', 352, 14584);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (107, 308, 'Nike', 'Enns', 181, 12756);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (108, 61, 'Manfred', 'Purple', 266, 12849);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (109, 187, 'Fayth', 'Eyree', 149, 21220);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (110, 292, 'Enriqueta', 'Chetter', 252, 16657);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (111, 223, 'Benedikt', 'Giacomazzo', 25, 28400);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (112, 105, 'Franklyn', 'Diggins', 189, 11352);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (113, 53, 'Irita', 'Aish', 334, 20757);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (114, 318, 'Suzanne', 'Tattershaw', 282, 25599);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (115, 287, 'Curcio', 'Cornelis', 384, 28338);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (116, 256, 'Torrey', 'Durkin', 283, 24389);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (117, 356, 'Will', 'Brizell', 165, 10093);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (118, 20, 'Giacobo', 'Deverale', 192, 29802);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (119, 46, 'Sherilyn', 'Boag', 119, 22255);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (120, 341, 'Addie', 'de Merida', 307, 27799);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (121, 320, 'Wald', 'Skym', 190, 22298);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (122, 117, 'Margit', 'Hellyer', 293, 14529);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (123, 275, 'Maxwell', 'Caswall', 394, 18251);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (124, 43, 'Kassie', 'Roos', 280, 23424);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (125, 285, 'Chere', 'Martyn', 19, 25646);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (126, 164, 'Austen', 'Newcom', 262, 14605);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (127, 16, 'Sargent', 'Geroldi', 305, 11933);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (128, 234, 'Wyn', 'Fidock', 84, 17515);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (129, 199, 'Terri-jo', 'Limmer', 47, 28084);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (130, 55, 'Kort', 'Trendle', 42, 11370);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (131, 155, 'Danila', 'Toffler', 165, 19969);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (132, 41, 'Alysa', 'Esp', 131, 12081);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (133, 31, 'Fara', 'Garling', 187, 18465);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (134, 133, 'Koren', 'Roddie', 165, 26560);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (135, 226, 'Kerianne', 'Splevins', 283, 12700);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (136, 318, 'Holli', 'Pygott', 290, 28590);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (137, 80, 'Aggy', 'Rossbrooke', 45, 22227);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (138, 255, 'Dulcinea', 'Deluca', 48, 28925);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (139, 182, 'Maisey', 'Busse', 176, 20615);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (140, 113, 'Tierney', 'Nursey', 339, 25965);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (141, 337, 'Margarethe', 'Oakhill', 242, 13215);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (142, 297, 'Dorelle', 'Trinder', 303, 22331);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (143, 201, 'Miof mela', 'Giraldez', 222, 22932);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (144, 64, 'Anita', 'Mays', 66, 21954);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (145, 368, 'Anselm', 'Brimelow', 223, 13118);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (146, 285, 'Chloette', 'Keeri', 105, 20605);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (147, 138, 'Cordelia', 'Cruddace', 360, 14996);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (148, 271, 'Leilah', 'Tring', 267, 24324);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (149, 20, 'Bernetta', 'Dundredge', 227, 23284);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (150, 12, 'Hephzibah', 'O''Keaveny', 46, 24785);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (151, 395, 'Cortney', 'Pavy', 143, 11800);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (152, 119, 'Neville', 'Sergent', 240, 28547);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (153, 189, 'Georgiana', 'Ethridge', 20, 27747);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (154, 313, 'Glory', 'Ogglebie', 283, 14414);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (155, 282, 'Bradney', 'Hertwell', 185, 29598);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (156, 10, 'Briano', 'Lindenbaum', 58, 28263);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (157, 387, 'Norri', 'Howselee', 279, 20078);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (158, 336, 'Joannes', 'Jodrellec', 340, 18415);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (159, 216, 'Milka', 'Burkitt', 119, 15991);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (160, 174, 'Vale', 'Duguid', 149, 12199);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (161, 215, 'Caresse', 'Surman', 133, 28249);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (162, 384, 'Hermann', 'Chadburn', 343, 10512);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (163, 302, 'Isidro', 'Daymont', 154, 19662);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (164, 158, 'Sheridan', 'Sudlow', 88, 12281);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (165, 331, 'Augustin', 'Eales', 131, 17078);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (166, 71, 'Saundra', 'Dougher', 161, 15368);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (167, 39, 'Mela', 'Attenbrow', 310, 24141);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (168, 263, 'Garth', 'Pagan', 58, 20232);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (169, 19, 'Elfreda', 'Cater', 170, 10204);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (170, 283, 'Hana', 'Aston', 146, 26080);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (171, 131, 'Elie', 'Geeraert', 40, 14263);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (172, 205, 'Penrod', 'Scoular', 38, 23448);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (173, 68, 'Gisela', 'Langrick', 261, 10550);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (174, 211, 'Andie', 'Connikie', 355, 17873);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (175, 286, 'Tom', 'Delafoy', 109, 17606);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (176, 11, 'Jody', 'Calbreath', 115, 15683);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (177, 301, 'Raviv', 'Greschke', 212, 29931);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (178, 8, 'Alla', 'Toffts', 163, 28537);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (179, 278, 'Patrizius', 'Sedman', 373, 12692);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (180, 227, 'Annabela', 'Blackburn', 337, 10677);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (181, 111, 'Kurtis', 'Glassopp', 112, 13768);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (182, 117, 'Melodee', 'Elders', 282, 29971);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (183, 105, 'Lorrin', 'Eglese', 301, 25838);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (184, 95, 'Freddy', 'Hales', 334, 25010);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (185, 323, 'Juditha', 'Pumfrett', 264, 15871);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (186, 6, 'Galvan', 'Tarren', 119, 20786);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (187, 237, 'Cherilynn', 'Ivakin', 29, 16096);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (188, 381, 'Cybill', 'Jindrich', 258, 19497);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (189, 341, 'Thaine', 'Galpin', 24, 15966);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (190, 144, 'Gasparo', 'Annets', 10, 11872);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (191, 123, 'Cully', 'Crampsy', 350, 22126);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (192, 78, 'Graehme', 'Lowndsborough', 388, 10516);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (193, 35, 'Bing', 'Wathen', 259, 16242);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (194, 333, 'Niccolo', 'Govern', 314, 12881);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (195, 397, 'Kerry', 'Muselli', 113, 10972);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (196, 192, 'Lauren', 'Mennithorp', 243, 20573);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (197, 207, 'Emelia', 'Kinnock', 72, 10560);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (198, 293, 'Antoinette', 'Korneev', 173, 29940);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (199, 137, 'Shep', 'Warlow', 226, 11231);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (200, 134, 'Carmine', 'Scoggin', 192, 15866);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (201, 142, 'Flor', 'Giorgi', 343, 12849);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (202, 328, 'Stillman', 'Killelea', 28, 29843);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (203, 400, 'Rosina', 'Corkhill', 20, 20053);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (204, 332, 'Larissa', 'Tinner', 57, 11142);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (205, 107, 'Marcia', 'Toner', 304, 19342);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (206, 41, 'Roseann', 'Surphliss', 116, 10308);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (207, 120, 'Augy', 'Kinrade', 81, 25859);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (208, 187, 'Leeann', 'Ducker', 394, 11805);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (209, 204, 'Bordie', 'Murphy', 365, 25813);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (210, 44, 'Jasen', 'Willison', 107, 23886);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (211, 122, 'Mayer', 'Lant', 214, 12259);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (212, 152, 'Emmy', 'Dowdall', 217, 16322);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (213, 139, 'Coleen', 'Evered', 346, 15443);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (214, 287, 'Laverna', 'Scandroot', 201, 28390);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (215, 377, 'Isabel', 'Shadrack', 82, 22938);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (216, 98, 'Alia', 'Clyma', 76, 25449);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (217, 106, 'Travus', 'Covil', 379, 21355);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (218, 154, 'Uriel', 'Lengthorn', 160, 23435);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (219, 130, 'Gladi', 'Sangwine', 92, 22181);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (220, 33, 'Hashim', 'Baggiani', 228, 17152);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (221, 132, 'Jacqueline', 'Feltham', 323, 28525);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (222, 319, 'Lovell', 'Petruska', 375, 11634);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (223, 311, 'Vevay', 'Dalgarnowch', 330, 10881);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (224, 40, 'Alonso', 'Brock', 295, 16774);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (225, 254, 'Margalit', 'Guihen', 336, 16961);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (226, 213, 'Judi', 'Mossom', 55, 16190);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (227, 193, 'Windham', 'Excell', 36, 17810);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (228, 165, 'Evvie', 'Chapelle', 140, 22903);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (229, 284, 'Elene', 'Bauldrey', 316, 11293);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (230, 70, 'Burtie', 'Comben', 304, 13390);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (231, 232, 'Jacques', 'Apted', 131, 27208);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (232, 295, 'Sullivan', 'Loyd', 287, 15651);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (233, 258, 'Bill', 'Linstead', 67, 16527);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (234, 96, 'Merrili', 'Yellowley', 274, 11659);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (235, 291, 'Gael', 'Vassall', 235, 22888);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (236, 294, 'Lynnea', 'Rennocks', 66, 16501);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (237, 169, 'Gardie', 'Lingard', 135, 14934);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (238, 167, 'Rebbecca', 'Tunbridge', 10, 12743);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (239, 72, 'Yovonnda', 'Clarae', 34, 18906);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (240, 90, 'Selina', 'Dengel', 193, 16933);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (241, 316, 'Gaye', 'Brimming', 142, 21176);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (242, 398, 'Caralie', 'Elman', 184, 13763);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (243, 202, 'Iorgo', 'Yosselevitch', 222, 27563);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (244, 257, 'Welch', 'Conneau', 177, 19576);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (245, 102, 'Salvatore', 'Pyrah', 95, 18164);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (246, 325, 'Brook', 'McFee', 327, 18363);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (247, 177, 'Ricard', 'Potte', 166, 10758);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (248, 190, 'Ladonna', 'Derrell', 58, 18636);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (249, 50, 'Karee', 'Riepl', 218, 24022);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (250, 143, 'Rutherford', 'Cristofolo', 86, 23637);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (251, 307, 'Willdon', 'Garret', 7, 22944);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (252, 228, 'Morris', 'Haylett', 34, 25323);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (253, 129, 'Ermina', 'Laba', 8, 13604);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (254, 57, 'Falito', 'Stuckes', 247, 29856);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (255, 54, 'Melloney', 'Tuite', 290, 17453);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (256, 279, 'Con', 'Scutchings', 288, 17147);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (257, 135, 'Locke', 'Lowten', 34, 21249);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (258, 262, 'Jammie', 'Tern', 369, 17439);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (259, 355, 'Dallas', 'Ryrie', 198, 25433);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (260, 366, 'Lainey', 'Broyd', 329, 24625);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (261, 312, 'Patrica', 'Yeliashev', 46, 27761);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (262, 140, 'Giffer', 'M''Chirrie', 263, 17797);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (263, 374, 'Chevalier', 'Fearnill', 318, 11066);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (264, 217, 'Frankie', 'Vodden', 105, 13825);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (265, 218, 'Chrotoem', 'Scawn', 166, 13094);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (266, 298, 'Marcie', 'Piser', 399, 20650);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (267, 185, 'Michael', 'Biss', 75, 25469);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (268, 44, 'Gunar', 'Axton', 161, 12897);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (269, 66, 'Putnem', 'Bellison', 331, 11071);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (270, 178, 'Reena', 'Worstall', 202, 10460);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (271, 7, 'Pansie', 'Housin', 242, 17265);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (272, 293, 'Paquito', 'Egdal', 239, 22136);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (273, 289, 'Cordie', 'Edgecombe', 153, 22391);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (274, 371, 'Irma', 'Brouwer', 385, 20790);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (275, 17, 'Brinn', 'McKernan', 164, 13611);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (276, 260, 'Cassie', 'Northley', 300, 23571);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (277, 258, 'Jacintha', 'Fyfield', 11, 14762);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (278, 46, 'Julia', 'Hutchins', 179, 29188);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (279, 279, 'Murray', 'Haton', 290, 21939);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (280, 18, 'Eugen', 'Shawyers', 197, 25284);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (281, 141, 'Zondra', 'Bulle', 10, 15520);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (282, 275, 'Kile', 'Smalman', 276, 17251);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (283, 176, 'Rubia', 'Boyan', 396, 18578);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (284, 301, 'Ezequiel', 'Wardingly', 229, 19079);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (285, 169, 'Paddy', 'Pestricke', 2, 16635);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (286, 132, 'Edward', 'Reboulet', 222, 29441);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (287, 115, 'Ari', 'Alelsandrovich', 245, 13271);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (288, 13, 'Deanna', 'Pellett', 60, 22765);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (289, 341, 'Bart', 'Rivitt', 387, 15012);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (290, 171, 'Knox', 'Patise', 158, 11325);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (291, 153, 'Judon', 'Klement', 49, 29784);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (292, 338, 'Lionello', 'Jevon', 248, 12816);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (293, 399, 'Chery', 'Ingley', 45, 11912);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (294, 52, 'Noella', 'Walklett', 246, 14917);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (295, 62, 'Wandis', 'Castell', 24, 20463);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (296, 366, 'Danie', 'Gounod', 374, 28502);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (297, 191, 'Nolly', 'Alfuso', 58, 28022);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (298, 377, 'Ruttger', 'Dallicott', 263, 16508);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (299, 2, 'Jo-anne', 'Kingswood', 362, 22876);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (300, 240, 'Caesar', 'Ummfrey', 116, 10006);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (301, 78, 'Page', 'Stanmer', 212, 24853);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (302, 325, 'Lenora', 'Scritch', 196, 27290);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (303, 349, 'Micheal', 'De Roeck', 6, 11372);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (304, 177, 'Mabelle', 'Giffen', 127, 24963);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (305, 75, 'Nanny', 'Brunt', 366, 25857);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (306, 243, 'Tucker', 'Annesley', 282, 26281);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (307, 74, 'Gardner', 'Joselevitch', 351, 10775);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (308, 209, 'Irv', 'Caudwell', 130, 14736);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (309, 217, 'Randie', 'Eminson', 143, 16809);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (310, 392, 'Merrily', 'Gaskoin', 183, 10500);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (311, 50, 'Cordula', 'Tizzard', 208, 13062);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (312, 267, 'Gal', 'Physick', 310, 15489);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (313, 58, 'Demeter', 'Gwinnell', 242, 11010);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (314, 82, 'Kelly', 'Jeckell', 61, 10867);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (315, 342, 'Berna', 'Bane', 173, 16860);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (316, 335, 'Skipp', 'Kurt', 144, 24834);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (317, 45, 'Wallis', 'Geelan', 236, 10794);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (318, 339, 'Cirillo', 'Lattka', 224, 18826);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (319, 179, 'Latia', 'Canniffe', 300, 16123);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (320, 70, 'Vite', 'Edgeson', 108, 27809);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (321, 174, 'Odey', 'Drury', 326, 13888);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (322, 97, 'Thane', 'Kilfedder', 311, 27856);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (323, 375, 'Hannis', 'Dryburgh', 138, 24093);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (324, 370, 'Kaile', 'Garz', 96, 16222);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (325, 318, 'Joelynn', 'Duffit', 363, 10715);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (326, 212, 'Christyna', 'Heijnen', 381, 22083);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (327, 148, 'Poul', 'Dilkes', 64, 12977);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (328, 133, 'Carlie', 'Crocetti', 68, 15749);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (329, 326, 'Ginnie', 'Fouch', 318, 10360);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (330, 170, 'Rafi', 'Bickerton', 375, 12175);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (331, 167, 'Lindie', 'McIlwrick', 250, 21501);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (332, 315, 'Dotty', 'Dabell', 208, 29936);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (333, 380, 'Alastair', 'Gadeaux', 42, 27970);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (334, 232, 'Ulrick', 'Pringuer', 368, 12500);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (335, 216, 'Brittne', 'Kach', 21, 16712);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (336, 149, 'Hadrian', 'Ambrosetti', 290, 23879);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (337, 306, 'Damien', 'Revely', 254, 28160);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (338, 152, 'Ursuline', 'Sweynson', 377, 19660);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (339, 314, 'Kimberly', 'Whitby', 194, 22428);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (340, 111, 'Berti', 'Florez', 124, 10244);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (341, 14, 'Chrotoem', 'Darwent', 232, 12233);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (342, 369, 'Maitilde', 'Glinde', 339, 18985);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (343, 343, 'Ole', 'Gowry', 93, 16612);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (344, 374, 'Leslie', 'Satyford', 202, 27436);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (345, 106, 'Morley', 'Roskam', 373, 17316);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (346, 272, 'Floris', 'Lawrence', 360, 13685);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (347, 327, 'Eleen', 'Duxbarry', 318, 29454);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (348, 248, 'Ediva', 'Banfill', 269, 13083);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (349, 5, 'West', 'Drinkeld', 253, 18284);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (350, 331, 'Ronalda', 'Beddard', 24, 12333);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (351, 92, 'Emory', 'Moyer', 10, 14072);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (352, 154, 'Wendel', 'Dy', 18, 19592);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (353, 157, 'Evie', 'Kermon', 167, 16234);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (354, 367, 'Danie', 'Erett', 44, 11882);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (355, 128, 'Kendre', 'Gimenez', 187, 15472);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (356, 129, 'Bobina', 'Limon', 56, 14179);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (357, 242, 'Patrizia', 'Dimont', 10, 24740);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (358, 355, 'Kore', 'Thoumasson', 54, 24992);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (359, 378, 'Enrique', 'Benneton', 270, 22914);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (360, 251, 'Electra', 'Studdert', 315, 22721);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (361, 238, 'Gavin', 'McKeachie', 243, 23146);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (362, 203, 'Lancelot', 'Joynes', 251, 16549);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (363, 10, 'Joly', 'Lotherington', 140, 25249);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (364, 110, 'Kiri', 'Fludder', 65, 16714);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (365, 390, 'Harmony', 'MacRorie', 349, 16517);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (366, 255, 'Inesita', 'Deyes', 109, 10120);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (367, 125, 'Bella', 'Thandi', 93, 25080);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (368, 37, 'Erin', 'Branthwaite', 6, 10847);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (369, 252, 'Delmar', 'Doog', 92, 15457);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (370, 108, 'Jammie', 'Arnaudot', 332, 17262);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (371, 114, 'Marsiella', 'Kielty', 389, 11876);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (372, 112, 'Bendick', 'Urquhart', 265, 10378);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (373, 99, 'Renaud', 'Cawthorne', 142, 10789);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (374, 80, 'Fletch', 'Funnell', 305, 13394);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (375, 73, 'Anna-diane', 'Gowan', 350, 17159);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (376, 90, 'Delinda', 'Sagg', 77, 11288);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (377, 29, 'Antonina', 'Kopman', 104, 17127);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (378, 313, 'Melonie', 'Swinn', 312, 25548);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (379, 340, 'Gannie', 'Simenon', 134, 13869);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (380, 175, 'Vilhelmina', 'Gudgion', 47, 19432);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (381, 22, 'Stanley', 'Lindner', 27, 22131);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (382, 95, 'Cathy', 'Windsor', 103, 12228);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (383, 91, 'Karylin', 'Marland', 65, 22925);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (384, 222, 'Peggy', 'Gino', 132, 24409);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (385, 257, 'Essa', 'Castledine', 153, 26182);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (386, 239, 'Shel', 'Flower', 352, 28625);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (387, 186, 'Octavius', 'Ormes', 264, 28163);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (388, 160, 'Penn', 'Wason', 351, 24770);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (389, 166, 'Evered', 'Hedgecock', 312, 23554);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (390, 228, 'Siward', 'Vasyuchov', 44, 17054);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (391, 88, 'Aggie', 'Dyshart', 231, 28382);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (392, 241, 'Chic', 'Cockshut', 386, 29769);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (393, 116, 'Norby', 'Gwilliam', 139, 27360);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (394, 120, 'Fax', 'Izakov', 101, 23193);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (395, 122, 'Beverley', 'MacKee', 144, 25453);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (396, 53, 'Bondon', 'Rodenburg', 91, 13890);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (397, 261, 'Ailyn', 'Larkworthy', 33, 18019);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (398, 270, 'Shay', 'Dubbin', 213, 15411);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (399, 42, 'Ario', 'Dearell', 26, 10767);
insert into EMPLOYEE (employeeid, positionid, first_name, last_name, departmentid, salary)
values (400, 144, 'Aluin', 'Jerdan', 293, 14205);
commit;
prompt 400 records loaded
prompt Loading ATTENDANCE...
insert into ATTENDANCE (employeeid, aten_date, status)
values (256, to_date('28-07-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (246, to_date('19-04-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (238, to_date('11-06-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (308, to_date('27-02-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (259, to_date('15-02-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (27, to_date('07-03-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (336, to_date('18-02-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (184, to_date('15-01-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (56, to_date('30-04-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (91, to_date('15-06-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (289, to_date('06-07-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (377, to_date('17-10-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (19, to_date('19-05-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (380, to_date('06-02-2024', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (153, to_date('10-06-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (137, to_date('03-07-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (258, to_date('28-10-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (186, to_date('01-04-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (127, to_date('27-05-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (19, to_date('03-10-2021', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (123, to_date('14-06-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (209, to_date('05-10-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (329, to_date('01-02-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (270, to_date('26-11-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (335, to_date('25-04-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (386, to_date('08-03-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (240, to_date('11-12-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (74, to_date('17-11-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (81, to_date('01-12-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (73, to_date('07-02-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (335, to_date('22-03-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (399, to_date('21-09-2024', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (363, to_date('27-04-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (95, to_date('07-12-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (341, to_date('21-12-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (252, to_date('28-01-2024', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (396, to_date('02-06-2024', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (388, to_date('04-08-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (86, to_date('16-05-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (223, to_date('30-12-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (202, to_date('15-04-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (72, to_date('11-09-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (207, to_date('28-03-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (101, to_date('20-04-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (74, to_date('01-05-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (68, to_date('04-03-2021', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (284, to_date('26-10-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (258, to_date('30-08-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (338, to_date('27-11-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (171, to_date('05-06-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (206, to_date('30-05-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (64, to_date('26-11-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (40, to_date('21-09-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (312, to_date('23-04-2024', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (64, to_date('11-07-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (242, to_date('11-12-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (114, to_date('11-04-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (57, to_date('18-05-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (80, to_date('06-02-2024', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (228, to_date('02-01-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (202, to_date('10-03-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (102, to_date('06-07-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (96, to_date('11-03-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (238, to_date('27-05-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (306, to_date('05-12-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (59, to_date('01-09-2021', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (127, to_date('21-12-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (113, to_date('22-07-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (112, to_date('13-01-2021', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (43, to_date('25-06-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (280, to_date('07-07-2024', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (344, to_date('30-12-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (183, to_date('25-04-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (267, to_date('04-08-2024', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (382, to_date('05-05-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (229, to_date('14-07-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (67, to_date('10-03-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (104, to_date('18-10-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (352, to_date('29-03-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (201, to_date('15-10-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (178, to_date('02-11-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (77, to_date('05-08-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (13, to_date('05-10-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (299, to_date('20-07-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (202, to_date('12-06-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (225, to_date('06-08-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (298, to_date('19-11-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (299, to_date('22-12-2021', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (3, to_date('14-10-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (63, to_date('21-10-2021', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (339, to_date('20-07-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (392, to_date('24-01-2021', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (276, to_date('16-12-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (311, to_date('28-02-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (152, to_date('29-06-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (312, to_date('30-05-2021', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (272, to_date('14-10-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (366, to_date('17-01-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (138, to_date('16-06-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (79, to_date('20-07-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (28, to_date('01-05-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (389, to_date('23-03-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (375, to_date('20-05-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (184, to_date('07-09-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (93, to_date('29-07-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (93, to_date('14-05-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (312, to_date('10-02-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (133, to_date('25-06-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (265, to_date('25-06-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (352, to_date('23-09-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (239, to_date('08-02-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (228, to_date('18-10-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (285, to_date('04-12-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (200, to_date('05-04-2021', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (149, to_date('15-07-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (129, to_date('09-04-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (326, to_date('05-01-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (355, to_date('20-09-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (1, to_date('12-10-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (295, to_date('14-05-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (391, to_date('07-12-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (122, to_date('08-03-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (70, to_date('09-04-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (3, to_date('20-09-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (252, to_date('02-06-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (35, to_date('04-03-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (129, to_date('24-06-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (50, to_date('04-11-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (94, to_date('15-03-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (295, to_date('07-06-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (49, to_date('20-12-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (314, to_date('25-03-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (301, to_date('24-04-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (327, to_date('07-12-2021', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (40, to_date('19-07-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (200, to_date('19-03-2021', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (6, to_date('20-01-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (316, to_date('08-10-2021', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (81, to_date('31-05-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (105, to_date('13-06-2024', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (380, to_date('22-10-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (135, to_date('27-01-2024', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (52, to_date('30-09-2021', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (122, to_date('23-05-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (140, to_date('15-06-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (343, to_date('10-03-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (132, to_date('22-05-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (32, to_date('09-06-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (260, to_date('02-11-2021', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (111, to_date('24-10-2021', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (400, to_date('23-04-2021', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (111, to_date('20-12-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (102, to_date('10-09-2021', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (357, to_date('12-12-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (369, to_date('29-10-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (244, to_date('16-02-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (380, to_date('04-12-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (75, to_date('09-09-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (70, to_date('09-06-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (302, to_date('26-05-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (39, to_date('01-02-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (267, to_date('27-09-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (399, to_date('03-12-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (177, to_date('09-01-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (55, to_date('01-03-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (162, to_date('01-11-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (79, to_date('22-12-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (17, to_date('03-11-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (27, to_date('16-01-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (34, to_date('01-07-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (63, to_date('27-02-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (165, to_date('29-10-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (204, to_date('28-12-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (266, to_date('29-01-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (330, to_date('20-12-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (48, to_date('24-05-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (5, to_date('12-01-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (109, to_date('23-06-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (357, to_date('10-06-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (320, to_date('09-12-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (60, to_date('12-08-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (225, to_date('28-09-2024', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (207, to_date('12-03-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (301, to_date('16-06-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (104, to_date('03-08-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (125, to_date('26-05-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (241, to_date('19-09-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (47, to_date('18-12-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (188, to_date('08-02-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (370, to_date('03-05-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (196, to_date('18-07-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (54, to_date('25-09-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (323, to_date('16-09-2021', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (10, to_date('16-02-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (128, to_date('17-11-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (393, to_date('27-03-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (215, to_date('02-11-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (161, to_date('29-08-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (271, to_date('11-04-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (113, to_date('13-04-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (157, to_date('30-03-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (182, to_date('17-02-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (165, to_date('08-08-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (242, to_date('07-12-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (170, to_date('29-04-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (322, to_date('01-12-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (39, to_date('09-02-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (355, to_date('14-02-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (232, to_date('25-06-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (313, to_date('24-10-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (309, to_date('11-04-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (238, to_date('05-04-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (253, to_date('07-07-2021', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (390, to_date('15-08-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (289, to_date('07-03-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (273, to_date('28-12-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (11, to_date('14-02-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (19, to_date('02-02-2024', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (53, to_date('08-06-2021', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (299, to_date('24-12-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (141, to_date('17-07-2024', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (179, to_date('10-04-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (289, to_date('25-05-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (7, to_date('02-07-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (203, to_date('29-03-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (342, to_date('16-11-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (230, to_date('05-12-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (255, to_date('17-05-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (116, to_date('08-04-2024', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (77, to_date('16-11-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (207, to_date('25-04-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (267, to_date('13-09-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (11, to_date('20-11-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (133, to_date('13-01-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (323, to_date('11-02-2021', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (204, to_date('23-04-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (45, to_date('04-01-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (390, to_date('05-08-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (343, to_date('31-05-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (301, to_date('16-04-2024', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (210, to_date('10-01-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (212, to_date('02-07-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (257, to_date('26-02-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (69, to_date('29-08-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (275, to_date('22-07-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (61, to_date('16-04-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (173, to_date('16-11-2024', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (292, to_date('19-03-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (279, to_date('12-06-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (264, to_date('15-05-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (130, to_date('28-07-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (342, to_date('08-05-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (295, to_date('25-08-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (204, to_date('31-08-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (190, to_date('14-10-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (71, to_date('08-03-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (168, to_date('14-05-2021', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (350, to_date('11-10-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (79, to_date('28-08-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (336, to_date('18-04-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (396, to_date('14-06-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (211, to_date('31-08-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (206, to_date('06-12-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (153, to_date('27-10-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (115, to_date('24-06-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (71, to_date('25-05-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (352, to_date('20-08-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (345, to_date('22-09-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (335, to_date('15-01-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (296, to_date('29-04-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (12, to_date('22-10-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (161, to_date('22-12-2021', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (346, to_date('15-12-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (210, to_date('24-07-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (71, to_date('26-06-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (149, to_date('20-10-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (246, to_date('01-06-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (196, to_date('19-02-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (295, to_date('20-12-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (299, to_date('10-03-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (301, to_date('04-07-2021', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (50, to_date('22-02-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (280, to_date('22-05-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (378, to_date('30-12-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (308, to_date('07-11-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (381, to_date('23-05-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (374, to_date('10-12-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (53, to_date('16-09-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (28, to_date('23-07-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (255, to_date('06-10-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (51, to_date('08-03-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (75, to_date('09-07-2021', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (41, to_date('28-09-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (304, to_date('11-09-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (362, to_date('01-01-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (368, to_date('09-04-2021', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (363, to_date('05-03-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (119, to_date('01-09-2024', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (282, to_date('31-07-2021', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (301, to_date('11-11-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (142, to_date('21-12-2024', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (308, to_date('13-11-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (210, to_date('20-10-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (204, to_date('23-12-2024', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (278, to_date('31-05-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (333, to_date('14-04-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (51, to_date('11-12-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (350, to_date('09-12-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (142, to_date('13-03-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (225, to_date('08-05-2024', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (150, to_date('21-07-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (145, to_date('11-07-2021', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (303, to_date('07-03-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (359, to_date('05-04-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (290, to_date('21-05-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (360, to_date('26-05-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (389, to_date('12-05-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (393, to_date('22-02-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (388, to_date('14-10-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (188, to_date('28-09-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (198, to_date('11-01-2020', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (154, to_date('17-08-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (44, to_date('18-05-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (138, to_date('10-09-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (398, to_date('25-06-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (399, to_date('06-10-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (310, to_date('03-07-2021', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (255, to_date('31-12-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (118, to_date('23-01-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (257, to_date('17-08-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (376, to_date('03-02-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (159, to_date('26-11-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (339, to_date('23-06-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (24, to_date('09-04-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (18, to_date('02-08-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (101, to_date('24-12-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (255, to_date('04-10-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (340, to_date('01-05-2024', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (281, to_date('13-09-2024', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (151, to_date('10-04-2021', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (129, to_date('04-03-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (89, to_date('22-09-2024', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (241, to_date('21-09-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (260, to_date('13-04-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (381, to_date('13-07-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (68, to_date('11-12-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (126, to_date('28-09-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (377, to_date('01-04-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (137, to_date('23-03-2024', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (13, to_date('21-03-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (259, to_date('06-11-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (293, to_date('12-06-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (246, to_date('25-09-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (168, to_date('18-06-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (24, to_date('03-04-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (34, to_date('13-07-2021', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (396, to_date('11-05-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (284, to_date('26-05-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (275, to_date('22-11-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (34, to_date('21-09-2021', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (180, to_date('22-10-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (13, to_date('19-02-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (234, to_date('15-03-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (276, to_date('02-10-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (94, to_date('29-07-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (317, to_date('21-05-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (320, to_date('07-07-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (336, to_date('09-01-2020', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (17, to_date('30-03-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (399, to_date('29-06-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (396, to_date('14-04-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (243, to_date('30-10-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (278, to_date('18-06-2024', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (159, to_date('13-02-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (213, to_date('13-12-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (393, to_date('06-07-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (122, to_date('22-07-2021', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (296, to_date('21-10-2022', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (94, to_date('09-07-2022', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (228, to_date('18-02-2023', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (22, to_date('23-06-2023', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (8, to_date('19-01-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (168, to_date('10-12-2021', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (176, to_date('15-03-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (107, to_date('11-07-2021', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (113, to_date('28-01-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (306, to_date('29-08-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (139, to_date('12-09-2022', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (278, to_date('17-12-2023', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (221, to_date('26-06-2023', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (195, to_date('14-04-2023', 'dd-mm-yyyy'), 'Absent');
insert into ATTENDANCE (employeeid, aten_date, status)
values (94, to_date('03-11-2024', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (352, to_date('23-03-2020', 'dd-mm-yyyy'), 'Vacation');
insert into ATTENDANCE (employeeid, aten_date, status)
values (309, to_date('15-04-2021', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (263, to_date('16-05-2024', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (395, to_date('24-10-2020', 'dd-mm-yyyy'), 'Sick');
insert into ATTENDANCE (employeeid, aten_date, status)
values (330, to_date('27-11-2022', 'dd-mm-yyyy'), 'Late');
insert into ATTENDANCE (employeeid, aten_date, status)
values (317, to_date('28-04-2022', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (236, to_date('26-12-2020', 'dd-mm-yyyy'), 'Present');
insert into ATTENDANCE (employeeid, aten_date, status)
values (296, to_date('04-11-2022', 'dd-mm-yyyy'), 'Absent');
commit;
prompt 400 records loaded
prompt Loading DEVELOPMENT...
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (1, 244, 'tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus', to_date('07-12-1242', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (2, 158, 'dui proin leo odio porttitor id consequat in consequat ut', to_date('26-02-1578', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (3, 240, 'egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis', to_date('06-01-1896', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (4, 338, 'sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate', to_date('16-09-1929', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (5, 319, 'libero rutrum ac lobortis vel dapibus at diam nam tristique tortor', to_date('17-07-1595', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (6, 257, 'erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus', to_date('14-03-1552', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (7, 256, 'dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum', to_date('04-07-1324', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (8, 154, 'est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum', to_date('27-10-1594', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (9, 195, 'vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in', to_date('20-06-1352', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (10, 238, 'tempus vivamus in felis eu sapien cursus vestibulum proin eu', to_date('01-02-1804', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (11, 219, 'dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla', to_date('13-10-1701', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (12, 350, 'interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu', to_date('15-09-1438', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (13, 90, 'volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus', to_date('29-10-1793', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (14, 12, 'nisl duis bibendum felis sed interdum venenatis turpis enim blandit', to_date('03-06-1527', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (15, 158, 'vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium', to_date('22-07-1765', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (16, 56, 'aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum', to_date('21-09-1885', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (17, 275, 'tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum', to_date('08-08-1964', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (18, 26, 'leo odio condimentum id luctus nec molestie sed justo pellentesque', to_date('01-08-1818', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (19, 220, 'in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque', to_date('30-11-1684', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (20, 185, 'arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec', to_date('26-11-1680', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (21, 217, 'non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue', to_date('23-04-1675', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (22, 98, 'odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus', to_date('19-09-1419', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (23, 241, 'sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim', to_date('04-01-1525', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (24, 143, 'in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque', to_date('26-07-1836', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (25, 45, 'enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit', to_date('20-10-1259', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (26, 357, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec', to_date('12-11-1958', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (27, 116, 'quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur', to_date('20-10-1250', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (28, 89, 'suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas', to_date('31-01-1220', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (29, 68, 'neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis', to_date('06-10-1868', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (30, 247, 'scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem', to_date('03-08-1814', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (31, 7, 'in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes', to_date('01-09-1623', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (32, 183, 'eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin', to_date('05-07-1927', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (33, 8, 'ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus', to_date('02-04-1530', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (34, 233, 'hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum', to_date('25-07-1293', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (35, 216, 'mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at', to_date('19-02-1669', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (36, 302, 'luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus', to_date('04-04-1961', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (37, 268, 'nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare', to_date('14-08-1815', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (38, 375, 'libero quis orci nullam molestie nibh in lectus pellentesque at', to_date('08-09-1903', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (39, 382, 'sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit', to_date('28-11-1527', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (40, 225, 'nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra', to_date('28-03-1854', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (41, 17, 'luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi', to_date('04-03-1444', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (42, 28, 'et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare', to_date('24-01-1801', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (43, 141, 'quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut', to_date('22-11-1487', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (44, 103, 'laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem', to_date('22-03-1865', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (45, 38, 'tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis', to_date('05-04-1415', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (46, 50, 'in lacus curabitur at ipsum ac tellus semper interdum mauris', to_date('13-11-1462', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (47, 333, 'pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio', to_date('05-06-1994', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (48, 174, 'orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse', to_date('16-06-1498', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (49, 352, 'vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit', to_date('04-06-1666', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (50, 326, 'ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi', to_date('15-07-1461', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (51, 90, 'at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus', to_date('21-07-1440', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (52, 91, 'libero nullam sit amet turpis elementum ligula vehicula consequat morbi', to_date('11-07-1965', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (53, 151, 'ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis', to_date('26-11-1861', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (54, 398, 'vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam', to_date('24-06-1816', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (55, 223, 'et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio', to_date('17-08-1815', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (56, 269, 'in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat', to_date('31-12-1941', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (57, 220, 'morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo', to_date('02-05-1473', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (58, 281, 'luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum', to_date('10-05-1779', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (59, 369, 'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in', to_date('13-04-2014', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (60, 85, 'rutrum neque aenean auctor gravida sem praesent id massa id nisl', to_date('16-08-1396', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (61, 50, 'primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec', to_date('20-07-1623', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (62, 167, 'nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien', to_date('10-10-1727', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (63, 277, 'ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum', to_date('22-08-1689', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (64, 259, 'aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed', to_date('02-04-1539', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (65, 105, 'pede libero quis orci nullam molestie nibh in lectus pellentesque', to_date('27-02-1792', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (66, 146, 'congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien', to_date('09-04-1316', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (67, 377, 'justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat', to_date('10-03-1669', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (68, 42, 'tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam', to_date('25-09-1724', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (69, 379, 'maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id', to_date('30-11-2000', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (70, 304, 'at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut', to_date('30-04-1798', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (71, 295, 'pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit', to_date('30-03-1749', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (72, 224, 'dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus', to_date('25-05-1536', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (73, 103, 'cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum', to_date('10-11-2008', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (74, 152, 'et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis', to_date('22-11-1299', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (75, 349, 'morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in', to_date('27-06-1511', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (76, 117, 'luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non', to_date('30-10-1459', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (77, 186, 'nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper', to_date('06-09-1244', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (78, 33, 'quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus', to_date('30-03-1984', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (79, 391, 'turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh', to_date('15-12-1702', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (80, 216, 'ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est', to_date('30-06-2013', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (81, 56, 'volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper', to_date('12-07-1968', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (82, 9, 'vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi', to_date('08-11-1328', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (83, 278, 'purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam', to_date('20-11-1856', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (84, 85, 'non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan', to_date('28-03-1480', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (85, 314, 'laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus', to_date('26-11-1989', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (86, 324, 'nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio', to_date('18-07-1263', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (87, 206, 'enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis', to_date('10-12-1752', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (88, 211, 'nam dui proin leo odio porttitor id consequat in consequat ut nulla', to_date('21-04-2017', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (89, 329, 'aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus', to_date('25-09-1860', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (90, 369, 'sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas', to_date('29-10-1943', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (91, 338, 'tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris', to_date('20-10-1396', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (92, 145, 'mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing', to_date('29-12-1394', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (93, 192, 'ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia', to_date('19-07-1642', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (94, 367, 'pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum', to_date('18-12-1230', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (95, 108, 'mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus', to_date('18-11-1523', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (96, 40, 'eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis', to_date('09-06-1316', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (97, 66, 'maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra', to_date('05-10-1286', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (98, 46, 'neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui', to_date('29-03-1962', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (99, 66, 'in lectus pellentesque at nulla suspendisse potenti cras in purus eu', to_date('12-07-1552', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (100, 390, 'in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo', to_date('06-12-1598', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (101, 154, 'amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam', to_date('22-10-1709', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (102, 341, 'tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in', to_date('20-01-1604', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (103, 28, 'et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque', to_date('30-08-1249', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (104, 332, 'lectus vestibulum quam sapien varius ut blandit non interdum in ante', to_date('26-06-1245', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (105, 42, 'nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt', to_date('11-09-1983', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (106, 351, 'parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean', to_date('14-08-1290', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (107, 291, 'dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non', to_date('22-09-2007', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (108, 104, 'eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat', to_date('10-12-1716', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (109, 218, 'justo aliquam quis turpis eget elit sodales scelerisque mauris sit', to_date('16-07-1548', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (110, 166, 'eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis', to_date('15-09-1938', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (111, 382, 'sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat', to_date('09-06-1429', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (112, 248, 'dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque', to_date('08-10-1463', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (113, 300, 'felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed', to_date('16-07-1357', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (114, 25, 'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl', to_date('31-07-1764', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (115, 32, 'id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam', to_date('18-06-1419', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (116, 43, 'mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy', to_date('24-12-1847', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (117, 150, 'sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et', to_date('16-06-1221', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (118, 185, 'purus aliquet at feugiat non pretium quis lectus suspendisse potenti', to_date('06-03-1258', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (119, 272, 'dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa', to_date('12-10-1471', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (120, 363, 'sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel', to_date('26-04-1861', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (121, 301, 'ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum', to_date('13-08-1868', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (122, 114, 'pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit', to_date('13-03-1805', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (123, 154, 'in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit', to_date('14-02-1409', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (124, 302, 'nulla integer pede justo lacinia eget tincidunt eget tempus vel', to_date('09-07-1999', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (125, 331, 'feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa', to_date('09-10-1428', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (126, 284, 'justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus', to_date('12-09-1457', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (127, 252, 'pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium', to_date('26-07-1818', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (128, 29, 'nunc purus phasellus in felis donec semper sapien a libero nam dui', to_date('05-03-1745', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (129, 388, 'faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna', to_date('08-03-1578', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (130, 25, 'tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in', to_date('19-05-1219', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (131, 74, 'interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac', to_date('07-12-1597', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (132, 240, 'consequat lectus in est risus auctor sed tristique in tempus', to_date('27-03-1231', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (133, 232, 'dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc', to_date('02-01-1441', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (134, 121, 'mauris enim leo rhoncus sed vestibulum sit amet cursus id', to_date('19-04-1371', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (135, 368, 'sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus', to_date('13-11-1891', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (136, 222, 'ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero', to_date('30-03-1629', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (137, 173, 'etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit', to_date('23-12-1996', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (138, 51, 'duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam', to_date('09-09-1774', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (139, 111, 'amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate', to_date('26-12-1562', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (140, 337, 'auctor gravida sem praesent id massa id nisl venenatis lacinia', to_date('03-08-1540', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (141, 18, 'aliquam convallis nunc proin at turpis a pede posuere nonummy integer', to_date('30-07-1516', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (142, 294, 'vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum', to_date('06-09-1724', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (143, 37, 'lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer', to_date('05-07-1669', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (144, 288, 'a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at', to_date('18-11-1907', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (145, 132, 'lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a', to_date('05-02-1538', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (146, 345, 'iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus', to_date('30-03-1980', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (147, 169, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus', to_date('11-09-1323', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (148, 141, 'nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula', to_date('28-02-1265', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (149, 33, 'dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet', to_date('23-11-1814', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (150, 177, 'erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate', to_date('16-06-1276', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (151, 23, 'turpis sed ante vivamus tortor duis mattis egestas metus aenean', to_date('18-10-1959', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (152, 196, 'eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor', to_date('27-09-1669', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (153, 121, 'mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum', to_date('30-07-1800', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (154, 29, 'luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor', to_date('06-08-1811', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (155, 40, 'lobortis vel dapibus at diam nam tristique tortor eu pede', to_date('01-10-1932', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (156, 396, 'rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam', to_date('05-02-2011', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (157, 176, 'erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer', to_date('01-01-1606', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (158, 227, 'diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis', to_date('30-06-1508', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (159, 146, 'sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non', to_date('08-11-1335', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (160, 83, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio', to_date('01-07-1602', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (161, 165, 'potenti in eleifend quam a odio in hac habitasse platea dictumst', to_date('09-11-1629', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (162, 67, 'quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa', to_date('26-04-1720', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (163, 311, 'luctus nec molestie sed justo pellentesque viverra pede ac diam cras', to_date('28-04-1421', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (164, 247, 'ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt', to_date('28-01-1250', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (165, 116, 'phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean', to_date('30-10-1317', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (166, 143, 'libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis', to_date('22-02-1579', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (167, 320, 'mauris lacinia sapien quis libero nullam sit amet turpis elementum', to_date('14-05-1846', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (168, 44, 'rutrum rutrum neque aenean auctor gravida sem praesent id massa id', to_date('19-05-1865', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (169, 227, 'sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent', to_date('30-03-1214', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (170, 218, 'quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero', to_date('09-02-1348', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (171, 15, 'sapien non mi integer ac neque duis bibendum morbi non quam', to_date('05-11-1780', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (172, 165, 'nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis', to_date('19-03-1657', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (173, 172, 'tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at', to_date('01-05-1390', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (174, 366, 'placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi', to_date('19-06-1495', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (175, 344, 'id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac', to_date('18-09-1667', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (176, 6, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices', to_date('14-07-1723', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (177, 348, 'id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam', to_date('29-07-2000', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (178, 234, 'pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh', to_date('04-09-1421', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (179, 225, 'massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut', to_date('19-07-1990', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (180, 81, 'nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula', to_date('14-04-1818', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (181, 287, 'at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed', to_date('30-10-1798', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (182, 138, 'pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae', to_date('03-09-1998', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (183, 185, 'tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque', to_date('30-09-1681', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (184, 67, 'in faucibus orci luctus et ultrices posuere cubilia curae duis', to_date('13-07-1252', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (185, 30, 'ac neque duis bibendum morbi non quam nec dui luctus', to_date('13-10-1448', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (186, 110, 'pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis', to_date('20-05-1349', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (187, 353, 'tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum', to_date('08-07-1565', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (188, 363, 'blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus', to_date('17-10-1291', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (189, 367, 'curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi', to_date('03-11-1866', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (190, 144, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae', to_date('15-11-1933', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (191, 87, 'lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam', to_date('10-02-1341', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (192, 233, 'donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed', to_date('04-05-1424', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (193, 39, 'etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius', to_date('11-01-2015', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (194, 234, 'habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt', to_date('03-02-1407', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (195, 113, 'ac tellus semper interdum mauris ullamcorper purus sit amet nulla', to_date('08-10-1340', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (196, 222, 'tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis', to_date('05-10-1574', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (197, 357, 'dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices', to_date('25-06-1317', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (198, 258, 'eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin', to_date('28-06-1991', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (199, 392, 'sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum', to_date('07-07-1692', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (200, 364, 'lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros', to_date('24-01-1312', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (201, 132, 'risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum', to_date('03-09-1425', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (202, 133, 'primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse', to_date('05-08-1461', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (203, 254, 'diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam', to_date('28-08-1902', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (204, 124, 'nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing', to_date('24-04-1688', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (205, 384, 'in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo', to_date('11-12-1874', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (206, 269, 'in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum', to_date('15-08-1666', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (207, 385, 'eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo', to_date('27-09-1985', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (208, 370, 'morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit', to_date('28-08-1254', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (209, 176, 'et magnis dis parturient montes nascetur ridiculus mus etiam vel', to_date('14-12-1362', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (210, 360, 'interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing', to_date('29-01-1284', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (211, 35, 'quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non', to_date('04-04-1916', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (212, 114, 'dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut', to_date('13-09-1381', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (213, 318, 'felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis', to_date('06-02-1870', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (214, 218, 'felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl', to_date('20-07-1300', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (215, 314, 'arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque', to_date('03-05-1717', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (216, 329, 'et magnis dis parturient montes nascetur ridiculus mus etiam vel augue', to_date('18-12-1202', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (217, 222, 'fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a', to_date('28-11-1375', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (218, 365, 'lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti', to_date('02-05-1217', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (219, 2, 'curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia', to_date('16-07-1717', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (220, 243, 'ac enim in tempor turpis nec euismod scelerisque quam turpis', to_date('18-04-1297', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (221, 363, 'dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut', to_date('31-12-1521', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (222, 355, 'faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin', to_date('11-08-1866', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (223, 337, 'in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices', to_date('02-06-1733', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (224, 340, 'sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis', to_date('26-04-1679', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (225, 194, 'nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit', to_date('22-06-1470', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (226, 74, 'ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla', to_date('29-12-1458', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (227, 7, 'sagittis nam congue risus semper porta volutpat quam pede lobortis', to_date('07-11-1631', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (228, 330, 'vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non', to_date('07-08-1587', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (229, 76, 'tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna', to_date('26-02-1831', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (230, 163, 'amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed', to_date('18-11-1972', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (231, 364, 'orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in', to_date('18-11-1324', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (232, 200, 'est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi', to_date('21-04-1757', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (233, 58, 'tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa', to_date('12-12-1537', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (234, 224, 'libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus', to_date('26-12-1752', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (235, 315, 'et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat', to_date('26-11-1412', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (236, 44, 'in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo', to_date('15-05-1744', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (237, 209, 'quis orci eget orci vehicula condimentum curabitur in libero ut', to_date('06-07-1472', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (238, 313, 'adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien', to_date('05-09-1314', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (239, 247, 'in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum', to_date('05-02-1694', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (240, 206, 'dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula', to_date('06-06-1367', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (241, 248, 'quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum', to_date('06-04-1974', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (242, 238, 'semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac', to_date('09-02-1700', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (243, 230, 'ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet', to_date('10-01-1930', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (244, 147, 'curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi', to_date('18-03-1929', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (245, 287, 'at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate', to_date('20-07-1745', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (246, 337, 'felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa', to_date('29-12-1455', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (247, 280, 'fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu', to_date('14-12-1916', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (248, 170, 'vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis', to_date('03-01-1626', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (249, 330, 'neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet', to_date('03-05-1918', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (250, 178, 'suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna', to_date('09-02-1227', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (251, 254, 'interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla', to_date('22-04-1448', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (252, 366, 'eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus', to_date('03-03-1473', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (253, 151, 'dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris', to_date('10-11-1991', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (254, 386, 'sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor', to_date('06-06-1721', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (255, 237, 'donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi', to_date('24-02-1323', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (256, 268, 'quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in', to_date('01-03-1810', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (257, 80, 'massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh', to_date('15-06-1455', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (258, 5, 'praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio', to_date('08-03-1484', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (259, 327, 'mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac', to_date('26-11-1235', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (260, 227, 'vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id', to_date('08-12-1570', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (261, 200, 'proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus', to_date('12-04-1326', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (262, 59, 'mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit', to_date('10-08-1236', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (263, 280, 'id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac', to_date('26-10-1462', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (264, 137, 'maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros', to_date('18-05-1637', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (265, 151, 'at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id', to_date('06-11-1347', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (266, 64, 'eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti', to_date('16-03-1244', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (267, 400, 'eros elementum pellentesque quisque porta volutpat erat quisque erat eros', to_date('25-01-1576', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (268, 96, 'sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus', to_date('27-07-1521', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (269, 161, 'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio', to_date('18-03-1730', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (270, 299, 'nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at', to_date('19-04-1259', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (271, 355, 'augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia', to_date('21-01-2000', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (272, 26, 'dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis', to_date('03-01-1512', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (273, 145, 'lorem ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum', to_date('01-08-1520', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (274, 93, 'faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut', to_date('03-04-1225', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (275, 265, 'justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales', to_date('01-09-1387', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (276, 268, 'in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan', to_date('20-06-1974', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (277, 106, 'urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate', to_date('17-12-1841', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (278, 157, 'risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci', to_date('27-05-1482', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (279, 175, 'nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id', to_date('20-11-1542', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (280, 191, 'magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus', to_date('28-03-1281', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (281, 330, 'odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras', to_date('02-08-1830', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (282, 390, 'etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam', to_date('21-05-1761', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (283, 362, 'nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi', to_date('15-03-1444', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (284, 215, 'duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor', to_date('05-02-1448', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (285, 299, 'parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque', to_date('20-08-1654', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (286, 57, 'ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi', to_date('25-08-1561', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (287, 132, 'odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar', to_date('26-11-1320', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (288, 22, 'posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet', to_date('27-08-1451', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (289, 316, 'interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing', to_date('06-02-1913', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (290, 2, 'libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu', to_date('08-04-1958', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (291, 388, 'lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu', to_date('26-10-1992', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (292, 315, 'justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices', to_date('25-07-1250', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (293, 15, 'curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus', to_date('23-05-1944', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (294, 118, 'platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia', to_date('17-02-1868', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (295, 215, 'molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur', to_date('02-11-1353', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (296, 19, 'semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero', to_date('13-07-1980', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (297, 76, 'lectus pellentesque at nulla suspendisse potenti cras in purus eu magna', to_date('08-11-1586', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (298, 397, 'eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus', to_date('02-04-1561', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (299, 235, 'non quam nec dui luctus rutrum nulla tellus in sagittis dui', to_date('31-03-1501', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (300, 399, 'sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in', to_date('14-12-1827', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (301, 241, 'nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit', to_date('07-06-1631', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (302, 205, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat', to_date('02-02-1518', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (303, 315, 'adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy', to_date('12-04-1766', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (304, 8, 'faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est', to_date('12-03-1679', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (305, 161, 'nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla', to_date('13-11-1745', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (306, 390, 'pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris', to_date('12-03-1410', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (307, 255, 'lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat', to_date('10-12-1967', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (308, 19, 'sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque', to_date('04-07-1981', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (309, 392, 'curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque', to_date('08-05-1314', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (310, 198, 'vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget', to_date('30-12-1489', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (311, 190, 'sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus', to_date('19-06-1616', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (312, 72, 'ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam', to_date('15-07-1571', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (313, 230, 'pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem', to_date('15-03-1841', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (314, 268, 'maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo', to_date('26-04-1952', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (315, 135, 'est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin', to_date('06-04-1756', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (316, 360, 'suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper', to_date('21-06-1896', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (317, 352, 'suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non', to_date('05-01-1909', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (318, 172, 'vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper', to_date('18-01-1402', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (319, 62, 'quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin', to_date('07-10-1475', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (320, 192, 'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices', to_date('26-10-1498', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (321, 78, 'vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa', to_date('21-09-1809', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (322, 288, 'tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat', to_date('27-01-1726', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (323, 363, 'luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas', to_date('04-05-1873', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (324, 93, 'est quam pharetra magna ac consequat metus sapien ut nunc', to_date('17-03-1862', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (325, 220, 'orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum', to_date('12-06-1590', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (326, 204, 'lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero', to_date('30-10-1906', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (327, 295, 'aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero', to_date('27-03-1891', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (328, 316, 'pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis', to_date('24-07-1654', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (329, 311, 'in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero', to_date('14-01-1225', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (330, 390, 'pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate', to_date('12-09-1260', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (331, 341, 'fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque', to_date('20-10-1428', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (332, 171, 'in ante vestibulum ante ipsum primis in faucibus orci luctus et', to_date('28-07-1851', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (333, 170, 'in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio', to_date('28-08-1340', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (334, 276, 'fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel', to_date('27-01-1647', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (335, 100, 'dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi', to_date('05-04-1590', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (336, 49, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio', to_date('30-10-1591', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (337, 303, 'porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non', to_date('12-11-1347', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (338, 367, 'diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris', to_date('23-10-1780', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (339, 104, 'lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum', to_date('24-12-1342', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (340, 28, 'massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas', to_date('17-03-1383', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (341, 224, 'integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor', to_date('28-06-1850', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (342, 48, 'in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis', to_date('25-04-1964', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (343, 288, 'enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet', to_date('15-05-1558', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (344, 101, 'vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit', to_date('04-12-1853', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (345, 118, 'platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat', to_date('10-03-1998', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (346, 388, 'rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi', to_date('11-04-1502', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (347, 344, 'mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at', to_date('22-09-1495', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (348, 244, 'consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis', to_date('19-10-1842', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (349, 194, 'libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum', to_date('14-12-1569', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (350, 395, 'erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien', to_date('15-08-1914', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (351, 372, 'dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras', to_date('14-10-1204', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (352, 270, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris', to_date('03-03-1862', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (353, 383, 'magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum', to_date('17-01-1759', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (354, 49, 'nullam orci pede venenatis non sodales sed tincidunt eu felis fusce', to_date('03-03-1466', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (355, 239, 'mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus', to_date('10-01-1591', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (356, 121, 'erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec', to_date('10-07-1443', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (357, 241, 'sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim', to_date('26-03-1879', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (358, 94, 'vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet', to_date('07-12-1429', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (359, 3, 'pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est', to_date('15-06-1522', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (360, 271, 'amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis', to_date('28-02-1605', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (361, 174, 'non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales', to_date('07-07-1881', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (362, 265, 'interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus', to_date('21-07-1261', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (363, 224, 'id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel', to_date('14-02-1938', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (364, 266, 'tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi', to_date('12-04-1368', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (365, 183, 'velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel', to_date('05-01-1329', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (366, 369, 'ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse', to_date('23-11-1743', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (367, 75, 'posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet', to_date('06-04-1588', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (368, 207, 'leo odio porttitor id consequat in consequat ut nulla sed', to_date('23-03-1469', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (369, 392, 'habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius', to_date('28-12-1319', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (370, 45, 'maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut', to_date('21-07-1959', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (371, 126, 'nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan', to_date('15-09-1733', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (372, 74, 'at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet', to_date('17-03-1391', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (373, 121, 'laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta', to_date('19-07-1906', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (374, 161, 'eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas', to_date('22-04-1954', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (375, 71, 'metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque', to_date('10-03-1368', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (376, 382, 'integer ac neque duis bibendum morbi non quam nec dui', to_date('15-04-1677', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (377, 100, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec', to_date('08-07-1381', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (378, 312, 'primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus', to_date('12-06-1468', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (379, 278, 'nisl nunc rhoncus dui vel sem sed sagittis nam congue', to_date('31-01-1417', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (380, 395, 'mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel', to_date('08-01-1979', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (381, 118, 'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh', to_date('13-02-1383', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (382, 84, 'orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus', to_date('21-06-1821', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (383, 196, 'at nulla suspendisse potenti cras in purus eu magna vulputate', to_date('12-06-1211', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (384, 94, 'est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus', to_date('29-05-1411', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (385, 358, 'ac leo pellentesque ultrices mattis odio donec vitae nisi nam', to_date('21-04-1545', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (386, 114, 'orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet', to_date('02-01-1749', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (387, 239, 'parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum', to_date('18-05-1430', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (388, 323, 'felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing', to_date('16-01-2001', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (389, 397, 'iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget', to_date('08-12-1353', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (390, 214, 'lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris', to_date('30-10-1391', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (391, 168, 'semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut', to_date('18-05-1774', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (392, 137, 'tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut', to_date('20-10-1239', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (393, 75, 'erat fermentum justo nec condimentum neque sapien placerat ante nulla', to_date('16-01-1728', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (394, 385, 'molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus', to_date('26-01-1591', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (395, 240, 'in consequat ut nulla sed accumsan felis ut at dolor quis odio', to_date('07-02-1561', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (396, 15, 'sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris', to_date('27-03-1625', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (397, 280, 'pharetra magna ac consequat metus sapien ut nunc vestibulum ante', to_date('15-04-1230', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (398, 271, 'sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem', to_date('08-07-1865', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (399, 168, 'vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est', to_date('15-10-1821', 'dd-mm-yyyy'));
insert into DEVELOPMENT (developmentid, departmentid, initiative_type, initiative_date)
values (400, 122, 'in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie', to_date('09-03-1731', 'dd-mm-yyyy'));
commit;
prompt 400 records loaded
prompt Loading HUMAN_RESOURCE_MANAGEMENT...
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (1, 'pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem', to_date('26-02-2024', 'dd-mm-yyyy'), 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.' || chr(10) || '' || chr(10) || 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 365);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (2, 'justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi', to_date('01-10-2024', 'dd-mm-yyyy'), 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 228);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (3, 'ornare consequat lectus in est risus auctor sed tristique in tempus sit', to_date('06-09-2022', 'dd-mm-yyyy'), 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 346);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (4, 'justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis', to_date('01-11-2021', 'dd-mm-yyyy'), 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 379);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (5, 'odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel', to_date('29-12-2024', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.' || chr(10) || '' || chr(10) || 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 299);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (6, 'turpis adipiscing lorem vitae mattis nibh ligula nec sem duis', to_date('23-09-2020', 'dd-mm-yyyy'), 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 18);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (7, 'morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem', to_date('07-08-2022', 'dd-mm-yyyy'), 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 225);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (8, 'vestibulum sed magna at nunc commodo placerat praesent blandit nam', to_date('25-02-2022', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 304);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (9, 'mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer', to_date('22-09-2023', 'dd-mm-yyyy'), 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 392);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (10, 'a pede posuere nonummy integer non velit donec diam neque vestibulum', to_date('24-05-2022', 'dd-mm-yyyy'), 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' || chr(10) || '' || chr(10) || 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 329);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (11, 'dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor', to_date('03-05-2024', 'dd-mm-yyyy'), 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 43);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (12, 'pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla', to_date('22-10-2020', 'dd-mm-yyyy'), 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 121);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (13, 'odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio', to_date('14-03-2020', 'dd-mm-yyyy'), 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 91);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (14, 'cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at', to_date('29-12-2023', 'dd-mm-yyyy'), 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.' || chr(10) || '' || chr(10) || 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 292);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (15, 'molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique', to_date('09-01-2022', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 138);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (16, 'ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet', to_date('04-03-2022', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.' || chr(10) || '' || chr(10) || 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 219);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (17, 'semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum', to_date('05-11-2020', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.' || chr(10) || '' || chr(10) || 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 264);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (18, 'amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit', to_date('02-08-2024', 'dd-mm-yyyy'), 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 16);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (19, 'sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus', to_date('24-02-2021', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 305);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (20, 'in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis', to_date('22-09-2024', 'dd-mm-yyyy'), 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 306);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (21, 'integer non velit donec diam neque vestibulum eget vulputate ut', to_date('06-03-2024', 'dd-mm-yyyy'), 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' || chr(10) || '' || chr(10) || 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', 339);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (22, 'nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et', to_date('10-07-2020', 'dd-mm-yyyy'), 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 80);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (23, 'pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus', to_date('21-03-2023', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 356);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (24, 'at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus', to_date('24-11-2023', 'dd-mm-yyyy'), 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 289);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (25, 'integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id', to_date('27-06-2020', 'dd-mm-yyyy'), 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 353);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (26, 'blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit', to_date('10-09-2020', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 328);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (27, 'mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum', to_date('21-03-2024', 'dd-mm-yyyy'), 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 333);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (28, 'ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in', to_date('17-06-2024', 'dd-mm-yyyy'), 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 269);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (29, 'quam sapien varius ut blandit non interdum in ante vestibulum ante', to_date('01-11-2021', 'dd-mm-yyyy'), 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 184);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (30, 'imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce', to_date('08-09-2023', 'dd-mm-yyyy'), 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 369);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (31, 'lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh', to_date('14-06-2021', 'dd-mm-yyyy'), 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 180);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (32, 'pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus', to_date('03-07-2021', 'dd-mm-yyyy'), 'Fusce consequat. Nulla nisl. Nunc nisl.' || chr(10) || '' || chr(10) || 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 217);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (33, 'tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare', to_date('22-11-2023', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 371);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (34, 'potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum', to_date('14-06-2020', 'dd-mm-yyyy'), 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 144);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (35, 'felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at', to_date('01-02-2023', 'dd-mm-yyyy'), 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.' || chr(10) || '' || chr(10) || 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.' || chr(10) || '' || chr(10) || 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', 54);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (36, 'etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl', to_date('10-08-2023', 'dd-mm-yyyy'), 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 227);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (37, 'a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium', to_date('06-11-2022', 'dd-mm-yyyy'), 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 268);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (38, 'habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget', to_date('18-08-2022', 'dd-mm-yyyy'), 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 253);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (39, 'arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis', to_date('23-11-2021', 'dd-mm-yyyy'), 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 275);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (40, 'convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam', to_date('01-04-2024', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 289);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (41, 'phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum', to_date('25-04-2023', 'dd-mm-yyyy'), 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 63);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (42, 'ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec', to_date('27-06-2020', 'dd-mm-yyyy'), 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.' || chr(10) || '' || chr(10) || 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 396);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (43, 'duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit', to_date('25-05-2021', 'dd-mm-yyyy'), 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 273);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (44, 'ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec', to_date('09-04-2023', 'dd-mm-yyyy'), 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 282);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (45, 'pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit', to_date('09-08-2020', 'dd-mm-yyyy'), 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 352);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (46, 'ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat', to_date('17-10-2021', 'dd-mm-yyyy'), 'Phasellus in felis. Donec semper sapien a libero. Nam dui.' || chr(10) || '' || chr(10) || 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 302);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (47, 'orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a', to_date('06-07-2021', 'dd-mm-yyyy'), 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 279);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (48, 'id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et', to_date('13-08-2024', 'dd-mm-yyyy'), 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', 103);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (49, 'justo eu massa donec dapibus duis at velit eu est congue elementum in hac', to_date('01-05-2020', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 258);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (50, 'lorem ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien', to_date('12-01-2024', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 173);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (51, 'auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede', to_date('09-11-2021', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.' || chr(10) || '' || chr(10) || 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 364);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (52, 'viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper', to_date('22-04-2020', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 366);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (53, 'sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam', to_date('09-07-2020', 'dd-mm-yyyy'), 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 193);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (54, 'ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla', to_date('23-08-2022', 'dd-mm-yyyy'), 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.' || chr(10) || '' || chr(10) || 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 230);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (55, 'in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit', to_date('17-09-2020', 'dd-mm-yyyy'), 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 255);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (56, 'euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis', to_date('29-10-2021', 'dd-mm-yyyy'), 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.' || chr(10) || '' || chr(10) || 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 60);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (57, 'congue eget semper rutrum nulla nunc purus phasellus in felis donec semper', to_date('21-08-2024', 'dd-mm-yyyy'), 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 398);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (58, 'et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam', to_date('10-05-2020', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 223);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (59, 'diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et', to_date('19-10-2021', 'dd-mm-yyyy'), 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 341);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (60, 'molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique', to_date('04-12-2020', 'dd-mm-yyyy'), 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 310);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (61, 'vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum', to_date('18-11-2020', 'dd-mm-yyyy'), 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 126);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (62, 'sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum', to_date('14-11-2023', 'dd-mm-yyyy'), 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 138);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (63, 'eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus', to_date('30-05-2022', 'dd-mm-yyyy'), 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 375);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (64, 'lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed', to_date('24-12-2020', 'dd-mm-yyyy'), 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 246);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (65, 'sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan', to_date('02-02-2022', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 363);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (66, 'posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor', to_date('25-07-2020', 'dd-mm-yyyy'), 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 259);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (67, 'ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi', to_date('29-06-2022', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 25);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (68, 'in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui', to_date('15-11-2021', 'dd-mm-yyyy'), 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.', 308);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (69, 'ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in', to_date('22-01-2021', 'dd-mm-yyyy'), 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.' || chr(10) || '' || chr(10) || 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.' || chr(10) || '' || chr(10) || 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 62);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (70, 'vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum', to_date('20-09-2024', 'dd-mm-yyyy'), 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 287);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (71, 'mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec', to_date('24-11-2022', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 323);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (72, 'arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo', to_date('15-02-2023', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 309);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (73, 'tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam', to_date('06-04-2021', 'dd-mm-yyyy'), 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 314);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (74, 'metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend', to_date('06-11-2020', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 300);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (75, 'auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl', to_date('22-10-2024', 'dd-mm-yyyy'), 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 238);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (76, 'lectus vestibulum quam sapien varius ut blandit non interdum in ante', to_date('09-05-2023', 'dd-mm-yyyy'), 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' || chr(10) || '' || chr(10) || 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 382);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (77, 'magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis', to_date('16-03-2022', 'dd-mm-yyyy'), 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 369);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (78, 'amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue', to_date('28-09-2021', 'dd-mm-yyyy'), 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 239);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (79, 'diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus', to_date('02-04-2022', 'dd-mm-yyyy'), 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 195);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (80, 'potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut', to_date('05-12-2023', 'dd-mm-yyyy'), 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 97);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (81, 'felis ut at dolor quis odio consequat varius integer ac', to_date('13-12-2020', 'dd-mm-yyyy'), 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 115);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (82, 'lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis', to_date('29-10-2023', 'dd-mm-yyyy'), 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 54);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (83, 'a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut', to_date('18-12-2022', 'dd-mm-yyyy'), 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 356);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (84, 'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero', to_date('28-03-2021', 'dd-mm-yyyy'), 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.' || chr(10) || '' || chr(10) || 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 328);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (85, 'in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium', to_date('02-08-2024', 'dd-mm-yyyy'), 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 25);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (86, 'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci', to_date('11-06-2020', 'dd-mm-yyyy'), 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 146);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (87, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam', to_date('11-09-2024', 'dd-mm-yyyy'), 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 285);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (88, 'facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit', to_date('16-03-2020', 'dd-mm-yyyy'), 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', 301);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (89, 'augue a suscipit nulla elit ac nulla sed vel enim', to_date('09-06-2020', 'dd-mm-yyyy'), 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 24);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (90, 'condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat', to_date('09-01-2022', 'dd-mm-yyyy'), 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' || chr(10) || '' || chr(10) || 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 182);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (91, 'placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor', to_date('02-11-2021', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 248);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (92, 'vitae consectetuer eget rutrum at lorem integer tincidunt ante vel', to_date('04-06-2023', 'dd-mm-yyyy'), 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 140);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (93, 'vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit', to_date('17-12-2024', 'dd-mm-yyyy'), 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 95);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (94, 'mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus', to_date('15-02-2021', 'dd-mm-yyyy'), 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 352);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (95, 'cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam', to_date('01-07-2024', 'dd-mm-yyyy'), 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 57);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (96, 'nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi', to_date('12-04-2020', 'dd-mm-yyyy'), 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 383);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (97, 'ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis', to_date('26-06-2020', 'dd-mm-yyyy'), 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 38);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (98, 'dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum', to_date('05-03-2022', 'dd-mm-yyyy'), 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 232);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (99, 'at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede', to_date('26-02-2024', 'dd-mm-yyyy'), 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 90);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (100, 'nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed', to_date('15-01-2021', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 377);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (101, 'vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor', to_date('13-01-2023', 'dd-mm-yyyy'), 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 38);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (102, 'sit amet justo morbi ut odio cras mi pede malesuada in imperdiet', to_date('21-11-2021', 'dd-mm-yyyy'), 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.' || chr(10) || '' || chr(10) || 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 317);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (103, 'vivamus in felis eu sapien cursus vestibulum proin eu mi', to_date('18-08-2023', 'dd-mm-yyyy'), 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' || chr(10) || '' || chr(10) || 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 354);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (104, 'arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis', to_date('24-06-2022', 'dd-mm-yyyy'), 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 131);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (105, 'eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec', to_date('22-11-2022', 'dd-mm-yyyy'), 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.' || chr(10) || '' || chr(10) || 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 43);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (106, 'vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy', to_date('23-05-2021', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 18);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (107, 'felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed', to_date('22-07-2023', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 65);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (108, 'metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices', to_date('21-08-2020', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 211);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (109, 'eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis', to_date('18-12-2022', 'dd-mm-yyyy'), 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.', 262);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (110, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia', to_date('17-12-2021', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 196);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (111, 'sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices', to_date('27-09-2023', 'dd-mm-yyyy'), 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.' || chr(10) || '' || chr(10) || 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 127);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (112, 'nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non', to_date('28-02-2020', 'dd-mm-yyyy'), 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 31);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (113, 'vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula', to_date('09-11-2021', 'dd-mm-yyyy'), 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 112);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (114, 'ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum', to_date('10-01-2023', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 388);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (115, 'augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst', to_date('02-03-2023', 'dd-mm-yyyy'), 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.' || chr(10) || '' || chr(10) || 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 280);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (116, 'erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum', to_date('15-04-2022', 'dd-mm-yyyy'), 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 381);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (117, 'felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio', to_date('19-07-2023', 'dd-mm-yyyy'), 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 311);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (118, 'vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci', to_date('01-09-2022', 'dd-mm-yyyy'), 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 309);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (119, 'vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis', to_date('21-11-2023', 'dd-mm-yyyy'), 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 159);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (120, 'curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi', to_date('24-06-2021', 'dd-mm-yyyy'), 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 140);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (121, 'at velit eu est congue elementum in hac habitasse platea dictumst morbi', to_date('03-04-2023', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 96);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (122, 'duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum', to_date('26-08-2024', 'dd-mm-yyyy'), 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 373);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (123, 'nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque', to_date('23-10-2024', 'dd-mm-yyyy'), 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 316);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (124, 'ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere', to_date('07-04-2024', 'dd-mm-yyyy'), 'Fusce consequat. Nulla nisl. Nunc nisl.' || chr(10) || '' || chr(10) || 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 59);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (125, 'sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem', to_date('18-01-2022', 'dd-mm-yyyy'), 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 10);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (126, 'luctus rutrum nulla tellus in sagittis dui vel nisl duis', to_date('31-03-2021', 'dd-mm-yyyy'), 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 292);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (127, 'hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci', to_date('14-06-2024', 'dd-mm-yyyy'), 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 395);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (128, 'blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae', to_date('18-08-2022', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 336);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (129, 'turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum', to_date('10-11-2023', 'dd-mm-yyyy'), 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.' || chr(10) || '' || chr(10) || 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 337);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (130, 'vulputate elementum nullam varius nulla facilisi cras non velit nec nisi', to_date('09-11-2023', 'dd-mm-yyyy'), 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 299);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (131, 'luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec', to_date('25-06-2021', 'dd-mm-yyyy'), 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.' || chr(10) || '' || chr(10) || 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.' || chr(10) || '' || chr(10) || 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', 259);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (132, 'faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam', to_date('28-11-2020', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 71);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (133, 'lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti', to_date('11-07-2022', 'dd-mm-yyyy'), 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 22);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (134, 'lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet', to_date('14-10-2020', 'dd-mm-yyyy'), 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.' || chr(10) || '' || chr(10) || 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 222);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (135, 'faucibus orci luctus et ultrices posuere cubilia curae mauris viverra', to_date('19-05-2022', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.' || chr(10) || '' || chr(10) || 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 232);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (136, 'lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin', to_date('17-08-2022', 'dd-mm-yyyy'), 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 35);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (137, 'suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa', to_date('11-01-2023', 'dd-mm-yyyy'), 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.' || chr(10) || '' || chr(10) || 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.' || chr(10) || '' || chr(10) || 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 94);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (138, 'libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet', to_date('24-02-2024', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 53);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (139, 'magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis', to_date('08-01-2020', 'dd-mm-yyyy'), 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 246);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (140, 'aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non', to_date('24-04-2020', 'dd-mm-yyyy'), 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', 285);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (141, 'potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus', to_date('26-03-2020', 'dd-mm-yyyy'), 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 83);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (142, 'faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi', to_date('20-04-2021', 'dd-mm-yyyy'), 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 137);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (143, 'vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit', to_date('14-04-2020', 'dd-mm-yyyy'), 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.' || chr(10) || '' || chr(10) || 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 127);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (144, 'proin risus praesent lectus vestibulum quam sapien varius ut blandit', to_date('07-06-2023', 'dd-mm-yyyy'), 'In congue. Etiam justo. Etiam pretium iaculis justo.', 29);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (145, 'volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc', to_date('10-02-2021', 'dd-mm-yyyy'), 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 356);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (146, 'vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis', to_date('31-10-2022', 'dd-mm-yyyy'), 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 298);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (147, 'nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio', to_date('22-06-2021', 'dd-mm-yyyy'), 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.' || chr(10) || '' || chr(10) || 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 351);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (148, 'tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum', to_date('22-09-2024', 'dd-mm-yyyy'), 'Fusce consequat. Nulla nisl. Nunc nisl.', 199);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (149, 'in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed', to_date('19-03-2020', 'dd-mm-yyyy'), 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.', 46);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (150, 'potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non', to_date('26-12-2022', 'dd-mm-yyyy'), 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 156);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (151, 'blandit mi in porttitor pede justo eu massa donec dapibus duis at', to_date('29-12-2021', 'dd-mm-yyyy'), 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 53);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (152, 'eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus', to_date('22-04-2022', 'dd-mm-yyyy'), 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 76);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (153, 'vel nisl duis ac nibh fusce lacus purus aliquet at feugiat', to_date('13-01-2023', 'dd-mm-yyyy'), 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 62);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (154, 'fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id', to_date('05-08-2022', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 61);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (155, 'suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam', to_date('28-02-2020', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 295);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (156, 'vivamus in felis eu sapien cursus vestibulum proin eu mi', to_date('18-10-2024', 'dd-mm-yyyy'), 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.' || chr(10) || '' || chr(10) || 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 181);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (157, 'sit amet cursus id turpis integer aliquet massa id lobortis convallis', to_date('06-02-2020', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 323);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (158, 'nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at', to_date('05-07-2023', 'dd-mm-yyyy'), 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 177);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (159, 'nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non', to_date('12-01-2022', 'dd-mm-yyyy'), 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 207);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (160, 'blandit lacinia erat vestibulum sed magna at nunc commodo placerat', to_date('16-07-2023', 'dd-mm-yyyy'), 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 54);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (161, 'ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut', to_date('14-02-2021', 'dd-mm-yyyy'), 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 299);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (162, 'pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam', to_date('28-04-2022', 'dd-mm-yyyy'), 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 372);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (163, 'nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a', to_date('11-06-2024', 'dd-mm-yyyy'), 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 323);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (164, 'auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc', to_date('28-08-2023', 'dd-mm-yyyy'), 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 116);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (165, 'mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem', to_date('07-11-2024', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 320);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (166, 'ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam', to_date('22-07-2021', 'dd-mm-yyyy'), 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 298);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (167, 'pretium quis lectus suspendisse potenti in eleifend quam a odio', to_date('03-02-2022', 'dd-mm-yyyy'), 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 196);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (168, 'nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam', to_date('01-01-2024', 'dd-mm-yyyy'), 'Fusce consequat. Nulla nisl. Nunc nisl.' || chr(10) || '' || chr(10) || 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 126);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (169, 'id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices', to_date('27-01-2024', 'dd-mm-yyyy'), 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', 208);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (170, 'integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in', to_date('25-09-2020', 'dd-mm-yyyy'), 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 40);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (171, 'cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan', to_date('27-01-2023', 'dd-mm-yyyy'), 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 25);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (172, 'volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo', to_date('19-10-2024', 'dd-mm-yyyy'), 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.' || chr(10) || '' || chr(10) || 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 93);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (173, 'hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque', to_date('27-07-2022', 'dd-mm-yyyy'), 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 228);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (174, 'vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit', to_date('09-12-2022', 'dd-mm-yyyy'), 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 284);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (175, 'nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit', to_date('09-01-2020', 'dd-mm-yyyy'), 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 203);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (176, 'gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet', to_date('04-06-2022', 'dd-mm-yyyy'), 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 266);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (177, 'sit amet eleifend pede libero quis orci nullam molestie nibh', to_date('07-08-2021', 'dd-mm-yyyy'), 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 339);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (178, 'varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus', to_date('07-06-2021', 'dd-mm-yyyy'), 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' || chr(10) || '' || chr(10) || 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 272);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (179, 'pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat', to_date('05-11-2021', 'dd-mm-yyyy'), 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' || chr(10) || '' || chr(10) || 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 376);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (180, 'libero nullam sit amet turpis elementum ligula vehicula consequat morbi', to_date('13-06-2020', 'dd-mm-yyyy'), 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.', 162);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (181, 'fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed', to_date('11-02-2022', 'dd-mm-yyyy'), 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 107);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (182, 'vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices', to_date('08-05-2024', 'dd-mm-yyyy'), 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.' || chr(10) || '' || chr(10) || 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 334);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (183, 'pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor', to_date('04-10-2022', 'dd-mm-yyyy'), 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 359);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (184, 'luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor', to_date('16-04-2023', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 224);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (185, 'consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam', to_date('16-07-2024', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 202);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (186, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec', to_date('20-10-2024', 'dd-mm-yyyy'), 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 234);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (187, 'eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim', to_date('28-12-2023', 'dd-mm-yyyy'), 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 18);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (188, 'felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec', to_date('01-08-2021', 'dd-mm-yyyy'), 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 233);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (189, 'mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam', to_date('15-03-2024', 'dd-mm-yyyy'), 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 164);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (190, 'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere', to_date('07-05-2020', 'dd-mm-yyyy'), 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 202);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (191, 'condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar', to_date('16-03-2023', 'dd-mm-yyyy'), 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 392);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (192, 'montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor', to_date('24-05-2022', 'dd-mm-yyyy'), 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 244);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (193, 'odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi', to_date('20-04-2021', 'dd-mm-yyyy'), 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 235);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (194, 'in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus', to_date('21-01-2021', 'dd-mm-yyyy'), 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 379);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (195, 'nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl', to_date('08-05-2024', 'dd-mm-yyyy'), 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 201);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (196, 'semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam', to_date('05-11-2024', 'dd-mm-yyyy'), 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 161);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (197, 'tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat', to_date('21-03-2020', 'dd-mm-yyyy'), 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 1);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (198, 'bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris', to_date('19-12-2022', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 176);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (199, 'ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam', to_date('16-09-2022', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 361);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (200, 'convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim', to_date('31-12-2020', 'dd-mm-yyyy'), 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 215);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (201, 'dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut', to_date('25-06-2021', 'dd-mm-yyyy'), 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 310);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (202, 'sed tristique in tempus sit amet sem fusce consequat nulla nisl', to_date('27-11-2022', 'dd-mm-yyyy'), 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 290);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (203, 'turpis enim blandit mi in porttitor pede justo eu massa donec', to_date('16-09-2021', 'dd-mm-yyyy'), 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 260);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (204, 'sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in', to_date('06-12-2020', 'dd-mm-yyyy'), 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 79);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (205, 'odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique', to_date('11-10-2022', 'dd-mm-yyyy'), 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.' || chr(10) || '' || chr(10) || 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', 338);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (206, 'sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis', to_date('29-11-2023', 'dd-mm-yyyy'), 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', 215);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (207, 'et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend', to_date('18-06-2020', 'dd-mm-yyyy'), 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 369);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (208, 'eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus', to_date('12-02-2020', 'dd-mm-yyyy'), 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 242);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (209, 'cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra', to_date('22-05-2024', 'dd-mm-yyyy'), 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 32);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (210, 'morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est', to_date('01-11-2023', 'dd-mm-yyyy'), 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 88);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (211, 'ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy', to_date('24-07-2022', 'dd-mm-yyyy'), 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 250);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (212, 'eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan', to_date('24-07-2022', 'dd-mm-yyyy'), 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 241);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (213, 'enim blandit mi in porttitor pede justo eu massa donec', to_date('11-03-2022', 'dd-mm-yyyy'), 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 77);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (214, 'nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi', to_date('06-08-2021', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 27);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (215, 'pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse', to_date('08-03-2023', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 124);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (216, 'sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis', to_date('04-11-2024', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 116);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (217, 'accumsan felis ut at dolor quis odio consequat varius integer ac leo', to_date('07-03-2024', 'dd-mm-yyyy'), 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 104);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (218, 'sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis', to_date('16-09-2023', 'dd-mm-yyyy'), 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 145);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (219, 'ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla', to_date('27-10-2023', 'dd-mm-yyyy'), 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.' || chr(10) || '' || chr(10) || 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 270);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (220, 'posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna', to_date('21-03-2020', 'dd-mm-yyyy'), 'In congue. Etiam justo. Etiam pretium iaculis justo.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 105);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (221, 'quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere', to_date('23-08-2024', 'dd-mm-yyyy'), 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 204);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (222, 'id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo', to_date('04-03-2024', 'dd-mm-yyyy'), 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.' || chr(10) || '' || chr(10) || 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.' || chr(10) || '' || chr(10) || 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 64);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (223, 'non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit', to_date('05-04-2020', 'dd-mm-yyyy'), 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' || chr(10) || '' || chr(10) || 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 296);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (224, 'venenatis turpis enim blandit mi in porttitor pede justo eu massa donec', to_date('03-09-2024', 'dd-mm-yyyy'), 'Fusce consequat. Nulla nisl. Nunc nisl.', 157);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (225, 'consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel', to_date('16-09-2021', 'dd-mm-yyyy'), 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 391);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (226, 'in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc', to_date('12-03-2023', 'dd-mm-yyyy'), 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 357);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (227, 'dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc', to_date('01-10-2021', 'dd-mm-yyyy'), 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' || chr(10) || '' || chr(10) || 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 376);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (228, 'turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam', to_date('16-11-2022', 'dd-mm-yyyy'), 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 16);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (229, 'suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla', to_date('11-02-2023', 'dd-mm-yyyy'), 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.' || chr(10) || '' || chr(10) || 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.' || chr(10) || '' || chr(10) || 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 246);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (230, 'magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci', to_date('01-05-2024', 'dd-mm-yyyy'), 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 269);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (231, 'erat vestibulum sed magna at nunc commodo placerat praesent blandit', to_date('04-09-2024', 'dd-mm-yyyy'), 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 63);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (232, 'praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede', to_date('04-10-2020', 'dd-mm-yyyy'), 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 171);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (233, 'nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed', to_date('10-02-2023', 'dd-mm-yyyy'), 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 175);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (234, 'in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla', to_date('09-11-2023', 'dd-mm-yyyy'), 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 23);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (235, 'amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci', to_date('02-07-2021', 'dd-mm-yyyy'), 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 156);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (236, 'fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis', to_date('16-02-2021', 'dd-mm-yyyy'), 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 328);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (237, 'elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo', to_date('11-01-2020', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 360);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (238, 'elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum', to_date('12-11-2023', 'dd-mm-yyyy'), 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 313);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (239, 'at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget', to_date('23-04-2021', 'dd-mm-yyyy'), 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 169);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (240, 'turpis a pede posuere nonummy integer non velit donec diam', to_date('16-03-2022', 'dd-mm-yyyy'), 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 146);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (241, 'placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede', to_date('18-11-2022', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 243);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (242, 'pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est', to_date('05-06-2020', 'dd-mm-yyyy'), 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 177);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (243, 'platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat', to_date('27-07-2023', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 216);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (244, 'aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante', to_date('04-11-2024', 'dd-mm-yyyy'), 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 92);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (245, 'velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla', to_date('13-07-2020', 'dd-mm-yyyy'), 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.' || chr(10) || '' || chr(10) || 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 247);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (246, 'ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae', to_date('03-06-2022', 'dd-mm-yyyy'), 'In congue. Etiam justo. Etiam pretium iaculis justo.', 378);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (247, 'cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat', to_date('15-12-2023', 'dd-mm-yyyy'), 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 273);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (248, 'erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer', to_date('19-03-2020', 'dd-mm-yyyy'), 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 132);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (249, 'nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget', to_date('19-11-2020', 'dd-mm-yyyy'), 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 167);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (250, 'dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum', to_date('05-03-2020', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 245);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (251, 'nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est', to_date('13-08-2020', 'dd-mm-yyyy'), 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 192);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (252, 'volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla', to_date('20-10-2023', 'dd-mm-yyyy'), 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.', 97);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (253, 'luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non', to_date('09-04-2021', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 160);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (254, 'aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam', to_date('03-07-2021', 'dd-mm-yyyy'), 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 226);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (255, 'ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus', to_date('31-10-2021', 'dd-mm-yyyy'), 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 255);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (256, 'fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor', to_date('24-04-2024', 'dd-mm-yyyy'), 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.' || chr(10) || '' || chr(10) || 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 212);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (257, 'vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi', to_date('29-10-2022', 'dd-mm-yyyy'), 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 113);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (258, 'gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum', to_date('13-05-2022', 'dd-mm-yyyy'), 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 156);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (259, 'risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam', to_date('22-11-2024', 'dd-mm-yyyy'), 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 302);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (260, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia', to_date('31-08-2021', 'dd-mm-yyyy'), 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.', 255);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (261, 'eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit', to_date('09-10-2021', 'dd-mm-yyyy'), 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 255);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (262, 'augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac', to_date('22-04-2024', 'dd-mm-yyyy'), 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.', 59);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (263, 'vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in', to_date('12-09-2023', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 339);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (264, 'eget orci vehicula condimentum curabitur in libero ut massa volutpat', to_date('19-04-2023', 'dd-mm-yyyy'), 'Fusce consequat. Nulla nisl. Nunc nisl.' || chr(10) || '' || chr(10) || 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 183);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (265, 'eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec', to_date('30-06-2023', 'dd-mm-yyyy'), 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' || chr(10) || '' || chr(10) || 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 35);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (266, 'sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in', to_date('22-02-2020', 'dd-mm-yyyy'), 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 148);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (267, 'ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non', to_date('26-07-2024', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 176);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (268, 'sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue', to_date('18-08-2022', 'dd-mm-yyyy'), 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.' || chr(10) || '' || chr(10) || 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 174);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (269, 'interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus', to_date('26-06-2020', 'dd-mm-yyyy'), 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 374);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (270, 'donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis', to_date('11-04-2022', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 119);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (271, 'aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies', to_date('07-02-2024', 'dd-mm-yyyy'), 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 304);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (272, 'integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare', to_date('01-11-2023', 'dd-mm-yyyy'), 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 344);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (273, 'sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum', to_date('01-02-2020', 'dd-mm-yyyy'), 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' || chr(10) || '' || chr(10) || 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 185);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (274, 'elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in', to_date('08-07-2022', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 125);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (275, 'in hac habitasse platea dictumst maecenas ut massa quis augue luctus', to_date('24-03-2024', 'dd-mm-yyyy'), 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 349);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (276, 'eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper', to_date('03-04-2024', 'dd-mm-yyyy'), 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 171);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (277, 'dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae', to_date('28-05-2024', 'dd-mm-yyyy'), 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 163);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (278, 'elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus', to_date('08-04-2024', 'dd-mm-yyyy'), 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 13);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (279, 'hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci', to_date('26-03-2020', 'dd-mm-yyyy'), 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 330);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (280, 'sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus', to_date('12-10-2021', 'dd-mm-yyyy'), 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' || chr(10) || '' || chr(10) || 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 249);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (281, 'a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis', to_date('22-12-2021', 'dd-mm-yyyy'), 'In congue. Etiam justo. Etiam pretium iaculis justo.', 71);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (282, 'fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis', to_date('04-12-2024', 'dd-mm-yyyy'), 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 204);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (283, 'sed tincidunt eu felis fusce posuere felis sed lacus morbi sem', to_date('22-02-2024', 'dd-mm-yyyy'), 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 350);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (284, 'ut tellus nulla ut erat id mauris vulputate elementum nullam varius', to_date('29-03-2024', 'dd-mm-yyyy'), 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 264);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (285, 'enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in', to_date('15-09-2020', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 257);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (286, 'scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede', to_date('23-01-2022', 'dd-mm-yyyy'), 'Phasellus in felis. Donec semper sapien a libero. Nam dui.' || chr(10) || '' || chr(10) || 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 276);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (287, 'dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi', to_date('03-06-2022', 'dd-mm-yyyy'), 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.' || chr(10) || '' || chr(10) || 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 307);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (288, 'aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis', to_date('24-12-2021', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 154);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (289, 'aenean auctor gravida sem praesent id massa id nisl venenatis lacinia', to_date('16-04-2022', 'dd-mm-yyyy'), 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.' || chr(10) || '' || chr(10) || 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 361);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (290, 'turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam', to_date('06-09-2020', 'dd-mm-yyyy'), 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 303);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (291, 'posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue', to_date('01-04-2020', 'dd-mm-yyyy'), 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 159);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (292, 'odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi', to_date('26-07-2022', 'dd-mm-yyyy'), 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.' || chr(10) || '' || chr(10) || 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 26);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (293, 'mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue', to_date('13-02-2024', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.' || chr(10) || '' || chr(10) || 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 347);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (294, 'luctus nec molestie sed justo pellentesque viverra pede ac diam cras', to_date('31-01-2023', 'dd-mm-yyyy'), 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 161);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (295, 'pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque', to_date('21-09-2022', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 189);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (296, 'enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor', to_date('21-08-2021', 'dd-mm-yyyy'), 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 363);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (297, 'nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at', to_date('09-08-2023', 'dd-mm-yyyy'), 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 392);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (298, 'pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut', to_date('17-06-2024', 'dd-mm-yyyy'), 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 111);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (299, 'erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy', to_date('24-03-2024', 'dd-mm-yyyy'), 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 73);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (300, 'morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus', to_date('30-03-2021', 'dd-mm-yyyy'), 'Phasellus in felis. Donec semper sapien a libero. Nam dui.' || chr(10) || '' || chr(10) || 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 233);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (301, 'accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris', to_date('29-12-2022', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 240);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (302, 'mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh', to_date('27-04-2022', 'dd-mm-yyyy'), 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 341);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (303, 'tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam', to_date('20-02-2021', 'dd-mm-yyyy'), 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 359);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (304, 'vitae nisl aenean lectus pellentesque eget nunc donec quis orci', to_date('24-04-2023', 'dd-mm-yyyy'), 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 145);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (305, 'nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget', to_date('06-12-2021', 'dd-mm-yyyy'), 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.', 114);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (306, 'enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus', to_date('06-02-2021', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 395);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (307, 'curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget', to_date('08-01-2022', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 364);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (308, 'ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut', to_date('10-09-2022', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 229);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (309, 'sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst', to_date('03-05-2024', 'dd-mm-yyyy'), 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 313);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (310, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est', to_date('17-10-2020', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 270);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (311, 'at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo', to_date('18-02-2024', 'dd-mm-yyyy'), 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.' || chr(10) || '' || chr(10) || 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.' || chr(10) || '' || chr(10) || 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 115);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (312, 'ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit', to_date('26-06-2024', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 366);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (313, 'lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in', to_date('23-11-2023', 'dd-mm-yyyy'), 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 150);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (314, 'sapien sapien non mi integer ac neque duis bibendum morbi non quam nec', to_date('27-09-2024', 'dd-mm-yyyy'), 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 79);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (315, 'turpis a pede posuere nonummy integer non velit donec diam neque vestibulum', to_date('16-06-2020', 'dd-mm-yyyy'), 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 367);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (316, 'et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet', to_date('29-05-2023', 'dd-mm-yyyy'), 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 399);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (317, 'rhoncus dui vel sem sed sagittis nam congue risus semper porta', to_date('16-06-2021', 'dd-mm-yyyy'), 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.' || chr(10) || '' || chr(10) || 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.', 100);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (318, 'adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc', to_date('08-12-2023', 'dd-mm-yyyy'), 'Fusce consequat. Nulla nisl. Nunc nisl.', 308);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (319, 'ac diam cras pellentesque volutpat dui maecenas tristique est et tempus', to_date('24-04-2023', 'dd-mm-yyyy'), 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 207);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (320, 'nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus', to_date('26-01-2023', 'dd-mm-yyyy'), 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 206);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (321, 'cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus', to_date('01-08-2022', 'dd-mm-yyyy'), 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.' || chr(10) || '' || chr(10) || 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 11);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (322, 'nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas', to_date('16-07-2022', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 28);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (323, 'amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo', to_date('27-02-2022', 'dd-mm-yyyy'), 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 340);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (324, 'consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien', to_date('07-10-2022', 'dd-mm-yyyy'), 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 91);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (325, 'semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero', to_date('28-07-2022', 'dd-mm-yyyy'), 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' || chr(10) || '' || chr(10) || 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 32);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (326, 'at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam', to_date('03-03-2024', 'dd-mm-yyyy'), 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 341);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (327, 'ligula sit amet eleifend pede libero quis orci nullam molestie nibh in', to_date('07-07-2020', 'dd-mm-yyyy'), 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 361);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (328, 'turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue', to_date('11-04-2022', 'dd-mm-yyyy'), 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 54);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (329, 'luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse', to_date('12-03-2020', 'dd-mm-yyyy'), 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.' || chr(10) || '' || chr(10) || 'Phasellus in felis. Donec semper sapien a libero. Nam dui.' || chr(10) || '' || chr(10) || 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 130);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (330, 'ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam', to_date('27-07-2022', 'dd-mm-yyyy'), 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.' || chr(10) || '' || chr(10) || 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 230);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (331, 'nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus', to_date('27-05-2023', 'dd-mm-yyyy'), 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.' || chr(10) || '' || chr(10) || 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 24);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (332, 'habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam', to_date('03-06-2022', 'dd-mm-yyyy'), 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 157);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (333, 'vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes', to_date('15-11-2024', 'dd-mm-yyyy'), 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.', 47);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (334, 'odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla', to_date('02-08-2021', 'dd-mm-yyyy'), 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.' || chr(10) || '' || chr(10) || 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 21);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (335, 'lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede', to_date('29-02-2024', 'dd-mm-yyyy'), 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 256);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (336, 'suscipit nulla elit ac nulla sed vel enim sit amet', to_date('13-08-2023', 'dd-mm-yyyy'), 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 161);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (337, 'aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat', to_date('12-10-2024', 'dd-mm-yyyy'), 'Fusce consequat. Nulla nisl. Nunc nisl.', 26);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (338, 'convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien', to_date('26-10-2023', 'dd-mm-yyyy'), 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 357);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (339, 'varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla', to_date('06-10-2020', 'dd-mm-yyyy'), 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 212);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (340, 'sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis', to_date('13-06-2021', 'dd-mm-yyyy'), 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 300);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (341, 'sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices', to_date('14-06-2020', 'dd-mm-yyyy'), 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.' || chr(10) || '' || chr(10) || 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.' || chr(10) || '' || chr(10) || 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 226);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (342, 'justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique', to_date('19-04-2024', 'dd-mm-yyyy'), 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 260);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (343, 'pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem', to_date('26-10-2020', 'dd-mm-yyyy'), 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.' || chr(10) || '' || chr(10) || 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.' || chr(10) || '' || chr(10) || 'In congue. Etiam justo. Etiam pretium iaculis justo.', 148);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (344, 'lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam', to_date('25-07-2022', 'dd-mm-yyyy'), 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.' || chr(10) || '' || chr(10) || 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 318);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (345, 'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci', to_date('21-10-2023', 'dd-mm-yyyy'), 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.' || chr(10) || '' || chr(10) || 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 88);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (346, 'donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet', to_date('30-10-2023', 'dd-mm-yyyy'), 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 230);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (347, 'suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient', to_date('25-04-2024', 'dd-mm-yyyy'), 'Sed ante. Vivamus tortor. Duis mattis egestas metus.' || chr(10) || '' || chr(10) || 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.' || chr(10) || '' || chr(10) || 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 9);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (348, 'aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis', to_date('17-08-2023', 'dd-mm-yyyy'), 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.' || chr(10) || '' || chr(10) || 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 181);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (349, 'ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna', to_date('12-03-2023', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 201);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (350, 'nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam', to_date('14-09-2021', 'dd-mm-yyyy'), 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.' || chr(10) || '' || chr(10) || 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.' || chr(10) || '' || chr(10) || 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 177);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (351, 'rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus', to_date('22-06-2023', 'dd-mm-yyyy'), 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 189);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (352, 'in imperdiet et commodo vulputate justo in blandit ultrices enim', to_date('16-12-2023', 'dd-mm-yyyy'), 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.' || chr(10) || '' || chr(10) || 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 160);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (353, 'sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus', to_date('03-09-2021', 'dd-mm-yyyy'), 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.' || chr(10) || '' || chr(10) || 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 21);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (354, 'ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent', to_date('02-09-2022', 'dd-mm-yyyy'), 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 314);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (355, 'adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis', to_date('30-04-2023', 'dd-mm-yyyy'), 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 14);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (356, 'gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi', to_date('01-02-2023', 'dd-mm-yyyy'), 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 193);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (357, 'cras pellentesque volutpat dui maecenas tristique est et tempus semper', to_date('02-02-2023', 'dd-mm-yyyy'), 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 111);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (358, 'suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque', to_date('11-02-2024', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 6);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (359, 'platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam', to_date('30-09-2020', 'dd-mm-yyyy'), 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.' || chr(10) || '' || chr(10) || 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 276);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (360, 'consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla', to_date('21-09-2020', 'dd-mm-yyyy'), 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 201);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (361, 'orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum', to_date('19-08-2020', 'dd-mm-yyyy'), 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.' || chr(10) || '' || chr(10) || 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.' || chr(10) || '' || chr(10) || 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 151);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (362, 'pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus', to_date('04-06-2020', 'dd-mm-yyyy'), 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 20);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (363, 'sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in', to_date('05-06-2022', 'dd-mm-yyyy'), 'Fusce consequat. Nulla nisl. Nunc nisl.', 384);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (364, 'vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae', to_date('24-01-2020', 'dd-mm-yyyy'), 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 211);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (365, 'porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus', to_date('28-12-2023', 'dd-mm-yyyy'), 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.' || chr(10) || '' || chr(10) || 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 120);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (366, 'phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat', to_date('11-11-2023', 'dd-mm-yyyy'), 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 158);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (367, 'elementum ligula vehicula consequat morbi a ipsum integer a nibh', to_date('11-10-2022', 'dd-mm-yyyy'), 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 149);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (368, 'est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet', to_date('28-05-2022', 'dd-mm-yyyy'), 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 239);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (369, 'vitae consectetuer eget rutrum at lorem integer tincidunt ante vel', to_date('16-05-2020', 'dd-mm-yyyy'), 'Fusce consequat. Nulla nisl. Nunc nisl.' || chr(10) || '' || chr(10) || 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 369);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (370, 'faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor', to_date('22-02-2024', 'dd-mm-yyyy'), 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 170);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (371, 'ultrices vel augue vestibulum ante ipsum primis in faucibus orci', to_date('11-03-2020', 'dd-mm-yyyy'), 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 294);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (372, 'sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor', to_date('16-07-2021', 'dd-mm-yyyy'), 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.' || chr(10) || '' || chr(10) || 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 323);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (373, 'montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus', to_date('26-10-2022', 'dd-mm-yyyy'), 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 319);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (374, 'odio elementum eu interdum eu tincidunt in leo maecenas pulvinar', to_date('15-10-2020', 'dd-mm-yyyy'), 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 105);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (375, 'odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit', to_date('22-07-2023', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.' || chr(10) || '' || chr(10) || 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 129);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (376, 'at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet', to_date('18-09-2024', 'dd-mm-yyyy'), 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.' || chr(10) || '' || chr(10) || 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 25);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (377, 'nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis', to_date('10-04-2020', 'dd-mm-yyyy'), 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.' || chr(10) || '' || chr(10) || 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.' || chr(10) || '' || chr(10) || 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 193);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (378, 'risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis', to_date('26-03-2023', 'dd-mm-yyyy'), 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 171);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (379, 'viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit', to_date('04-06-2021', 'dd-mm-yyyy'), 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.' || chr(10) || '' || chr(10) || 'Fusce consequat. Nulla nisl. Nunc nisl.', 157);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (380, 'phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl', to_date('24-01-2022', 'dd-mm-yyyy'), 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 72);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (381, 'nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet', to_date('17-06-2020', 'dd-mm-yyyy'), 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 20);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (382, 'ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula', to_date('22-06-2023', 'dd-mm-yyyy'), 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 106);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (383, 'sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget', to_date('25-05-2022', 'dd-mm-yyyy'), 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 109);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (384, 'ut blandit non interdum in ante vestibulum ante ipsum primis in', to_date('05-10-2021', 'dd-mm-yyyy'), 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 119);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (385, 'aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis', to_date('28-12-2023', 'dd-mm-yyyy'), 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.' || chr(10) || '' || chr(10) || 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 197);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (386, 'mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis', to_date('09-01-2021', 'dd-mm-yyyy'), 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.' || chr(10) || '' || chr(10) || 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 78);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (387, 'sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur', to_date('18-03-2021', 'dd-mm-yyyy'), 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 166);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (388, 'et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien', to_date('23-11-2023', 'dd-mm-yyyy'), 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 7);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (389, 'faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin', to_date('12-10-2022', 'dd-mm-yyyy'), 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.' || chr(10) || '' || chr(10) || 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.' || chr(10) || '' || chr(10) || 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 173);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (390, 'adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut', to_date('12-10-2024', 'dd-mm-yyyy'), 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.' || chr(10) || '' || chr(10) || 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.' || chr(10) || '' || chr(10) || 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 259);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (391, 'enim blandit mi in porttitor pede justo eu massa donec dapibus duis at', to_date('18-05-2021', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 173);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (392, 'nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id', to_date('19-01-2024', 'dd-mm-yyyy'), 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 269);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (393, 'nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in', to_date('24-10-2023', 'dd-mm-yyyy'), 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 174);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (394, 'amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec', to_date('15-07-2023', 'dd-mm-yyyy'), 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 336);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (395, 'ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non', to_date('09-07-2023', 'dd-mm-yyyy'), 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 110);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (396, 'sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat', to_date('26-07-2020', 'dd-mm-yyyy'), 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 260);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (397, 'suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient', to_date('30-09-2023', 'dd-mm-yyyy'), 'In congue. Etiam justo. Etiam pretium iaculis justo.', 60);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (398, 'in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat', to_date('18-11-2023', 'dd-mm-yyyy'), 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.' || chr(10) || '' || chr(10) || 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.' || chr(10) || '' || chr(10) || 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 348);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (399, 'maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra', to_date('15-04-2022', 'dd-mm-yyyy'), 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.' || chr(10) || '' || chr(10) || 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 372);
insert into HUMAN_RESOURCE_MANAGEMENT (hractionid, actiontype, hra_date, description, employeeid)
values (400, 'montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque', to_date('09-05-2021', 'dd-mm-yyyy'), 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 105);
commit;
prompt 400 records loaded
prompt Enabling foreign key constraints for EMPLOYEE...
alter table EMPLOYEE enable constraint FK_EMPLOYEE_DEPARTMENT;
alter table EMPLOYEE enable constraint FK_EMPLOYEE_POSITION;
prompt Enabling foreign key constraints for ATTENDANCE...
alter table ATTENDANCE enable constraint FK_ATTENDANCE;
prompt Enabling foreign key constraints for DEVELOPMENT...
alter table DEVELOPMENT enable constraint FK_DEVELOPMENT;
prompt Enabling foreign key constraints for HUMAN_RESOURCE_MANAGEMENT...
alter table HUMAN_RESOURCE_MANAGEMENT enable constraint FK_HUMAN_RESOURCE_MANAGEMENT;
prompt Enabling triggers for POSITIONS...
alter table POSITIONS enable all triggers;
prompt Enabling triggers for DEPARTMENT...
alter table DEPARTMENT enable all triggers;
prompt Enabling triggers for EMPLOYEE...
alter table EMPLOYEE enable all triggers;
prompt Enabling triggers for ATTENDANCE...
alter table ATTENDANCE enable all triggers;
prompt Enabling triggers for DEVELOPMENT...
alter table DEVELOPMENT enable all triggers;
prompt Enabling triggers for HUMAN_RESOURCE_MANAGEMENT...
alter table HUMAN_RESOURCE_MANAGEMENT enable all triggers;

set feedback on
set define on
prompt Done
