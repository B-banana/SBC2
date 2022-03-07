-- 최종수정일 : 22.03.07
-- 수정인 : 이경철
-- 내용 : 유저 인덱스, 시퀸스 생성

--데이터베이스 명 : SBC
--오라클 접속 id : sbc
--오라클 비밀번호 : 1234

--drop table board cascade constraints;
--drop table chip cascade constraints;
--drop table dog cascade constraints;
--drop table likes cascade constraints;
--drop table membership cascade constraints;
--drop table order_detail cascade constraints;
--drop table orderlist cascade constraints;
--drop table payment cascade constraints;
--drop table product cascade constraints;
--drop table user_log cascade constraints;
--drop table userlist cascade constraints;
--drop table map_api cascade constraints;
--drop sequence board_num;
--commit;

create sequence board_num
increment by 1
start with 1
maxvalue 9999
minvalue 1
cycle 
cache 2;

create sequence user_idx
increment by 1
start with 1
maxvalue 9999
minvalue 1;


/* membership */
CREATE TABLE membership (
	user_id VARCHAR2(30) NOT NULL, /* user_id */
	phone VARCHAR2(30) NOT NULL, /* phone */
	email VARCHAR2(30) NOT NULL, /* email */
	postcode NUMBER, /* postcode */
	address1 VARCHAR2(100), /* address1 */
	address2 VARCHAR2(100), /* address2 */
	gender VARCHAR2(30) NOT NULL, /* gender */
	birthdate VARCHAR2(30) NOT NULL, /* birthdate */
	personal_info_agmt VARCHAR2(30) NOT NULL, /* personal_info_agmt */
	user_name VARCHAR2(30) /* name */
);

CREATE UNIQUE INDEX PK_membership
	ON membership (
		user_id ASC
	);

ALTER TABLE membership
	ADD
		CONSTRAINT PK_membership
		PRIMARY KEY (
			user_id
		);

/* order */
CREATE TABLE orderlist (
	merchant_uid VARCHAR2(100) NOT NULL, /* merchant_uid */
	user_id VARCHAR2(30) NOT NULL, /* user_id */
	phone VARCHAR2(30) NOT NULL, /* phone */
	email VARCHAR2(30) NOT NULL, /* email */
	order_date DATE NOT NULL, /* date */
	postcode NUMBER NOT NULL, /* postcode */
	address1 VARCHAR2(100) NOT NULL, /* address1 */
	address2 VARCHAR2(100) NOT NULL, /* address2 */
	total_price NUMBER NOT NULL, /* total_price */
	shipping NUMBER NOT NULL, /* shipping */
	total_amount NUMBER NOT NULL /* total_amount */
);

CREATE UNIQUE INDEX PK_orderlist
	ON orderlist (
		merchant_uid ASC
	);

ALTER TABLE orderlist
	ADD
		CONSTRAINT PK_orderlist
		PRIMARY KEY (
			merchant_uid
		);

/* order_detail */
CREATE TABLE order_detail (
	merchant_uid VARCHAR2(100) NOT NULL, /* merchant_uid */
	product_id VARCHAR2(30) NOT NULL, /* product_id */
	quantity NUMBER NOT NULL /* quantity */
);

CREATE UNIQUE INDEX PK_order_detail
	ON order_detail (
		merchant_uid ASC,
		product_id ASC
	);

ALTER TABLE order_detail
	ADD
		CONSTRAINT PK_order_detail
		PRIMARY KEY (
			merchant_uid,
			product_id
		);

/* payment */
CREATE TABLE payment (
	imp_id VARCHAR2(100) NOT NULL, /* imp_id */
	merchant_uid VARCHAR2(100) NOT NULL, /* merchant_uid */
	pay_date DATE NOT NULL, /* date */
	amount NUMBER NOT NULL /* amount */
);

CREATE UNIQUE INDEX PK_payment
	ON payment (
		imp_id ASC
	);

ALTER TABLE payment
	ADD
		CONSTRAINT PK_payment
		PRIMARY KEY (
			imp_id
		);

/* product */
CREATE TABLE product (
	product_id VARCHAR2(30) NOT NULL, /* product_id */
	product_name VARCHAR2(30) NOT NULL, /* product_name */
	price NUMBER NOT NULL, /* price */
	stock NUMBER NOT NULL, /* stock */
	product_category VARCHAR2(30) NOT NULL /* category */
);

CREATE UNIQUE INDEX PK_product
	ON product (
		product_id ASC
	);

ALTER TABLE product
	ADD
		CONSTRAINT PK_product
		PRIMARY KEY (
			product_id
		);

/* 게시판 */
CREATE TABLE board (
	board_num NUMBER(30) NOT NULL, /* 게시글번호 */
	user_id VARCHAR2(30) NOT NULL, /* user_id */
	reg_time DATE NOT NULL, /* 작성시간 */
	modi_time DATE NOT NULL, /* 수정시간 */
	likecount NUMBER, /* 좋아요수 */
	readcount NUMBER, /* 조회수 */
	dog_num VARCHAR2(30) NOT NULL, /* 유기견고유번호 */
	board_category VARCHAR2(30) NOT NULL, /* 카테고리 */
	board_content VARCHAR2(1000) NOT NULL /* 상세글 */
);

CREATE UNIQUE INDEX PK_board
	ON board (
		board_num ASC
	);

ALTER TABLE board
	ADD
		CONSTRAINT PK_board
		PRIMARY KEY (
			board_num
		);

/* 유기견정보 */
CREATE TABLE dog (
	dog_num VARCHAR2(30) NOT NULL, /* 유기견고유번호 */
	breed VARCHAR2(30) NOT NULL, /* 품종 */
	color VARCHAR2(30) NOT NULL, /* 색상 */
	sex VARCHAR2(30) NOT NULL, /* 성별 */
	age NUMBER NOT NULL, /* 나이 */
	weight NUMBER NOT NULL, /* 몸무게 */
	find_date DATE NOT NULL, /* 날짜 */
	map_code VARCHAR2(100), /* 주소코드 */
	charcteristic VARCHAR2(1000), /* 특징 */
	chip_num VARCHAR2(100) /* 칩셋번호 */
);

CREATE UNIQUE INDEX PK_dog
	ON dog (
		dog_num ASC
	);

ALTER TABLE dog
	ADD
		CONSTRAINT PK_dog
		PRIMARY KEY (
			dog_num
		);

/* 지도api */
CREATE TABLE map_api (
	map_code VARCHAR2(100) NOT NULL, /* 주소코드 */
	detailaddress VARCHAR2(100) NOT NULL, /* 상세주소 */
	x_axis NUMBER NOT NULL, /* x좌표 */
	y_axis NUMBER NOT NULL /* y좌표 */
);

CREATE UNIQUE INDEX PK_map_api
	ON map_api (
		map_code ASC
	);

ALTER TABLE map_api
	ADD
		CONSTRAINT PK_map_api
		PRIMARY KEY (
			map_code
		);

/* 좋아요 */
CREATE TABLE likes (
	user_id VARCHAR(30) NOT NULL, /* user_id */
	board_num NUMBER(30) NOT NULL /* 게시글번호 */
);

CREATE UNIQUE INDEX PK_likes
	ON likes (
		user_id ASC,
		board_num ASC
	);

ALTER TABLE likes
	ADD
		CONSTRAINT PK_likes
		PRIMARY KEY (
			user_id,
			board_num
		);


/* user */
CREATE TABLE userlist (
    user_idx number not null,
	user_id VARCHAR2(30) NOT NULL, /* user_id */
	user_password VARCHAR2(1000), /* password */
	authority VARCHAR2(30), /* authority */
	enabled NUMBER /* enabled */
);

CREATE UNIQUE INDEX PK_userlist
	ON userlist (
		user_id ASC
	);

ALTER TABLE userlist
	ADD
		CONSTRAINT PK_userlist
		PRIMARY KEY (
			user_id
		);

/* user_log */
CREATE TABLE user_log (
	user_id VARCHAR2(30) NOT NULL, /* user_id */
	last_login_time DATE, /* last_login_time */
	register_time DATE, /* register_time */
	update_time DATE /* update_time */
);

CREATE UNIQUE INDEX PK_user_log
	ON user_log (
		user_id ASC
	);

ALTER TABLE user_log
	ADD
		CONSTRAINT PK_user_log
		PRIMARY KEY (
			user_id
		);

/* 칩셋 */
CREATE TABLE chip (
	chip_num VARCHAR2(100) NOT NULL, /* 칩셋번호 */
	ownername VARCHAR2(100) NOT NULL, /* 주인이름 */
	phone NUMBER NOT NULL /* 핸드폰번호 */
);

CREATE UNIQUE INDEX PK_chip
	ON chip (
		chip_num ASC
	);

ALTER TABLE chip
	ADD
		CONSTRAINT PK_chip
		PRIMARY KEY (
			chip_num
		);

ALTER TABLE membership
	ADD
		CONSTRAINT FK_userlist_TO_membership
		FOREIGN KEY (
			user_id
		)
		REFERENCES userlist (
			user_id
		);

ALTER TABLE orderlist
	ADD
		CONSTRAINT FK_membership_TO_orderlist
		FOREIGN KEY (
			user_id
		)
		REFERENCES membership (
			user_id
		);

ALTER TABLE order_detail
	ADD
		CONSTRAINT FK_orderlist_TO_order_detail
		FOREIGN KEY (
			merchant_uid
		)
		REFERENCES orderlist (
			merchant_uid
		);

ALTER TABLE order_detail
	ADD
		CONSTRAINT FK_product_TO_order_detail
		FOREIGN KEY (
			product_id
		)
		REFERENCES product (
			product_id
		);

ALTER TABLE payment
	ADD
		CONSTRAINT FK_orderlist_TO_payment
		FOREIGN KEY (
			merchant_uid
		)
		REFERENCES orderlist (
			merchant_uid
		);

ALTER TABLE board
	ADD
		CONSTRAINT FK_membership_TO_board
		FOREIGN KEY (
			user_id
		)
		REFERENCES membership (
			user_id
		);

ALTER TABLE board
	ADD
		CONSTRAINT FK_dog_TO_board
		FOREIGN KEY (
			dog_num
		)
		REFERENCES dog (
			dog_num
		);

ALTER TABLE dog
	ADD
		CONSTRAINT FK_map_api_TO_dog
		FOREIGN KEY (
			map_code
		)
		REFERENCES map_api (
			map_code
		);

ALTER TABLE dog
	ADD
		CONSTRAINT FK_chip_TO_dog
		FOREIGN KEY (
			chip_num
		)
		REFERENCES chip (
			chip_num
		);

ALTER TABLE likes
	ADD
		CONSTRAINT FK_membership_TO_likes
		FOREIGN KEY (
			user_id
		)
		REFERENCES membership (
			user_id
		);

ALTER TABLE likes
	ADD
		CONSTRAINT FK_board_TO_likes
		FOREIGN KEY (
			board_num
		)
		REFERENCES board (
			board_num
		);

ALTER TABLE user_log
	ADD
		CONSTRAINT FK_userlist_TO_user_log
		FOREIGN KEY (
			user_id
		)
		REFERENCES userlist (
			user_id
		);
        
--select * from map_api;

insert into userlist values(user_idx.nextval, 'admin', '1234', 'ROLE_ADMIN', 1);
insert into userlist values(user_idx.nextval, 'guest1', '1234', 'ROLE_USER', 1);
insert into userlist values(user_idx.nextval, 'guest2', '1234', 'ROLE_USER', 1);

--SELECT *
--FROM NLS_SESSION_PARAMETERS;

ALTER session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
insert into user_log values('admin', '2022-02-24 18:30:30', '2020-01-01 09:00:00', '2022-02-22 15:30:38');
insert into user_log values('guest1', '2022-01-01 18:30:30', '2022-01-01 09:00:00', '2022-02-22 15:30:38');
insert into user_log values('guest2', '2021-02-22 18:30:30', '2022-01-01 09:00:00', '2021-11-22 15:30:38');
-- ------------------------------------------------------
insert into membership VALUES('admin', '010-1223-3333', 'ho@hot.com', '123220', '서울시', '도봉구 쌍문동', '여자', '861221', 'ok', '김이름');
insert into membership VALUES('guest1', '010-1663-3333', 'ho@hotmail.com', '123220', '서울시', '서초구 방배동', '남자', '971221', 'no', '이이름');
insert into membership VALUES('guest2', '010-1223-8833', 'ho@nate.com', '123220', '서울시', '은평구 구기동', '남여자', '001221', 'ok',  '박이름');

insert into chip values('001', '홍길동', '01012345678');
insert into chip values('002', '고길동', '01012345678');
insert into chip values('003', '임꺽정', '01012345678');

insert into map_api VALUES('001', '강원도 삼척', '33.2222', '54.234324');
insert into map_api VALUES('002', '부산 동구', '334.23222', '23.234324');
insert into map_api VALUES('003', '경기도 고양시 일산', '12.24422', '598.234324');
-- ------------------------------------------------
insert into dog values('001', '그레이하운드', '검정', '수컷', '7', '20', '2022-08-17 09:00:00', '001', '사람을물어요', '001');
insert into dog values('002', '말티즈', '누런색', '수컷', '2', '4', '2022-06-17 09:00:00', '002', '귀여워요', '002');
insert into dog values('003', '퍼그', '검정', '암컷', '12', '13', '2021-08-17 09:00:00', '003', '얼굴에 점이 많아요', '003');

insert into board VALUES(board_num.nextval, 'admin', '2022-08-17 09:00:00', '2022-08-18 09:00:00', '10', '10', '001', '실종', '꼭 찾아주세요');
insert into board values(board_num.nextval, 'guest1', '2022-02-20 09:00:00','2022-02-20 09:00:00', '0', '1', '002', '발견', '찾아주세요');
insert into board values(board_num.nextval, 'guest2', '2022-02-20 09:00:00','2022-02-20 09:00:00', '0', '1', '003', '긴급', '맘이 아파요');

insert into likes VALUES('admin', '002');
insert into likes VALUES('guest1', '001');
insert into likes VALUES('guest1', '002');
insert into likes VALUES('guest2', '003');

--select * from board;

--select board.board_num, likecount from board, membership, likes
--where board.board_num = likes.board_num 
--and membership.user_id = 'guest1';

--select * from product;

insert into product values('fd-001', '맛좋아 사료', 5000, 100, 'food');
insert into product values('cl-005', '개옷 5', 38000, 50, 'clothes');
insert into product values('ac-003', '개목걸이', 25000, 100, 'acc');

insert into orderlist values('00001', 'guest1', '01012345678', '123@naver.com', '2022-02-20 09:00:00', '054654', '서울시', '도봉구 쌍문동', 100000, 3000, 13000);
insert into orderlist values('00002', 'guest2', '01098765412', 'asdf@naver.com', '2021-12-20 09:00:00', '123220', '서울시', '은평구 구기동', 38000, 3000, 41000);
insert into orderlist values('00003', 'guest2', '01098765412', 'asdf@naver.com', '2022-02-20 09:00:00', '123220', '서울시', '은평구 구기동', 50000, 2000, 52000);

insert into order_detail values('00001', 'fd-001', 20);
insert into order_detail values('00002', 'cl-005', 1);
insert into order_detail values('00003', 'ac-003', 2);

insert into payment values('k-01', '00001', '2022-02-20 09:00:00', 13000);
insert into payment values('k-02', '00002', '2021-12-20 09:00:00', 41000);
insert into payment values('k-03', '00003', '2022-02-20 09:00:00', 52000);

--select sum(quantity)
--from order_detail
--where product_id = 'fd-001';