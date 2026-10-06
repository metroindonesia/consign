-- sitetype.sql


/* =============================================
 * CREATE TABLE public."sitetype"
 * ============================================*/
create table public."sitetype" (
	sitetype_id smallint not null,
	constraint sitetype_pk primary key (sitetype_id)
);
comment on table public."sitetype" is '';	


-- =============================================
-- FIELD: sitetype_name text
-- =============================================
-- ADD sitetype_name
alter table public."sitetype" add sitetype_name text  ;
comment on column public."sitetype".sitetype_name is '';

-- MODIFY sitetype_name
alter table public."sitetype"
	alter column sitetype_name type text,
	ALTER COLUMN sitetype_name DROP DEFAULT,
	ALTER COLUMN sitetype_name DROP NOT NULL;
comment on column public."sitetype".sitetype_name is '';


-- =============================================
-- FIELD: _createby integer
-- =============================================
-- ADD _createby
alter table public."sitetype" add _createby integer not null ;
comment on column public."sitetype"._createby is 'user yang pertama kali membuat record ini';

-- MODIFY _createby
alter table public."sitetype"
	alter column _createby type integer,
	ALTER COLUMN _createby DROP DEFAULT,
	ALTER COLUMN _createby SET NOT NULL;
comment on column public."sitetype"._createby is 'user yang pertama kali membuat record ini';


-- =============================================
-- FIELD: _createdate timestamp with time zone
-- =============================================
-- ADD _createdate
alter table public."sitetype" add _createdate timestamp with time zone not null default now();
comment on column public."sitetype"._createdate is 'waktu record dibuat pertama kali';

-- MODIFY _createdate
alter table public."sitetype"
	alter column _createdate type timestamp with time zone,
	ALTER COLUMN _createdate SET DEFAULT now(),
	ALTER COLUMN _createdate SET NOT NULL;
comment on column public."sitetype"._createdate is 'waktu record dibuat pertama kali';


-- =============================================
-- FIELD: _modifyby integer
-- =============================================
-- ADD _modifyby
alter table public."sitetype" add _modifyby integer  ;
comment on column public."sitetype"._modifyby is 'user yang terakhir modifikasi record ini';

-- MODIFY _modifyby
alter table public."sitetype"
	alter column _modifyby type integer,
	ALTER COLUMN _modifyby DROP DEFAULT,
	ALTER COLUMN _modifyby DROP NOT NULL;
comment on column public."sitetype"._modifyby is 'user yang terakhir modifikasi record ini';


-- =============================================
-- FIELD: _modifydate timestamp with time zone
-- =============================================
-- ADD _modifydate
alter table public."sitetype" add _modifydate timestamp with time zone  ;
comment on column public."sitetype"._modifydate is 'waktu terakhir record dimodifikasi';

-- MODIFY _modifydate
alter table public."sitetype"
	alter column _modifydate type timestamp with time zone,
	ALTER COLUMN _modifydate DROP DEFAULT,
	ALTER COLUMN _modifydate DROP NOT NULL;
comment on column public."sitetype"._modifydate is 'waktu terakhir record dimodifikasi';


-- =============================================
-- FIELD: _timestamp timestamp with time zone
-- =============================================
-- ADD _timestamp
alter table public."sitetype" add _timestamp timestamp with time zone not null default now();
comment on column public."sitetype"._timestamp is 'data timestamp';

-- MODIFY _timestamp
alter table public."sitetype"
	alter column _timestamp type timestamp with time zone,
	ALTER COLUMN _timestamp SET DEFAULT now(),
	ALTER COLUMN _timestamp SET NOT NULL;
comment on column public."sitetype"._timestamp is 'data timestamp';


-- =============================================
-- INDEX
-- =============================================
DROP INDEX IF EXISTS public.idx$public$sitetype$_timestamp;
CREATE INDEX idx$public$sitetype$_timestamp ON public.sitetype (_timestamp);




-- =============================================
-- UNIQUE INDEX
-- =============================================
-- Drop existing unique index 
alter table public."sitetype"
	drop constraint uq$public$sitetype$sitetype_name;
	

-- Add unique index 
alter table  public."sitetype"
	add constraint uq$public$sitetype$sitetype_name unique (sitetype_name); 

