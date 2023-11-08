create table maps(
    id number primary key,
    place_name varchar2(500) not null,
    address_name varchar2(1000) not null,
    description varchar2(2000) not null,
    post_num number not null,
    image_num number not null,
    CONSTRAINT post_num foreign key(post_num) references posts (num),
    CONSTRAINT image_num foreign key(image_num) references images (num)
);
select * from maps;

--INSERT DB
insert into maps values (14969335,'에그옐로우빌딩','서울 관악구 남부순환로 1820','에그 옐로우 제가 정말 좋아합니다. 너무 좋아해서 평일에는 거의 매일같이 이곳에 오는데요, 엘레베이터가 단 세대밖에 없는게 정말 유일한 단점이라면 단점입니다. 한번 놓치면 운이 안좋을시 약 8분까지도 기다려야 하므로 이거 정말 답답해 미칠 노릇입니다.',1,1 );
insert into maps values (14825756,'하이브','서울 용산구 한강대로 42','입이 거친 게 싫다던 너 때문에 화가 나도 욕을 못 하고 너 기대라고 넓혀놓은 내 어깨는 이젠 지하철 속 장애물일 뿐이야  You`re so bad, you know 뻔뻔하게 거짓말로 돌려막고 낯선 향기만 묻혀오니 사랑 따위 하지 말지  그래 오히려 좋지 시원하게 욕이나 뱉지 I swear you never regret it 나만 바보였지  다 뭣 같아 다정했던 사진 속 네 모습이 다 똑같아 이번엔 다를 거라 했었던 말도  Sometime 꺼져버려 제발 But sometimes 네가 보고 싶다',1,2);
insert into maps values (365593020,'IST엔터테인먼트','서울 강남구 언주로172길 8','Ye, shocking roar Don`t call me like that 악이란 걸 누가 정해 욕망을 멈추지도 못한 영원히 용서받지 못한 존재란 금지된 것을 꿈꾸네 ooh-ooh, oh 묶인 내 손발은 자유를 갈구했네 Like animals, oh I`ma get ya (get ya, get ya) 절망 없는 사랑을 꿈꿔 거침이 없던 본능 신의 분노를 샀어 잠재울 수 없는 것 원해 온 것 it`s so raw 누가 감히 아니라고 해, 모두 다 내 것 되리라 타락한 천사라 불리운 이름과 낙원을 등진 채 이제야 내가 자유로워졌어 Ta ta ta ra ra ta 내 것 되리라 Keep it coming like that roar Ta ta ta ra ra ta 내게 오리라 Yeah',1,7);


ALTER TABLE maps add lat varchar(100) not null;
ALTER TABLE maps add longi varchar(100) not null;

update maps set lat='37.4809995507307' , longi='126.952120937856' where id=14969335;
update maps set lat='37.52441065848861' , longi='126.96413891328879' where id=14825756;
update maps set lat='37.52763936784024' , longi='127.03445414724943' where id=365593020;

ALTER TABLE maps MODIFY lat not null;
ALTER TABLE maps MODIFY longi not null;

update maps set image_num=7 where id=365593020;







--테이블을 처음부터 만든경우 : DB
DB maps

--1번
insert into maps values (
14969335,
'에그옐로우빌딩',
'서울 관악구 남부순환로 1820',
'에그 옐로우 제가 정말 좋아합니다. 너무 좋아해서 평일에는 거의 매일같이 이곳에 오는데요, 엘레베이터가 단 세대밖에 없는게 정말 유일한 단점이라면 단점입니다. 한번 놓치면 운이 안좋을시 약 8분까지도 기다려야 하므로 이거 정말 답답해 미칠 노릇입니다.',
1,
1,
'37.4809995507307',
'126.952120937856');

--2번
insert into maps values (
14825756,
'하이브','서울 용산구 한강대로 42',
'입이 거친 게 싫다던 너 때문에 화가 나도 욕을 못 하고 너 기대라고 넓혀놓은 내 어깨는 이젠 지하철 속 장애물일 뿐이야  You`re so bad, you know 뻔뻔하게 거짓말로 돌려막고 낯선 향기만 묻혀오니 사랑 따위 하지 말지  그래 오히려 좋지 시원하게 욕이나 뱉지 I swear you never regret it 나만 바보였지  다 뭣 같아 다정했던 사진 속 네 모습이 다 똑같아 이번엔 다를 거라 했었던 말도  Sometime 꺼져버려 제발 But sometimes 네가 보고 싶다',
1,
2,
'37.52441065848861',
'126.96413891328879');

--3번
insert into maps values (
365593021,
'IST엔터테인먼트',
'서울 강남구 언주로172길 8',
'Ye, shocking roar Don`t call me like that 악이란 걸 누가 정해 욕망을 멈추지도 못한 영원히 용서받지 못한 존재란 금지된 것을 꿈꾸네 ooh-ooh, oh 묶인 내 손발은 자유를 갈구했네 Like animals, oh I`ma get ya (get ya, get ya) 절망 없는 사랑을 꿈꿔 거침이 없던 본능 신의 분노를 샀어 잠재울 수 없는 것 원해 온 것 it`s so raw 누가 감히 아니라고 해, 모두 다 내 것 되리라 타락한 천사라 불리운 이름과 낙원을 등진 채 이제야 내가 자유로워졌어 Ta ta ta ra ra ta 내 것 되리라 Keep it coming like that roar Ta ta ta ra rata내게오리라Yeah',
1,
7,
'37.52763936784024',
'127.03445414724943');


--4번
insert into maps values (
1786432255,
'카카오프렌즈 홍대플래그십스토어',
'서울 마포구 동교동 165-5',
'가나다라마바사아자차카타파하',
2,
2,
'37.5563194254356',
'126.923919460392');

--5번
insert into maps values (
25079897,
'홍대반지카페 본점',
'서울 마포구 서교동 366-13',
'가나다라마바사아자차카타파하',
3,
3,
'37.55212626567029',
'126.92129708652944');

--6번
insert into maps values (
1620894311,
'블루보틀 홍대 카페',
'서울 마포구 서교동 354-5',
'가나다라마바사아자차카타파하',
4,
6,
'37.5543345515221',
'126.921207622104');

--7번
insert into maps values (
685193825,
'디비스토리 홍대카페',
'서울 마포구 서교동 347-15',
'가나다라마바사아자차카타파하',
5,
8,
'37.55537244407626',
'126.92527850177942');

--8번
insert into maps values (
8143287,
'학림다방',
'서울 종로구 명륜4가 94-2',
'가나다라마바사아자차카타파하',
6,
9,
'37.581950218926636',
'127.00165744513413');

--9번
insert into maps values (
13603557,
'타셴',
'서울 종로구 동숭동 1-44',
'가나다라마바사아자차카타파하',
7,
10,
'37.58294486899249',
'127.00371345107004');

--10번
insert into maps values (
1837149680,
'헤이커피',
'서울 종로구 명륜4가 112-6',
'가나다라마바사아자차카타파하',
8,
11,
'37.5820250113276',
'127.000633996041');