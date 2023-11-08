create table users(
    num number primary key,
    user_id varchar(50) not null,
    user_pw varchar(200) not null,
    nickname varchar(200) not null,
    birth date not null,
    user_like_cnt number default 0,
    reg date default sysdate,
    user_name varchar(100) not null
);

--ALTER TABLE Users ADD user_name VARCHAR2(100);
alter table users add phone varchar(20);

update users set phone=01049496814 WHERE num=1 ;
update users set phone=01044356673 WHERE num=2 ;
update users set phone=01023454534 WHERE num=3 ;
update users set phone=01034543454 WHERE num=4 ;
update users set phone=01044142343 WHERE num=5 ;
update users set phone=01066375814 WHERE num=6 ;
update users set phone=null WHERE num=7 ;
update users set phone=01022225555 WHERE num=8 ;
update users set phone=01012345678 WHERE num=9 ;
update users set phone=01098765433 WHERE num=10 ;
update users set phone=0101104222 WHERE num=11 ;
update users set phone=01033334444 WHERE num=12 ;
update users set phone=01011332233 WHERE num=13 ;
update users set phone=01099998888 WHERE num=14 ;
update users set phone=01066778899 WHERE num=15 ;


create table posts(
    num number primary key,
    title varchar(500) not null,
    content varchar(2000) not null,
    post_like_cnt number default 0,
    user_num number not null,
    CONSTRAINT user_num foreign key(user_num) references users (num)
);

--DB 컬럼 추가 (유저 탈퇴, status)
ALTER TABLE Users ADD status number default 1;

--조회수 카운트
ALTER TABLE posts add  content_cnt number default 0;
--DB글 삭제
ALTER TABLE posts add  posts_views number default 0;
--관리자 추천권한 status : admin_like 기본값0, admin_like 값이 1이면 관리자 추천글
ALTER TABLE posts ADD admin_like number default 0;
--관리자 추천한 시간 :update_reg = admin_liker값이 1로 변경된시간, update_reg시간으로부터 7일이내의 값을 검색시 관리자 추천글  
ALTER TABLE posts ADD update_reg date null;



create table images(
    num number primary key,
    img_url varchar(1000) not null,
    posts_num number not null,
    CONSTRAINT posts_num foreign key(posts_num) references posts (num)
);


--시퀀스 생성
create SEQUENCE users_seq nocache;
create SEQUENCE posts_seq nocache;
create SEQUENCE images_seq nocache;



desc users;
desc posts;
desc images;

insert into users values (users_seq.nextval,'jhj6814','1234','혜지짱','2000-12-12',555,sysdate,'장혜지');
insert into users values (users_seq.nextval,'lj0115','1234','예린짱','2000-12-12',555,sysdate,'이예린');
insert into users values (users_seq.nextval,'rm1113','1234','영림짱','2000-12-12',555,sysdate,'이영림');
insert into users values (users_seq.nextval,'youmi','1234','유미짱','2000-12-12',555,sysdate,'김유미');
insert into users values (users_seq.nextval,'konan7979','1234','창완짱','2000-12-12',555,sysdate,'유창완');

select * from users;

insert into posts values (posts_seq.nextval,'환상고백','어떤숫자가 보이나요? 질문에 답하기만으로 색맹 여부가 드러납니다.', 115, 2);
insert into posts values (posts_seq.nextval,'등대','동해물과 백두산이 마르고 닳도록 하느님이', 914, 1);
insert into posts values (posts_seq.nextval,'등촌칼국수','등칼은 못참지', 333, 4);
insert into posts values (posts_seq.nextval,'홍대입구로 가려면 어떻게 해야해요?','뉴진스의 하입보이요', 113, 3);

select * from posts;

insert into images values (images_seq.nextval,'jy1.jpg',1,1);
insert into images values (images_seq.nextval,'hj1.gif',2,1);
insert into images values (images_seq.nextval,'jy2.jpg',3,1);
insert into images values (images_seq.nextval,'hs1.jpg',1,2);
insert into images values (images_seq.nextval,'iu1.jpg',2,2);
insert into images values (images_seq.nextval,'wb1.jpg',4,1);
insert into images values (images_seq.nextval,'theboyz.gif',1,3);
insert into images values (images_seq.nextval, 'cafe1.jpg', 5, 1);
insert into images values (images_seq.nextval, 'cafe2.png', 6, 1);
insert into images values (images_seq.nextval, 'cafe3.jpg', 7, 1);
insert into images values (images_seq.nextval, 'cafe4.jpg', 8, 1);
insert into images values (images_seq.nextval, 'cafe5.jpg', 9, 1);
insert into images values (images_seq.nextval, 'cafe6.jpg', 10, 1);
insert into images values (images_seq.nextval, 'cafe7.jpg', 11, 1);
insert into images values (images_seq.nextval, 'cafe8.jpg', 12, 1);
insert into images values (images_seq.nextval, 'cafe9.jpg', 13, 1);
insert into images values (images_seq.nextval, 'cafe10.jpg', 14, 1);
insert into images values (images_seq.nextval, 'cafe11.jpg', 15, 1);
insert into images values (images_seq.nextval, 'cafe12.jpg', 16, 1);
insert into images values (images_seq.nextval, 'cafe13.jpg', 17, 1);
insert into images values (images_seq.nextval, 'cafe14.jpg', 18, 1);
insert into images values (images_seq.nextval, 'cafe15.jpg', 19, 1);
insert into images values (images_seq.nextval, 'cafe16.jpg', 20, 1);
insert into images values (images_seq.nextval, 'cafe17.jpg', 2, 3);
insert into images values (images_seq.nextval, 'cafe18.jpg', 3, 2);
insert into images values (images_seq.nextval, 'cafe19.jpg', 4, 2);
insert into images values (images_seq.nextval, 'cafe20.jpg', 5, 2);
insert into images values (images_seq.nextval, 'cafe21.jpg', 6, 2);
insert into images values (images_seq.nextval, 'theboyz02.jpg', 21, 1);
insert into images values (images_seq.nextval, 'dog.jpg', 22, 1);


ALTER TABLE posts ADD reg date default sysdate;
ALTER TABLE images ADD post_image_num number;

update images set post_image_num=1,post_image_num=1 where num = 1;
update images set post_image_num=2,post_image_num=1 where num = 2;
update images set post_image_num=3,post_image_num=1 where num = 3;
update images set post_image_num=1,post_image_num=2 where num = 4;
update images set post_image_num=2,post_image_num=2 where num = 5;
update images set post_image_num=4,post_image_num=1 where num = 6;

--insert into images values (images_seq.nextval,'../resources/static/img/theboyz.gif',1,3);

ALTER TABLE images MODIFY post_image_num number not null;
select * from images;



--post db 추가
insert into posts values (posts_seq.nextval,'홍대 카페','홍대카페', 157, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'이대 카페','이대앞에 위치', 574, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'부천 카페','부천에 위치', 219, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'시흥 카페','시흥에 위치', 384, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'인천 카페','인천 남동구에 위치', 197, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'명동 카페','명동에 위치', 674, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'춘천 카페','춘천에 위치', 215, 5, sysdate , 0);
insert into posts values (posts_seq.nextval,'광안리 카페','부산 광안리에 위치', 481, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'부산 카페','부산 서구에 위치', 657, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'광주 카페','전라도 광주에 위치', 143, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'분당 카페','분당에 위치', 221, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'이대 카페','이대에 위치', 219, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'서울대 카페','서울대에에 위치', 369, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'압구정 카페','앞구정에 위치', 418, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'강남 카페','강남에 위치', 334, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'서초 카페','서초에 위치', 217, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'대학로 카페','대학로에 위치', 197, 5, sysdate , 0 , 0);
insert into posts values (posts_seq.nextval,'가나다라','영등포에 위치', 60, 2, sysdate , 0 , 0, 0, null);
insert into posts values (posts_seq.nextval,'강아지 라떼','중구에 위치', 5, 3, sysdate , 0 , 0, 0, null);
