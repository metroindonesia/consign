-- adendum.sql


/* =============================================
 * CREATE TABLE public."adendumbrand"
 * ============================================*/
create table public."adendumbrand" (
	adendumbrand_id bigint not null,
	constraint adendumbrand_pk primary key (adendumbrand_id)
);
comment on table public."adendumbrand" is '';	


-- =============================================
-- FIELD: brand_id int
-- =============================================
-- ADD brand_id
alter table public."adendumbrand" add brand_id int  ;
comment on column public."adendumbrand".brand_id is '';

-- MODIFY brand_id
alter table public."adendumbrand"
	alter column brand_id type int,
	ALTER COLUMN brand_id DROP DEFAULT,
	ALTER COLUMN brand_id DROP NOT NULL;
comment on column public."adendumbrand".brand_id is '';


-- =============================================
-- FIELD: adendum_id bigint
-- =============================================
-- ADD adendum_id
alter table public."adendumbrand" add adendum_id bigint  ;
comment on column public."adendumbrand".adendum_id is '';

-- MODIFY adendum_id
alter table public."adendumbrand"
	alter column adendum_id type bigint,
	ALTER COLUMN adendum_id DROP DEFAULT,
	ALTER COLUMN adendum_id DROP NOT NULL;
comment on column public."adendumbrand".adendum_id is '';


-- =============================================
-- FIELD: _createby integer
-- =============================================
-- ADD _createby
alter table public."adendumbrand" add _createby integer not null ;
comment on column public."adendumbrand"._createby is 'user yang pertama kali membuat record ini';

-- MODIFY _createby
alter table public."adendumbrand"
	alter column _createby type integer,
	ALTER COLUMN _createby DROP DEFAULT,
	ALTER COLUMN _createby SET NOT NULL;
comment on column public."adendumbrand"._createby is 'user yang pertama kali membuat record ini';


-- =============================================
-- FIELD: _createdate timestamp with time zone
-- =============================================
-- ADD _createdate
alter table public."adendumbrand" add _createdate timestamp with time zone not null default now();
comment on column public."adendumbrand"._createdate is 'waktu record dibuat pertama kali';

-- MODIFY _createdate
alter table public."adendumbrand"
	alter column _createdate type timestamp with time zone,
	ALTER COLUMN _createdate SET DEFAULT now(),
	ALTER COLUMN _createdate SET NOT NULL;
comment on column public."adendumbrand"._createdate is 'waktu record dibuat pertama kali';


-- =============================================
-- FIELD: _modifyby integer
-- =============================================
-- ADD _modifyby
alter table public."adendumbrand" add _modifyby integer  ;
comment on column public."adendumbrand"._modifyby is 'user yang terakhir modifikasi record ini';

-- MODIFY _modifyby
alter table public."adendumbrand"
	alter column _modifyby type integer,
	ALTER COLUMN _modifyby DROP DEFAULT,
	ALTER COLUMN _modifyby DROP NOT NULL;
comment on column public."adendumbrand"._modifyby is 'user yang terakhir modifikasi record ini';


-- =============================================
-- FIELD: _modifydate timestamp with time zone
-- =============================================
-- ADD _modifydate
alter table public."adendumbrand" add _modifydate timestamp with time zone  ;
comment on column public."adendumbrand"._modifydate is 'waktu terakhir record dimodifikasi';

-- MODIFY _modifydate
alter table public."adendumbrand"
	alter column _modifydate type timestamp with time zone,
	ALTER COLUMN _modifydate DROP DEFAULT,
	ALTER COLUMN _modifydate DROP NOT NULL;
comment on column public."adendumbrand"._modifydate is 'waktu terakhir record dimodifikasi';


-- =============================================
-- FIELD: _timestamp timestamp with time zone
-- =============================================
-- ADD _timestamp
alter table public."adendumbrand" add _timestamp timestamp with time zone not null default now();
comment on column public."adendumbrand"._timestamp is 'data timestamp';

-- MODIFY _timestamp
alter table public."adendumbrand"
	alter column _timestamp type timestamp with time zone,
	ALTER COLUMN _timestamp SET DEFAULT now(),
	ALTER COLUMN _timestamp SET NOT NULL;
comment on column public."adendumbrand"._timestamp is 'data timestamp';


-- =============================================
-- INDEX
-- =============================================
DROP INDEX IF EXISTS public.idx$public$adendumbrand$_timestamp;
CREATE INDEX idx$public$adendumbrand$_timestamp ON public.adendumbrand (_timestamp);


-- =============================================
-- FOREIGN KEY CONSTRAINT
-- =============================================
-- Drop Existing Foreign Key Constraint 
ALTER TABLE public."adendumbrand" DROP CONSTRAINT fk$public$adendumbrand$brand_id;


-- Add Foreign Key Constraint  
ALTER TABLE public."adendumbrand"
	ADD CONSTRAINT fk$public$adendumbrand$brand_id
	FOREIGN KEY (brand_id)
	REFERENCES public."brand"(brand_id);


-- Add As Index, drop dulu jika sudah ada
DROP INDEX IF EXISTS public.idx_fk$public$adendumbrand$brand_id;
CREATE INDEX idx_fk$public$adendumbrand$brand_id ON public."adendumbrand"(brand_id);	

	


-- =============================================
-- UNIQUE INDEX
-- =============================================