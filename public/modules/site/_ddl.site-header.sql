-- site.sql


/* =============================================
 * CREATE TABLE public."site"
 * ============================================*/
create table public."site" (
	site_id int not null,
	constraint site_pk primary key (site_id)
);
comment on table public."site" is '';	


-- =============================================
-- FIELD: site_name text
-- =============================================
-- ADD site_name
alter table public."site" add site_name text  ;
comment on column public."site".site_name is '';

-- MODIFY site_name
alter table public."site"
	alter column site_name type text,
	ALTER COLUMN site_name DROP DEFAULT,
	ALTER COLUMN site_name DROP NOT NULL;
comment on column public."site".site_name is '';


-- =============================================
-- FIELD: site_location text
-- =============================================
-- ADD site_location
alter table public."site" add site_location text  ;
comment on column public."site".site_location is '';

-- MODIFY site_location
alter table public."site"
	alter column site_location type text,
	ALTER COLUMN site_location DROP DEFAULT,
	ALTER COLUMN site_location DROP NOT NULL;
comment on column public."site".site_location is '';


-- =============================================
-- FIELD: site_city text
-- =============================================
-- ADD site_city
alter table public."site" add site_city text  ;
comment on column public."site".site_city is '';

-- MODIFY site_city
alter table public."site"
	alter column site_city type text,
	ALTER COLUMN site_city DROP DEFAULT,
	ALTER COLUMN site_city DROP NOT NULL;
comment on column public."site".site_city is '';


-- =============================================
-- FIELD: sitetype_id smallint
-- =============================================
-- ADD sitetype_id
alter table public."site" add sitetype_id smallint  ;
comment on column public."site".sitetype_id is '';

-- MODIFY sitetype_id
alter table public."site"
	alter column sitetype_id type smallint,
	ALTER COLUMN sitetype_id DROP DEFAULT,
	ALTER COLUMN sitetype_id DROP NOT NULL;
comment on column public."site".sitetype_id is '';


-- =============================================
-- FIELD: site_isdisabled boolean
-- =============================================
-- ADD site_isdisabled
alter table public."site" add site_isdisabled boolean not null default false;
comment on column public."site".site_isdisabled is '';

-- MODIFY site_isdisabled
alter table public."site"
	alter column site_isdisabled type boolean,
	ALTER COLUMN site_isdisabled SET DEFAULT false,
	ALTER COLUMN site_isdisabled SET NOT NULL;
comment on column public."site".site_isdisabled is '';


-- =============================================
-- FIELD: _createby integer
-- =============================================
-- ADD _createby
alter table public."site" add _createby integer not null ;
comment on column public."site"._createby is 'user yang pertama kali membuat record ini';

-- MODIFY _createby
alter table public."site"
	alter column _createby type integer,
	ALTER COLUMN _createby DROP DEFAULT,
	ALTER COLUMN _createby SET NOT NULL;
comment on column public."site"._createby is 'user yang pertama kali membuat record ini';


-- =============================================
-- FIELD: _createdate timestamp with time zone
-- =============================================
-- ADD _createdate
alter table public."site" add _createdate timestamp with time zone not null default now();
comment on column public."site"._createdate is 'waktu record dibuat pertama kali';

-- MODIFY _createdate
alter table public."site"
	alter column _createdate type timestamp with time zone,
	ALTER COLUMN _createdate SET DEFAULT now(),
	ALTER COLUMN _createdate SET NOT NULL;
comment on column public."site"._createdate is 'waktu record dibuat pertama kali';


-- =============================================
-- FIELD: _modifyby integer
-- =============================================
-- ADD _modifyby
alter table public."site" add _modifyby integer  ;
comment on column public."site"._modifyby is 'user yang terakhir modifikasi record ini';

-- MODIFY _modifyby
alter table public."site"
	alter column _modifyby type integer,
	ALTER COLUMN _modifyby DROP DEFAULT,
	ALTER COLUMN _modifyby DROP NOT NULL;
comment on column public."site"._modifyby is 'user yang terakhir modifikasi record ini';


-- =============================================
-- FIELD: _modifydate timestamp with time zone
-- =============================================
-- ADD _modifydate
alter table public."site" add _modifydate timestamp with time zone  ;
comment on column public."site"._modifydate is 'waktu terakhir record dimodifikasi';

-- MODIFY _modifydate
alter table public."site"
	alter column _modifydate type timestamp with time zone,
	ALTER COLUMN _modifydate DROP DEFAULT,
	ALTER COLUMN _modifydate DROP NOT NULL;
comment on column public."site"._modifydate is 'waktu terakhir record dimodifikasi';


-- =============================================
-- FIELD: _timestamp timestamp with time zone
-- =============================================
-- ADD _timestamp
alter table public."site" add _timestamp timestamp with time zone not null default now();
comment on column public."site"._timestamp is 'data timestamp';

-- MODIFY _timestamp
alter table public."site"
	alter column _timestamp type timestamp with time zone,
	ALTER COLUMN _timestamp SET DEFAULT now(),
	ALTER COLUMN _timestamp SET NOT NULL;
comment on column public."site"._timestamp is 'data timestamp';


-- =============================================
-- INDEX
-- =============================================
DROP INDEX IF EXISTS public.idx$public$site$_timestamp;
CREATE INDEX idx$public$site$_timestamp ON public.site (_timestamp);


-- =============================================
-- FOREIGN KEY CONSTRAINT
-- =============================================
-- Drop Existing Foreign Key Constraint 
ALTER TABLE public."site" DROP CONSTRAINT fk$public$site$sitetype_id;


-- Add Foreign Key Constraint  
ALTER TABLE public."site"
	ADD CONSTRAINT fk$public$site$sitetype_id
	FOREIGN KEY (sitetype_id)
	REFERENCES public."sitetype"(sitetype_id);


-- Add As Index, drop dulu jika sudah ada
DROP INDEX IF EXISTS public.idx_fk$public$site$sitetype_id;
CREATE INDEX idx_fk$public$site$sitetype_id ON public."site"(sitetype_id);	

	


-- =============================================
-- UNIQUE INDEX
-- =============================================
-- Drop existing unique index 
alter table public."site"
	drop constraint uq$public$site$site_name;
	

-- Add unique index 
alter table  public."site"
	add constraint uq$public$site$site_name unique (site_name); 

