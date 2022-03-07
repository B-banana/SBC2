-- ���������� : 22.03.07
-- ������ : �̰�ö
-- ���� : ���� �ε���, ������ ����

--�����ͺ��̽� �� : SBC
--����Ŭ ���� id : sbc
--����Ŭ ��й�ȣ : 1234

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

/* �Խ��� */
CREATE TABLE board (
	board_num NUMBER(30) NOT NULL, /* �Խñ۹�ȣ */
	user_id VARCHAR2(30) NOT NULL, /* user_id */
	reg_time DATE NOT NULL, /* �ۼ��ð� */
	modi_time DATE NOT NULL, /* �����ð� */
	likecount NUMBER, /* ���ƿ�� */
	readcount NUMBER, /* ��ȸ�� */
	dog_num VARCHAR2(30) NOT NULL, /* ����߰�����ȣ */
	board_category VARCHAR2(30) NOT NULL, /* ī�װ� */
	board_content VARCHAR2(1000) NOT NULL /* �󼼱� */
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

/* ��������� */
CREATE TABLE dog (
	dog_num VARCHAR2(30) NOT NULL, /* ����߰�����ȣ */
	breed VARCHAR2(30) NOT NULL, /* ǰ�� */
	color VARCHAR2(30) NOT NULL, /* ���� */
	sex VARCHAR2(30) NOT NULL, /* ���� */
	age NUMBER NOT NULL, /* ���� */
	weight NUMBER NOT NULL, /* ������ */
	find_date DATE NOT NULL, /* ��¥ */
	map_code VARCHAR2(100), /* �ּ��ڵ� */
	charcteristic VARCHAR2(1000), /* Ư¡ */
	chip_num VARCHAR2(100) /* Ĩ�¹�ȣ */
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

/* ����api */
CREATE TABLE map_api (
	map_code VARCHAR2(100) NOT NULL, /* �ּ��ڵ� */
	detailaddress VARCHAR2(100) NOT NULL, /* ���ּ� */
	x_axis NUMBER NOT NULL, /* x��ǥ */
	y_axis NUMBER NOT NULL /* y��ǥ */
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

/* ���ƿ� */
CREATE TABLE likes (
	user_id VARCHAR(30) NOT NULL, /* user_id */
	board_num NUMBER(30) NOT NULL /* �Խñ۹�ȣ */
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

/* Ĩ�� */
CREATE TABLE chip (
	chip_num VARCHAR2(100) NOT NULL, /* Ĩ�¹�ȣ */
	ownername VARCHAR2(100) NOT NULL, /* �����̸� */
	phone NUMBER NOT NULL /* �ڵ�����ȣ */
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
insert into membership VALUES('admin', '010-1223-3333', 'ho@hot.com', '123220', '�����', '������ �ֹ���', '����', '861221', 'ok', '���̸�');
insert into membership VALUES('guest1', '010-1663-3333', 'ho@hotmail.com', '123220', '�����', '���ʱ� ��赿', '����', '971221', 'no', '���̸�');
insert into membership VALUES('guest2', '010-1223-8833', 'ho@nate.com', '123220', '�����', '���� ���⵿', '������', '001221', 'ok',  '���̸�');

insert into chip values('001', 'ȫ�浿', '01012345678');
insert into chip values('002', '��浿', '01012345678');
insert into chip values('003', '�Ӳ���', '01012345678');

insert into map_api VALUES('001', '������ ��ô', '33.2222', '54.234324');
insert into map_api VALUES('002', '�λ� ����', '334.23222', '23.234324');
insert into map_api VALUES('003', '��⵵ ���� �ϻ�', '12.24422', '598.234324');
-- ------------------------------------------------
insert into dog values('001', '�׷����Ͽ��', '����', '����', '7', '20', '2022-08-17 09:00:00', '001', '����������', '001');
insert into dog values('002', '��Ƽ��', '������', '����', '2', '4', '2022-06-17 09:00:00', '002', '�Ϳ�����', '002');
insert into dog values('003', '�۱�', '����', '����', '12', '13', '2021-08-17 09:00:00', '003', '�󱼿� ���� ���ƿ�', '003');

insert into board VALUES(board_num.nextval, 'admin', '2022-08-17 09:00:00', '2022-08-18 09:00:00', '10', '10', '001', '����', '�� ã���ּ���');
insert into board values(board_num.nextval, 'guest1', '2022-02-20 09:00:00','2022-02-20 09:00:00', '0', '1', '002', '�߰�', 'ã���ּ���');
insert into board values(board_num.nextval, 'guest2', '2022-02-20 09:00:00','2022-02-20 09:00:00', '0', '1', '003', '���', '���� ���Ŀ�');

insert into likes VALUES('admin', '002');
insert into likes VALUES('guest1', '001');
insert into likes VALUES('guest1', '002');
insert into likes VALUES('guest2', '003');

--select * from board;

--select board.board_num, likecount from board, membership, likes
--where board.board_num = likes.board_num 
--and membership.user_id = 'guest1';

--select * from product;

insert into product values('fd-001', '������ ���', 5000, 100, 'food');
insert into product values('cl-005', '���� 5', 38000, 50, 'clothes');
insert into product values('ac-003', '�������', 25000, 100, 'acc');

insert into orderlist values('00001', 'guest1', '01012345678', '123@naver.com', '2022-02-20 09:00:00', '054654', '�����', '������ �ֹ���', 100000, 3000, 13000);
insert into orderlist values('00002', 'guest2', '01098765412', 'asdf@naver.com', '2021-12-20 09:00:00', '123220', '�����', '���� ���⵿', 38000, 3000, 41000);
insert into orderlist values('00003', 'guest2', '01098765412', 'asdf@naver.com', '2022-02-20 09:00:00', '123220', '�����', '���� ���⵿', 50000, 2000, 52000);

insert into order_detail values('00001', 'fd-001', 20);
insert into order_detail values('00002', 'cl-005', 1);
insert into order_detail values('00003', 'ac-003', 2);

insert into payment values('k-01', '00001', '2022-02-20 09:00:00', 13000);
insert into payment values('k-02', '00002', '2021-12-20 09:00:00', 41000);
insert into payment values('k-03', '00003', '2022-02-20 09:00:00', 52000);

--select sum(quantity)
--from order_detail
--where product_id = 'fd-001';