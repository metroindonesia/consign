-- adendum.sql


/* =============================================
 * CREATE TABLE public."adendum"
 * ============================================*/
create table public."adendum" (
	adendum_id bigint not null,
	constraint adendum_pk primary key (adendum_id)
);
comment on table public."adendum" is '';	


-- =============================================
-- FIELD: agreement_id bigint
-- =============================================
-- ADD agreement_id
alter table public."adendum" add agreement_id bigint  ;
comment on column public."adendum".agreement_id is '';

-- MODIFY agreement_id
alter table public."adendum"
	alter column agreement_id type bigint,
	ALTER COLUMN agreement_id DROP DEFAULT,
	ALTER COLUMN agreement_id DROP NOT NULL;
comment on column public."adendum".agreement_id is '';


-- =============================================
-- FIELD: adendumtype_id smallint
-- =============================================
-- ADD adendumtype_id
alter table public."adendum" add adendumtype_id smallint  ;
comment on column public."adendum".adendumtype_id is '';

-- MODIFY adendumtype_id
alter table public."adendum"
	alter column adendumtype_id type smallint,
	ALTER COLUMN adendumtype_id DROP DEFAULT,
	ALTER COLUMN adendumtype_id DROP NOT NULL;
comment on column public."adendum".adendumtype_id is '';


-- =============================================
-- FIELD: adendum_desc text
-- =============================================
-- ADD adendum_desc
alter table public."adendum" add adendum_desc text  ;
comment on column public."adendum".adendum_desc is '';

-- MODIFY adendum_desc
alter table public."adendum"
	alter column adendum_desc type text,
	ALTER COLUMN adendum_desc DROP DEFAULT,
	ALTER COLUMN adendum_desc DROP NOT NULL;
comment on column public."adendum".adendum_desc is '';


-- =============================================
-- FIELD: adendum_date date
-- =============================================
-- ADD adendum_date
alter table public."adendum" add adendum_date date  default now();
comment on column public."adendum".adendum_date is '';

-- MODIFY adendum_date
alter table public."adendum"
	alter column adendum_date type date,
	ALTER COLUMN adendum_date SET DEFAULT now(),
	ALTER COLUMN adendum_date DROP NOT NULL;
comment on column public."adendum".adendum_date is '';


-- =============================================
-- FIELD: adendum_datestart date
-- =============================================
-- ADD adendum_datestart
alter table public."adendum" add adendum_datestart date  default now();
comment on column public."adendum".adendum_datestart is '';

-- MODIFY adendum_datestart
alter table public."adendum"
	alter column adendum_datestart type date,
	ALTER COLUMN adendum_datestart SET DEFAULT now(),
	ALTER COLUMN adendum_datestart DROP NOT NULL;
comment on column public."adendum".adendum_datestart is '';


-- =============================================
-- FIELD: adendum_dateend date
-- =============================================
-- ADD adendum_dateend
alter table public."adendum" add adendum_dateend date  default now();
comment on column public."adendum".adendum_dateend is '';

-- MODIFY adendum_dateend
alter table public."adendum"
	alter column adendum_dateend type date,
	ALTER COLUMN adendum_dateend SET DEFAULT now(),
	ALTER COLUMN adendum_dateend DROP NOT NULL;
comment on column public."adendum".adendum_dateend is '';


-- =============================================
-- FIELD: adendum_seq int
-- =============================================
-- ADD adendum_seq
alter table public."adendum" add adendum_seq int  ;
comment on column public."adendum".adendum_seq is '';

-- MODIFY adendum_seq
alter table public."adendum"
	alter column adendum_seq type int,
	ALTER COLUMN adendum_seq DROP DEFAULT,
	ALTER COLUMN adendum_seq DROP NOT NULL;
comment on column public."adendum".adendum_seq is '';


-- =============================================
-- FIELD: iscommit boolean
-- =============================================
-- ADD iscommit
alter table public."adendum" add iscommit boolean not null default false;
comment on column public."adendum".iscommit is '';

-- MODIFY iscommit
alter table public."adendum"
	alter column iscommit type boolean,
	ALTER COLUMN iscommit SET DEFAULT false,
	ALTER COLUMN iscommit SET NOT NULL;
comment on column public."adendum".iscommit is '';


-- =============================================
-- FIELD: isapprove boolean
-- =============================================
-- ADD isapprove
alter table public."adendum" add isapprove boolean not null default false;
comment on column public."adendum".isapprove is '';

-- MODIFY isapprove
alter table public."adendum"
	alter column isapprove type boolean,
	ALTER COLUMN isapprove SET DEFAULT false,
	ALTER COLUMN isapprove SET NOT NULL;
comment on column public."adendum".isapprove is '';


-- =============================================
-- FIELD: commitby bigint
-- =============================================
-- ADD commitby
alter table public."adendum" add commitby bigint  ;
comment on column public."adendum".commitby is '';

-- MODIFY commitby
alter table public."adendum"
	alter column commitby type bigint,
	ALTER COLUMN commitby DROP DEFAULT,
	ALTER COLUMN commitby DROP NOT NULL;
comment on column public."adendum".commitby is '';


-- =============================================
-- FIELD: commitdate timestamp with time zone
-- =============================================
-- ADD commitdate
alter table public."adendum" add commitdate timestamp with time zone  ;
comment on column public."adendum".commitdate is '';

-- MODIFY commitdate
alter table public."adendum"
	alter column commitdate type timestamp with time zone,
	ALTER COLUMN commitdate DROP DEFAULT,
	ALTER COLUMN commitdate DROP NOT NULL;
comment on column public."adendum".commitdate is '';


-- =============================================
-- FIELD: approveby bigint
-- =============================================
-- ADD approveby
alter table public."adendum" add approveby bigint  ;
comment on column public."adendum".approveby is '';

-- MODIFY approveby
alter table public."adendum"
	alter column approveby type bigint,
	ALTER COLUMN approveby DROP DEFAULT,
	ALTER COLUMN approveby DROP NOT NULL;
comment on column public."adendum".approveby is '';


-- =============================================
-- FIELD: approvedate timestamp with time zone
-- =============================================
-- ADD approvedate
alter table public."adendum" add approvedate timestamp with time zone  ;
comment on column public."adendum".approvedate is '';

-- MODIFY approvedate
alter table public."adendum"
	alter column approvedate type timestamp with time zone,
	ALTER COLUMN approvedate DROP DEFAULT,
	ALTER COLUMN approvedate DROP NOT NULL;
comment on column public."adendum".approvedate is '';


-- =============================================
-- FIELD: _createby integer
-- =============================================
-- ADD _createby
alter table public."adendum" add _createby integer not null ;
comment on column public."adendum"._createby is 'user yang pertama kali membuat record ini';

-- MODIFY _createby
alter table public."adendum"
	alter column _createby type integer,
	ALTER COLUMN _createby DROP DEFAULT,
	ALTER COLUMN _createby SET NOT NULL;
comment on column public."adendum"._createby is 'user yang pertama kali membuat record ini';


-- =============================================
-- FIELD: _createdate timestamp with time zone
-- =============================================
-- ADD _createdate
alter table public."adendum" add _createdate timestamp with time zone not null default now();
comment on column public."adendum"._createdate is 'waktu record dibuat pertama kali';

-- MODIFY _createdate
alter table public."adendum"
	alter column _createdate type timestamp with time zone,
	ALTER COLUMN _createdate SET DEFAULT now(),
	ALTER COLUMN _createdate SET NOT NULL;
comment on column public."adendum"._createdate is 'waktu record dibuat pertama kali';


-- =============================================
-- FIELD: _modifyby integer
-- =============================================
-- ADD _modifyby
alter table public."adendum" add _modifyby integer  ;
comment on column public."adendum"._modifyby is 'user yang terakhir modifikasi record ini';

-- MODIFY _modifyby
alter table public."adendum"
	alter column _modifyby type integer,
	ALTER COLUMN _modifyby DROP DEFAULT,
	ALTER COLUMN _modifyby DROP NOT NULL;
comment on column public."adendum"._modifyby is 'user yang terakhir modifikasi record ini';


-- =============================================
-- FIELD: _modifydate timestamp with time zone
-- =============================================
-- ADD _modifydate
alter table public."adendum" add _modifydate timestamp with time zone  ;
comment on column public."adendum"._modifydate is 'waktu terakhir record dimodifikasi';

-- MODIFY _modifydate
alter table public."adendum"
	alter column _modifydate type timestamp with time zone,
	ALTER COLUMN _modifydate DROP DEFAULT,
	ALTER COLUMN _modifydate DROP NOT NULL;
comment on column public."adendum"._modifydate is 'waktu terakhir record dimodifikasi';




-- =============================================
-- FOREIGN KEY CONSTRAINT
-- =============================================
-- Drop Existing Foreign Key Constraint 
ALTER TABLE public."adendum" DROP CONSTRAINT fk$public$adendum$agreement_id;
ALTER TABLE public."adendum" DROP CONSTRAINT fk$public$adendum$adendumtype_id;


-- Add Foreign Key Constraint  
ALTER TABLE public."adendum"
	ADD CONSTRAINT fk$public$adendum$agreement_id
	FOREIGN KEY (agreement_id)
	REFERENCES public."agreement"(agreement_id);


-- Add As Index, drop dulu jika sudah ada
DROP INDEX IF EXISTS public.idx_fk$public$adendum$agreement_id;
CREATE INDEX idx_fk$public$adendum$agreement_id ON public."adendum"(agreement_id);	


ALTER TABLE public."adendum"
	ADD CONSTRAINT fk$public$adendum$adendumtype_id
	FOREIGN KEY (adendumtype_id)
	REFERENCES public."adendumtype"(adendumtype_id);


-- Add As Index, drop dulu jika sudah ada
DROP INDEX IF EXISTS public.idx_fk$public$adendum$adendumtype_id;
CREATE INDEX idx_fk$public$adendum$adendumtype_id ON public."adendum"(adendumtype_id);	

	


-- =============================================
-- UNIQUE INDEX
-- =============================================
-- Drop existing unique index 
alter table public."adendum"
	drop constraint uq$public$adendum$adendum_id;
	

-- Add unique index 
alter table  public."adendum"
	add constraint uq$public$adendum$adendum_id unique (adendum_id); 

