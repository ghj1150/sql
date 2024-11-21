create table tbl_member (
	id varchar(200) primary key,
	pw varchar(200) not null,
	name varchar(200) not null,
	email varchar(200),
	road_addr varchar(1000),
	detail_addr varchar(1000),
	regdate datetime default now()
);

SELECT * FROM tbl_member tm ;
insert into tbl_member (id, pw, name) values ('abcd', '1234', '새똥이');

-- tbl_like

-- tbl_post
-- pno, title, writer, content, view_count, regdate, updatedate

create table tbl_post (
	pno bigint primary key auto_increment
	, title varchar(1000) not null
	, writer varchar(200) references tbl_member(id)
	, content text not null
	, view_count bigint default 0
	, regdate datetime default now()
	, updatedate datetime default now()
);	

create table tbl_post_category (
	cno int primary key,
	cname varchar(300) not null,
	regdate datetime default now()
);

select tp.*, (select count(*) from tbl_attach ta where ta.pno = tp.pno) attach_flag from tbl_post tp order by 1 desc;

select pno, COUNT(*) cnt 
from (
	select tp.*
	from tbl_post tp
	left join tbl_attach ta 
	using(pno)
	
) a
group by pno
order by 1 desc;

select tp.*
from tbl_post tp 
left join (select pno, count(*) cnt from tbl_attach ta group by pno) ta
using(pno)
order by 1 desc;

insert into tbl_post_category (cno, cname) values (1, '공지사항');
insert into tbl_post_category (cno, cname) values (2, '자유게시판');
insert into tbl_post_category (cno, cname) values (3, '자료실');

select pno, title, writer, view_count, regdate, cno
from tbl_post
where cno = 2
and (
	title like concat('%', '3', '%')or
	content like '%3%'
)
order by 1 desc
limit 10 offset 0;

-- 1 : 0
-- 2 : 10
-- 3 : 20

insert into tbl_post (title, writer, content)
select title, writer, content 
from tbl_post;

select count(*) as cnt 
from tbl_post
where cno = 2;

create table tbl_attach (
	uuid varchar(500) primary key,
	origin varchar(3000) not null,
	path varchar(10) not null,
	image tinyint(1) default 0,
	pno bigint references tbl_post
);

select * from tbl_attach ta ;

select * from tbl_post order by 1 desc;
select * from tbl_reply order by 1 desc;

drop table tbl_reply;

CREATE table tbl_reply (
-- pk rno
rno bigint primary key auto_increment,
-- content
content varchar(3000) not null,
-- regdate
regdate datetime default now(),
-- updatedate
updatedate datetime default now(),
-- hidden
hidden tinyint(1) default 0,
-- like
likes int default 0,
-- writer
writer varchar(200) references tbl_member(id),
-- pno
pno bigint references tbl_post
);

insert into tbl_reply(pno, content, writer) values ((select max (pno) from tbl_post), '댓글', 'aaaa');

select *
from tbl_reply tr
where pno = 284
and rno > 27
order by rno 
limit 5;

select *
from tbl_reply
where writer = 'aaaa'
and pno = 284
order by rno desc
limit 3;

select tp.*, (select count(*) from tbl_attach ta where ta.pno = tp.pno) attach_flag
from tbl_post tp 
where cno = 2 
and (
	title like concat('%', '제목', '%') 
-- 	or
-- 	content like '%제목%'
-- 	or
-- 	writer like '%제목%'
)
order by 1 desc 
limit 10 offset 0;
