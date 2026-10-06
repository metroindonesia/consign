-- agreement.sql


/* =============================================
 * CREATE TABLE public."agreement"
 * ============================================*/
create table public."agreement" (
	agreement_id bigint not null,
	constraint agreement_pk primary key (agreement_id)
);
comment on table public."agreement" is '';	


-- =============================================
-- FIELD: partner_id int
-- =============================================
-- ADD partner_id
alter table public."agreement" add partner_id int  ;
comment on column public."agreement".partner_id is '';

-- MODIFY partner_id
alter table public."agreement"
	alter column partner_id type int,
	ALTER COLUMN partner_id DROP DEFAULT,
	ALTER COLUMN partner_id DROP NOT NULL;
comment on column public."agreement".partner_id is '';


-- =============================================
-- FIELD: site_id int
-- =============================================
-- ADD site_id
alter table public."agreement" add site_id int  ;
comment on column public."agreement".site_id is '';

-- MODIFY site_id
alter table public."agreement"
	alter column site_id type int,
	ALTER COLUMN site_id DROP DEFAULT,
	ALTER COLUMN site_id DROP NOT NULL;
comment on column public."agreement".site_id is '';


-- =============================================
-- FIELD: agreement_date date
-- =============================================
-- ADD agreement_date
alter table public."agreement" add agreement_date date  default now();
comment on column public."agreement".agreement_date is '';

-- MODIFY agreement_date
alter table public."agreement"
	alter column agreement_date type date,
	ALTER COLUMN agreement_date SET DEFAULT now(),
	ALTER COLUMN agreement_date DROP NOT NULL;
comment on column public."agreement".agreement_date is '';


-- =============================================
-- FIELD: agreement_datestart date
-- =============================================
-- ADD agreement_datestart
alter table public."agreement" add agreement_datestart date  default now();
comment on column public."agreement".agreement_datestart is '';

-- MODIFY agreement_datestart
alter table public."agreement"
	alter column agreement_datestart type date,
	ALTER COLUMN agreement_datestart SET DEFAULT now(),
	ALTER COLUMN agreement_datestart DROP NOT NULL;
comment on column public."agreement".agreement_datestart is '';


-- =============================================
-- FIELD: agreement_dateend date
-- =============================================
-- ADD agreement_dateend
alter table public."agreement" add agreement_dateend date  default now();
comment on column public."agreement".agreement_dateend is '';

-- MODIFY agreement_dateend
alter table public."agreement"
	alter column agreement_dateend type date,
	ALTER COLUMN agreement_dateend SET DEFAULT now(),
	ALTER COLUMN agreement_dateend DROP NOT NULL;
comment on column public."agreement".agreement_dateend is '';


-- =============================================
-- FIELD: agreement_desc text
-- =============================================
-- ADD agreement_desc
alter table public."agreement" add agreement_desc text  ;
comment on column public."agreement".agreement_desc is '';

-- MODIFY agreement_desc
alter table public."agreement"
	alter column agreement_desc type text,
	ALTER COLUMN agreement_desc DROP DEFAULT,
	ALTER COLUMN agreement_desc DROP NOT NULL;
comment on column public."agreement".agreement_desc is '';


-- =============================================
-- FIELD: iscommit boolean
-- =============================================
-- ADD iscommit
alter table public."agreement" add iscommit boolean not null default false;
comment on column public."agreement".iscommit is '';

-- MODIFY iscommit
alter table public."agreement"
	alter column iscommit type boolean,
	ALTER COLUMN iscommit SET DEFAULT false,
	ALTER COLUMN iscommit SET NOT NULL;
comment on column public."agreement".iscommit is '';


-- =============================================
-- FIELD: commitby bigint
-- =============================================
-- ADD commitby
alter table public."agreement" add commitby bigint  ;
comment on column public."agreement".commitby is '';

-- MODIFY commitby
alter table public."agreement"
	alter column commitby type bigint,
	ALTER COLUMN commitby DROP DEFAULT,
	ALTER COLUMN commitby DROP NOT NULL;
comment on column public."agreement".commitby is '';


-- =============================================
-- FIELD: commitdate timestamp with time zone
-- =============================================
-- ADD commitdate
alter table public."agreement" add commitdate timestamp with time zone  ;
comment on column public."agreement".commitdate is '';

-- MODIFY commitdate
alter table public."agreement"
	alter column commitdate type timestamp with time zone,
	ALTER COLUMN commitdate DROP DEFAULT,
	ALTER COLUMN commitdate DROP NOT NULL;
comment on column public."agreement".commitdate is '';


-- =============================================
-- FIELD: isapprove boolean
-- =============================================
-- ADD isapprove
alter table public."agreement" add isapprove boolean not null default false;
comment on column public."agreement".isapprove is '';

-- MODIFY isapprove
alter table public."agreement"
	alter column isapprove type boolean,
	ALTER COLUMN isapprove SET DEFAULT false,
	ALTER COLUMN isapprove SET NOT NULL;
comment on column public."agreement".isapprove is '';


-- =============================================
-- FIELD: approveby bigint
-- =============================================
-- ADD approveby
alter table public."agreement" add approveby bigint  ;
comment on column public."agreement".approveby is '';

-- MODIFY approveby
alter table public."agreement"
	alter column approveby type bigint,
	ALTER COLUMN approveby DROP DEFAULT,
	ALTER COLUMN approveby DROP NOT NULL;
comment on column public."agreement".approveby is '';


-- =============================================
-- FIELD: approvedate timestamp with time zone
-- =============================================
-- ADD approvedate
alter table public."agreement" add approvedate timestamp with time zone  ;
comment on column public."agreement".approvedate is '';

-- MODIFY approvedate
alter table public."agreement"
	alter column approvedate type timestamp with time zone,
	ALTER COLUMN approvedate DROP DEFAULT,
	ALTER COLUMN approvedate DROP NOT NULL;
comment on column public."agreement".approvedate is '';


-- =============================================
-- FIELD: adendum_id bigint
-- =============================================
-- ADD adendum_id
alter table public."agreement" add adendum_id bigint  default 0;
comment on column public."agreement".adendum_id is '';

-- MODIFY adendum_id
alter table public."agreement"
	alter column adendum_id type bigint,
	ALTER COLUMN adendum_id SET DEFAULT 0,
	ALTER COLUMN adendum_id DROP NOT NULL;
comment on column public."agreement".adendum_id is '';


-- =============================================
-- FIELD: adendum_seq int
-- =============================================
-- ADD adendum_seq
alter table public."agreement" add adendum_seq int  ;
comment on column public."agreement".adendum_seq is '';

-- MODIFY adendum_seq
alter table public."agreement"
	alter column adendum_seq type int,
	ALTER COLUMN adendum_seq DROP DEFAULT,
	ALTER COLUMN adendum_seq DROP NOT NULL;
comment on column public."agreement".adendum_seq is '';


-- =============================================
-- FIELD: _createby integer
-- =============================================
-- ADD _createby
alter table public."agreement" add _createby integer not null ;
comment on column public."agreement"._createby is 'user yang pertama kali membuat record ini';

-- MODIFY _createby
alter table public."agreement"
	alter column _createby type integer,
	ALTER COLUMN _createby DROP DEFAULT,
	ALTER COLUMN _createby SET NOT NULL;
comment on column public."agreement"._createby is 'user yang pertama kali membuat record ini';


-- =============================================
-- FIELD: _createdate timestamp with time zone
-- =============================================
-- ADD _createdate
alter table public."agreement" add _createdate timestamp with time zone not null default now();
comment on column public."agreement"._createdate is 'waktu record dibuat pertama kali';

-- MODIFY _createdate
alter table public."agreement"
	alter column _createdate type timestamp with time zone,
	ALTER COLUMN _createdate SET DEFAULT now(),
	ALTER COLUMN _createdate SET NOT NULL;
comment on column public."agreement"._createdate is 'waktu record dibuat pertama kali';


-- =============================================
-- FIELD: _modifyby integer
-- =============================================
-- ADD _modifyby
alter table public."agreement" add _modifyby integer  ;
comment on column public."agreement"._modifyby is 'user yang terakhir modifikasi record ini';

-- MODIFY _modifyby
alter table public."agreement"
	alter column _modifyby type integer,
	ALTER COLUMN _modifyby DROP DEFAULT,
	ALTER COLUMN _modifyby DROP NOT NULL;
comment on column public."agreement"._modifyby is 'user yang terakhir modifikasi record ini';


-- =============================================
-- FIELD: _modifydate timestamp with time zone
-- =============================================
-- ADD _modifydate
alter table public."agreement" add _modifydate timestamp with time zone  ;
comment on column public."agreement"._modifydate is 'waktu terakhir record dimodifikasi';

-- MODIFY _modifydate
alter table public."agreement"
	alter column _modifydate type timestamp with time zone,
	ALTER COLUMN _modifydate DROP DEFAULT,
	ALTER COLUMN _modifydate DROP NOT NULL;
comment on column public."agreement"._modifydate is 'waktu terakhir record dimodifikasi';


-- =============================================
-- FIELD: _timestamp timestamp with time zone
-- =============================================
-- ADD _timestamp
alter table public."agreement" add _timestamp timestamp with time zone not null default now();
comment on column public."agreement"._timestamp is 'data timestamp';

-- MODIFY _timestamp
alter table public."agreement"
	alter column _timestamp type timestamp with time zone,
	ALTER COLUMN _timestamp SET DEFAULT now(),
	ALTER COLUMN _timestamp SET NOT NULL;
comment on column public."agreement"._timestamp is 'data timestamp';


-- =============================================
-- INDEX
-- =============================================
DROP INDEX IF EXISTS public.idx$public$agreement$_timestamp;
CREATE INDEX idx$public$agreement$_timestamp ON public.agreement (_timestamp);


-- =============================================
-- FOREIGN KEY CONSTRAINT
-- =============================================
-- Drop Existing Foreign Key Constraint 
ALTER TABLE public."agreement" DROP CONSTRAINT fk$public$agreement$partner_id;
ALTER TABLE public."agreement" DROP CONSTRAINT fk$public$agreement$site_id;


-- Add Foreign Key Constraint  
ALTER TABLE public."agreement"
	ADD CONSTRAINT fk$public$agreement$partner_id
	FOREIGN KEY (partner_id)
	REFERENCES public."partner"(partner_id);


-- Add As Index, drop dulu jika sudah ada
DROP INDEX IF EXISTS public.idx_fk$public$agreement$partner_id;
CREATE INDEX idx_fk$public$agreement$partner_id ON public."agreement"(partner_id);	


ALTER TABLE public."agreement"
	ADD CONSTRAINT fk$public$agreement$site_id
	FOREIGN KEY (site_id)
	REFERENCES public."site"(site_id);


-- Add As Index, drop dulu jika sudah ada
DROP INDEX IF EXISTS public.idx_fk$public$agreement$site_id;
CREATE INDEX idx_fk$public$agreement$site_id ON public."agreement"(site_id);	

	


-- =============================================
-- UNIQUE INDEX
-- =============================================
-- Drop existing unique index 
alter table public."agreement"
	drop constraint uq$public$agreement$agreement_id;
	

-- Add unique index 
alter table  public."agreement"
	add constraint uq$public$agreement$agreement_id unique (agreement_id); 

