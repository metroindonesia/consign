-- adendumtype.sql


/* =============================================
 * CREATE TABLE public."adendumtype"
 * ============================================*/
create table public."adendumtype" (
	adendumtype_id smallint not null,
	constraint adendumtype_pk primary key (adendumtype_id)
);
comment on table public."adendumtype" is '';	


-- =============================================
-- FIELD: adendumtype_name text
-- =============================================
-- ADD adendumtype_name
alter table public."adendumtype" add adendumtype_name text  ;
comment on column public."adendumtype".adendumtype_name is '';

-- MODIFY adendumtype_name
alter table public."adendumtype"
	alter column adendumtype_name type text,
	ALTER COLUMN adendumtype_name DROP DEFAULT,
	ALTER COLUMN adendumtype_name DROP NOT NULL;
comment on column public."adendumtype".adendumtype_name is '';


-- =============================================
-- FIELD: adendumtype_desc text
-- =============================================
-- ADD adendumtype_desc
alter table public."adendumtype" add adendumtype_desc text  ;
comment on column public."adendumtype".adendumtype_desc is '';

-- MODIFY adendumtype_desc
alter table public."adendumtype"
	alter column adendumtype_desc type text,
	ALTER COLUMN adendumtype_desc DROP DEFAULT,
	ALTER COLUMN adendumtype_desc DROP NOT NULL;
comment on column public."adendumtype".adendumtype_desc is '';


-- =============================================
-- FIELD: adendumtype_isdisabled boolean
-- =============================================
-- ADD adendumtype_isdisabled
alter table public."adendumtype" add adendumtype_isdisabled boolean not null default false;
comment on column public."adendumtype".adendumtype_isdisabled is '';

-- MODIFY adendumtype_isdisabled
alter table public."adendumtype"
	alter column adendumtype_isdisabled type boolean,
	ALTER COLUMN adendumtype_isdisabled SET DEFAULT false,
	ALTER COLUMN adendumtype_isdisabled SET NOT NULL;
comment on column public."adendumtype".adendumtype_isdisabled is '';


-- =============================================
-- FIELD: _createby integer
-- =============================================
-- ADD _createby
alter table public."adendumtype" add _createby integer not null ;
comment on column public."adendumtype"._createby is 'user yang pertama kali membuat record ini';

-- MODIFY _createby
alter table public."adendumtype"
	alter column _createby type integer,
	ALTER COLUMN _createby DROP DEFAULT,
	ALTER COLUMN _createby SET NOT NULL;
comment on column public."adendumtype"._createby is 'user yang pertama kali membuat record ini';


-- =============================================
-- FIELD: _createdate timestamp with time zone
-- =============================================
-- ADD _createdate
alter table public."adendumtype" add _createdate timestamp with time zone not null default now();
comment on column public."adendumtype"._createdate is 'waktu record dibuat pertama kali';

-- MODIFY _createdate
alter table public."adendumtype"
	alter column _createdate type timestamp with time zone,
	ALTER COLUMN _createdate SET DEFAULT now(),
	ALTER COLUMN _createdate SET NOT NULL;
comment on column public."adendumtype"._createdate is 'waktu record dibuat pertama kali';


-- =============================================
-- FIELD: _modifyby integer
-- =============================================
-- ADD _modifyby
alter table public."adendumtype" add _modifyby integer  ;
comment on column public."adendumtype"._modifyby is 'user yang terakhir modifikasi record ini';

-- MODIFY _modifyby
alter table public."adendumtype"
	alter column _modifyby type integer,
	ALTER COLUMN _modifyby DROP DEFAULT,
	ALTER COLUMN _modifyby DROP NOT NULL;
comment on column public."adendumtype"._modifyby is 'user yang terakhir modifikasi record ini';


-- =============================================
-- FIELD: _modifydate timestamp with time zone
-- =============================================
-- ADD _modifydate
alter table public."adendumtype" add _modifydate timestamp with time zone  ;
comment on column public."adendumtype"._modifydate is 'waktu terakhir record dimodifikasi';

-- MODIFY _modifydate
alter table public."adendumtype"
	alter column _modifydate type timestamp with time zone,
	ALTER COLUMN _modifydate DROP DEFAULT,
	ALTER COLUMN _modifydate DROP NOT NULL;
comment on column public."adendumtype"._modifydate is 'waktu terakhir record dimodifikasi';


-- =============================================
-- FIELD: _timestamp timestamp with time zone
-- =============================================
-- ADD _timestamp
alter table public."adendumtype" add _timestamp timestamp with time zone not null default now();
comment on column public."adendumtype"._timestamp is 'data timestamp';

-- MODIFY _timestamp
alter table public."adendumtype"
	alter column _timestamp type timestamp with time zone,
	ALTER COLUMN _timestamp SET DEFAULT now(),
	ALTER COLUMN _timestamp SET NOT NULL;
comment on column public."adendumtype"._timestamp is 'data timestamp';


-- =============================================
-- INDEX
-- =============================================
DROP INDEX IF EXISTS public.idx$public$adendumtype$_timestamp;
CREATE INDEX idx$public$adendumtype$_timestamp ON public.adendumtype (_timestamp);




-- =============================================
-- UNIQUE INDEX
-- =============================================
-- Drop existing unique index 
alter table public."adendumtype"
	drop constraint uq$public$adendumtype$adendumtype_name;
	

-- Add unique index 
alter table  public."adendumtype"
	add constraint uq$public$adendumtype$adendumtype_name unique (adendumtype_name); 

