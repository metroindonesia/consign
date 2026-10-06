-- agreement.sql


/* =============================================
 * CREATE TABLE public."agreementbrand"
 * ============================================*/
create table public."agreementbrand" (
	agreementbrand_id bigint not null,
	constraint agreementbrand_pk primary key (agreementbrand_id)
);
comment on table public."agreementbrand" is '';	


-- =============================================
-- FIELD: brand_id int
-- =============================================
-- ADD brand_id
alter table public."agreementbrand" add brand_id int  ;
comment on column public."agreementbrand".brand_id is '';

-- MODIFY brand_id
alter table public."agreementbrand"
	alter column brand_id type int,
	ALTER COLUMN brand_id DROP DEFAULT,
	ALTER COLUMN brand_id DROP NOT NULL;
comment on column public."agreementbrand".brand_id is '';


-- =============================================
-- FIELD: agreement_id bigint
-- =============================================
-- ADD agreement_id
alter table public."agreementbrand" add agreement_id bigint  ;
comment on column public."agreementbrand".agreement_id is '';

-- MODIFY agreement_id
alter table public."agreementbrand"
	alter column agreement_id type bigint,
	ALTER COLUMN agreement_id DROP DEFAULT,
	ALTER COLUMN agreement_id DROP NOT NULL;
comment on column public."agreementbrand".agreement_id is '';


-- =============================================
-- FIELD: _createby integer
-- =============================================
-- ADD _createby
alter table public."agreementbrand" add _createby integer not null ;
comment on column public."agreementbrand"._createby is 'user yang pertama kali membuat record ini';

-- MODIFY _createby
alter table public."agreementbrand"
	alter column _createby type integer,
	ALTER COLUMN _createby DROP DEFAULT,
	ALTER COLUMN _createby SET NOT NULL;
comment on column public."agreementbrand"._createby is 'user yang pertama kali membuat record ini';


-- =============================================
-- FIELD: _createdate timestamp with time zone
-- =============================================
-- ADD _createdate
alter table public."agreementbrand" add _createdate timestamp with time zone not null default now();
comment on column public."agreementbrand"._createdate is 'waktu record dibuat pertama kali';

-- MODIFY _createdate
alter table public."agreementbrand"
	alter column _createdate type timestamp with time zone,
	ALTER COLUMN _createdate SET DEFAULT now(),
	ALTER COLUMN _createdate SET NOT NULL;
comment on column public."agreementbrand"._createdate is 'waktu record dibuat pertama kali';


-- =============================================
-- FIELD: _modifyby integer
-- =============================================
-- ADD _modifyby
alter table public."agreementbrand" add _modifyby integer  ;
comment on column public."agreementbrand"._modifyby is 'user yang terakhir modifikasi record ini';

-- MODIFY _modifyby
alter table public."agreementbrand"
	alter column _modifyby type integer,
	ALTER COLUMN _modifyby DROP DEFAULT,
	ALTER COLUMN _modifyby DROP NOT NULL;
comment on column public."agreementbrand"._modifyby is 'user yang terakhir modifikasi record ini';


-- =============================================
-- FIELD: _modifydate timestamp with time zone
-- =============================================
-- ADD _modifydate
alter table public."agreementbrand" add _modifydate timestamp with time zone  ;
comment on column public."agreementbrand"._modifydate is 'waktu terakhir record dimodifikasi';

-- MODIFY _modifydate
alter table public."agreementbrand"
	alter column _modifydate type timestamp with time zone,
	ALTER COLUMN _modifydate DROP DEFAULT,
	ALTER COLUMN _modifydate DROP NOT NULL;
comment on column public."agreementbrand"._modifydate is 'waktu terakhir record dimodifikasi';




-- =============================================
-- FOREIGN KEY CONSTRAINT
-- =============================================
-- Drop Existing Foreign Key Constraint 
ALTER TABLE public."agreementbrand" DROP CONSTRAINT fk$public$agreementbrand$brand_id;


-- Add Foreign Key Constraint  
ALTER TABLE public."agreementbrand"
	ADD CONSTRAINT fk$public$agreementbrand$brand_id
	FOREIGN KEY (brand_id)
	REFERENCES public."brand"(brand_id);


-- Add As Index, drop dulu jika sudah ada
DROP INDEX IF EXISTS public.idx_fk$public$agreementbrand$brand_id;
CREATE INDEX idx_fk$public$agreementbrand$brand_id ON public."agreementbrand"(brand_id);	

	


-- =============================================
-- UNIQUE INDEX
-- =============================================