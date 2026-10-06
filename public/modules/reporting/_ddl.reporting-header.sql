-- reporting.sql


/* =============================================
 * CREATE TABLE public."reporting"
 * ============================================*/
create table public."reporting" (
	reporting_id bigint not null,
	constraint reporting_pk primary key (reporting_id)
);
comment on table public."reporting" is '';	


-- =============================================
-- FIELD: agreement_id text
-- =============================================
-- ADD agreement_id
alter table public."reporting" add agreement_id text  ;
comment on column public."reporting".agreement_id is '';

-- MODIFY agreement_id
alter table public."reporting"
	alter column agreement_id type text,
	ALTER COLUMN agreement_id DROP DEFAULT,
	ALTER COLUMN agreement_id DROP NOT NULL;
comment on column public."reporting".agreement_id is '';


-- =============================================
-- FIELD: partner_name text
-- =============================================
-- ADD partner_name
alter table public."reporting" add partner_name text  ;
comment on column public."reporting".partner_name is '';

-- MODIFY partner_name
alter table public."reporting"
	alter column partner_name type text,
	ALTER COLUMN partner_name DROP DEFAULT,
	ALTER COLUMN partner_name DROP NOT NULL;
comment on column public."reporting".partner_name is '';


-- =============================================
-- FIELD: site_name text
-- =============================================
-- ADD site_name
alter table public."reporting" add site_name text  ;
comment on column public."reporting".site_name is '';

-- MODIFY site_name
alter table public."reporting"
	alter column site_name type text,
	ALTER COLUMN site_name DROP DEFAULT,
	ALTER COLUMN site_name DROP NOT NULL;
comment on column public."reporting".site_name is '';


-- =============================================
-- FIELD: agreement_datestart text
-- =============================================
-- ADD agreement_datestart
alter table public."reporting" add agreement_datestart text  ;
comment on column public."reporting".agreement_datestart is '';

-- MODIFY agreement_datestart
alter table public."reporting"
	alter column agreement_datestart type text,
	ALTER COLUMN agreement_datestart DROP DEFAULT,
	ALTER COLUMN agreement_datestart DROP NOT NULL;
comment on column public."reporting".agreement_datestart is '';


-- =============================================
-- FIELD: agreement_dateend text
-- =============================================
-- ADD agreement_dateend
alter table public."reporting" add agreement_dateend text  ;
comment on column public."reporting".agreement_dateend is '';

-- MODIFY agreement_dateend
alter table public."reporting"
	alter column agreement_dateend type text,
	ALTER COLUMN agreement_dateend DROP DEFAULT,
	ALTER COLUMN agreement_dateend DROP NOT NULL;
comment on column public."reporting".agreement_dateend is '';


-- =============================================
-- FIELD: reporting_status text
-- =============================================
-- ADD reporting_status
alter table public."reporting" add reporting_status text  ;
comment on column public."reporting".reporting_status is '';

-- MODIFY reporting_status
alter table public."reporting"
	alter column reporting_status type text,
	ALTER COLUMN reporting_status DROP DEFAULT,
	ALTER COLUMN reporting_status DROP NOT NULL;
comment on column public."reporting".reporting_status is '';


-- =============================================
-- FIELD: _createby integer
-- =============================================
-- ADD _createby
alter table public."reporting" add _createby integer not null ;
comment on column public."reporting"._createby is 'user yang pertama kali membuat record ini';

-- MODIFY _createby
alter table public."reporting"
	alter column _createby type integer,
	ALTER COLUMN _createby DROP DEFAULT,
	ALTER COLUMN _createby SET NOT NULL;
comment on column public."reporting"._createby is 'user yang pertama kali membuat record ini';


-- =============================================
-- FIELD: _createdate timestamp with time zone
-- =============================================
-- ADD _createdate
alter table public."reporting" add _createdate timestamp with time zone not null default now();
comment on column public."reporting"._createdate is 'waktu record dibuat pertama kali';

-- MODIFY _createdate
alter table public."reporting"
	alter column _createdate type timestamp with time zone,
	ALTER COLUMN _createdate SET DEFAULT now(),
	ALTER COLUMN _createdate SET NOT NULL;
comment on column public."reporting"._createdate is 'waktu record dibuat pertama kali';


-- =============================================
-- FIELD: _modifyby integer
-- =============================================
-- ADD _modifyby
alter table public."reporting" add _modifyby integer  ;
comment on column public."reporting"._modifyby is 'user yang terakhir modifikasi record ini';

-- MODIFY _modifyby
alter table public."reporting"
	alter column _modifyby type integer,
	ALTER COLUMN _modifyby DROP DEFAULT,
	ALTER COLUMN _modifyby DROP NOT NULL;
comment on column public."reporting"._modifyby is 'user yang terakhir modifikasi record ini';


-- =============================================
-- FIELD: _modifydate timestamp with time zone
-- =============================================
-- ADD _modifydate
alter table public."reporting" add _modifydate timestamp with time zone  ;
comment on column public."reporting"._modifydate is 'waktu terakhir record dimodifikasi';

-- MODIFY _modifydate
alter table public."reporting"
	alter column _modifydate type timestamp with time zone,
	ALTER COLUMN _modifydate DROP DEFAULT,
	ALTER COLUMN _modifydate DROP NOT NULL;
comment on column public."reporting"._modifydate is 'waktu terakhir record dimodifikasi';






-- =============================================
-- UNIQUE INDEX
-- =============================================
-- Drop existing unique index 
alter table public."reporting"
	drop constraint uq$public$reporting$reporting_id;
	

-- Add unique index 
alter table  public."reporting"
	add constraint uq$public$reporting$reporting_id unique (reporting_id); 

