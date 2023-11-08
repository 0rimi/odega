--테이블 및 시퀀스 생성
create table likes(
   num number primary key,
   user_num number not null,
   post_num number not null,
   like_date date default sysdate,
   CONSTRAINT likes_user foreign key(user_num) references users (num),
   CONSTRAINT likes_post foreign key(post_num) references posts (num)
);
create SEQUENCE likes_seq nocache;