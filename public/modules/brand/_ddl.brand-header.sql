-- brand.sql


/* =============================================
 * CREATE TABLE public."brand"
 * ============================================*/
create table public."brand" (
	brand_id int not null,
	constraint brand_pk primary key (brand_id)
);
comment on table public."brand" is '';	


-- =============================================
-- FIELD: brand_name text
-- =============================================
-- ADD brand_name
alter table public."brand" add brand_name text  ;
comment on column public."brand".brand_name is '';

-- MODIFY brand_name
alter table public."brand"
	alter column brand_name type text,
	ALTER COLUMN brand_name DROP DEFAULT,
	ALTER COLUMN brand_name DROP NOT NULL;
comment on column public."brand".brand_name is '';


-- =============================================
-- FIELD: partner_id int
-- =============================================
-- ADD partner_id
alter table public."brand" add partner_id int  ;
comment on column public."brand".partner_id is '';

-- MODIFY partner_id
alter table public."brand"
	alter column partner_id type int,
	ALTER COLUMN partner_id DROP DEFAULT,
	ALTER COLUMN partner_id DROP NOT NULL;
comment on column public."brand".partner_id is '';


-- =============================================
-- FIELD: brand_isdisabled boolean
-- =============================================
-- ADD brand_isdisabled
alter table public."brand" add brand_isdisabled boolean not null default false;
comment on column public."brand".brand_isdisabled is '';

-- MODIFY brand_isdisabled
alter table public."brand"
	alter column brand_isdisabled type boolean,
	ALTER COLUMN brand_isdisabled SET DEFAULT false,
	ALTER COLUMN brand_isdisabled SET NOT NULL;
comment on column public."brand".brand_isdisabled is '';


-- =============================================
-- FIELD: _createby integer
-- =============================================
-- ADD _createby
alter table public."brand" add _createby integer not null ;
comment on column public."brand"._createby is 'user yang pertama kali membuat record ini';

-- MODIFY _createby
alter table public."brand"
	alter column _createby type integer,
	ALTER COLUMN _createby DROP DEFAULT,
	ALTER COLUMN _createby SET NOT NULL;
comment on column public."brand"._createby is 'user yang pertama kali membuat record ini';


-- =============================================
-- FIELD: _createdate timestamp with time zone
-- =============================================
-- ADD _createdate
alter table public."brand" add _createdate timestamp with time zone not null default now();
comment on column public."brand"._createdate is 'waktu record dibuat pertama kali';

-- MODIFY _createdate
alter table public."brand"
	alter column _createdate type timestamp with time zone,
	ALTER COLUMN _createdate SET DEFAULT now(),
	ALTER COLUMN _createdate SET NOT NULL;
comment on column public."brand"._createdate is 'waktu record dibuat pertama kali';


-- =============================================
-- FIELD: _modifyby integer
-- =============================================
-- ADD _modifyby
alter table public."brand" add _modifyby integer  ;
comment on column public."brand"._modifyby is 'user yang terakhir modifikasi record ini';

-- MODIFY _modifyby
alter table public."brand"
	alter column _modifyby type integer,
	ALTER COLUMN _modifyby DROP DEFAULT,
	ALTER COLUMN _modifyby DROP NOT NULL;
comment on column public."brand"._modifyby is 'user yang terakhir modifikasi record ini';


-- =============================================
-- FIELD: _modifydate timestamp with time zone
-- =============================================
-- ADD _modifydate
alter table public."brand" add _modifydate timestamp with time zone  ;
comment on column public."brand"._modifydate is 'waktu terakhir record dimodifikasi';

-- MODIFY _modifydate
alter table public."brand"
	alter column _modifydate type timestamp with time zone,
	ALTER COLUMN _modifydate DROP DEFAULT,
	ALTER COLUMN _modifydate DROP NOT NULL;
comment on column public."brand"._modifydate is 'waktu terakhir record dimodifikasi';


-- =============================================
-- FIELD: _timestamp timestamp with time zone
-- =============================================
-- ADD _timestamp
alter table public."brand" add _timestamp timestamp with time zone not null default now();
comment on column public."brand"._timestamp is 'data timestamp';

-- MODIFY _timestamp
alter table public."brand"
	alter column _timestamp type timestamp with time zone,
	ALTER COLUMN _timestamp SET DEFAULT now(),
	ALTER COLUMN _timestamp SET NOT NULL;
comment on column public."brand"._timestamp is 'data timestamp';


-- =============================================
-- INDEX
-- =============================================
DROP INDEX IF EXISTS public.idx$public$brand$_timestamp;
CREATE INDEX idx$public$brand$_timestamp ON public.brand (_timestamp);


-- =============================================
-- FOREIGN KEY CONSTRAINT
-- =============================================
-- Drop Existing Foreign Key Constraint 
ALTER TABLE public."brand" DROP CONSTRAINT fk$public$brand$partner_id;


-- Add Foreign Key Constraint  
ALTER TABLE public."brand"
	ADD CONSTRAINT fk$public$brand$partner_id
	FOREIGN KEY (partner_id)
	REFERENCES public."partner"(partner_id);


-- Add As Index, drop dulu jika sudah ada
DROP INDEX IF EXISTS public.idx_fk$public$brand$partner_id;
CREATE INDEX idx_fk$public$brand$partner_id ON public."brand"(partner_id);	

	


-- =============================================
-- UNIQUE INDEX
-- =============================================
-- Drop existing unique index 
alter table public."brand"
	drop constraint uq$public$brand$brand_name;
	

-- Add unique index 
alter table  public."brand"
	add constraint uq$public$brand$brand_name unique (brand_name); 

