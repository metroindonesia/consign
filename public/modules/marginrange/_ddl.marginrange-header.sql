-- marginrange.sql


/* =============================================
 * CREATE TABLE public."marginrange"
 * ============================================*/
create table public."marginrange" (
	marginrange_id smallint not null,
	constraint marginrange_pk primary key (marginrange_id)
);
comment on table public."marginrange" is '';	


-- =============================================
-- FIELD: marginrange_start decimal(4, 2)
-- =============================================
-- ADD marginrange_start
alter table public."marginrange" add marginrange_start decimal(4, 2) not null default 0;
comment on column public."marginrange".marginrange_start is '';

-- MODIFY marginrange_start
alter table public."marginrange"
	alter column marginrange_start type decimal(4, 2),
	ALTER COLUMN marginrange_start SET DEFAULT 0,
	ALTER COLUMN marginrange_start SET NOT NULL;
comment on column public."marginrange".marginrange_start is '';


-- =============================================
-- FIELD: marginrange_end decimal(4, 2)
-- =============================================
-- ADD marginrange_end
alter table public."marginrange" add marginrange_end decimal(4, 2) not null default 0;
comment on column public."marginrange".marginrange_end is '';

-- MODIFY marginrange_end
alter table public."marginrange"
	alter column marginrange_end type decimal(4, 2),
	ALTER COLUMN marginrange_end SET DEFAULT 0,
	ALTER COLUMN marginrange_end SET NOT NULL;
comment on column public."marginrange".marginrange_end is '';


-- =============================================
-- FIELD: marginrange_desc text
-- =============================================
-- ADD marginrange_desc
alter table public."marginrange" add marginrange_desc text  ;
comment on column public."marginrange".marginrange_desc is '';

-- MODIFY marginrange_desc
alter table public."marginrange"
	alter column marginrange_desc type text,
	ALTER COLUMN marginrange_desc DROP DEFAULT,
	ALTER COLUMN marginrange_desc DROP NOT NULL;
comment on column public."marginrange".marginrange_desc is '';


-- =============================================
-- FIELD: _createby integer
-- =============================================
-- ADD _createby
alter table public."marginrange" add _createby integer not null ;
comment on column public."marginrange"._createby is 'user yang pertama kali membuat record ini';

-- MODIFY _createby
alter table public."marginrange"
	alter column _createby type integer,
	ALTER COLUMN _createby DROP DEFAULT,
	ALTER COLUMN _createby SET NOT NULL;
comment on column public."marginrange"._createby is 'user yang pertama kali membuat record ini';


-- =============================================
-- FIELD: _createdate timestamp with time zone
-- =============================================
-- ADD _createdate
alter table public."marginrange" add _createdate timestamp with time zone not null default now();
comment on column public."marginrange"._createdate is 'waktu record dibuat pertama kali';

-- MODIFY _createdate
alter table public."marginrange"
	alter column _createdate type timestamp with time zone,
	ALTER COLUMN _createdate SET DEFAULT now(),
	ALTER COLUMN _createdate SET NOT NULL;
comment on column public."marginrange"._createdate is 'waktu record dibuat pertama kali';


-- =============================================
-- FIELD: _modifyby integer
-- =============================================
-- ADD _modifyby
alter table public."marginrange" add _modifyby integer  ;
comment on column public."marginrange"._modifyby is 'user yang terakhir modifikasi record ini';

-- MODIFY _modifyby
alter table public."marginrange"
	alter column _modifyby type integer,
	ALTER COLUMN _modifyby DROP DEFAULT,
	ALTER COLUMN _modifyby DROP NOT NULL;
comment on column public."marginrange"._modifyby is 'user yang terakhir modifikasi record ini';


-- =============================================
-- FIELD: _modifydate timestamp with time zone
-- =============================================
-- ADD _modifydate
alter table public."marginrange" add _modifydate timestamp with time zone  ;
comment on column public."marginrange"._modifydate is 'waktu terakhir record dimodifikasi';

-- MODIFY _modifydate
alter table public."marginrange"
	alter column _modifydate type timestamp with time zone,
	ALTER COLUMN _modifydate DROP DEFAULT,
	ALTER COLUMN _modifydate DROP NOT NULL;
comment on column public."marginrange"._modifydate is 'waktu terakhir record dimodifikasi';






-- =============================================
-- UNIQUE INDEX
-- =============================================
-- Drop existing unique index 
alter table public."marginrange"
	drop constraint uq$public$marginrange$marginrange_id;
	

-- Add unique index 
alter table  public."marginrange"
	add constraint uq$public$marginrange$marginrange_id unique (marginrange_id); 

