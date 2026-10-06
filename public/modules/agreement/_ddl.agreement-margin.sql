-- agreement.sql


/* =============================================
 * CREATE TABLE public."agreementmargin"
 * ============================================*/
create table public."agreementmargin" (
	agreementmargin_id bigint not null,
	constraint agreementmargin_pk primary key (agreementmargin_id)
);
comment on table public."agreementmargin" is '';	


-- =============================================
-- FIELD: marginrange_id smallint
-- =============================================
-- ADD marginrange_id
alter table public."agreementmargin" add marginrange_id smallint  ;
comment on column public."agreementmargin".marginrange_id is '';

-- MODIFY marginrange_id
alter table public."agreementmargin"
	alter column marginrange_id type smallint,
	ALTER COLUMN marginrange_id DROP DEFAULT,
	ALTER COLUMN marginrange_id DROP NOT NULL;
comment on column public."agreementmargin".marginrange_id is '';


-- =============================================
-- FIELD: marginrange_start decimal(4, 2)
-- =============================================
-- ADD marginrange_start
alter table public."agreementmargin" add marginrange_start decimal(4, 2) not null default 0;
comment on column public."agreementmargin".marginrange_start is '';

-- MODIFY marginrange_start
alter table public."agreementmargin"
	alter column marginrange_start type decimal(4, 2),
	ALTER COLUMN marginrange_start SET DEFAULT 0,
	ALTER COLUMN marginrange_start SET NOT NULL;
comment on column public."agreementmargin".marginrange_start is '';


-- =============================================
-- FIELD: marginrange_end decimal(4, 2)
-- =============================================
-- ADD marginrange_end
alter table public."agreementmargin" add marginrange_end decimal(4, 2) not null default 0;
comment on column public."agreementmargin".marginrange_end is '';

-- MODIFY marginrange_end
alter table public."agreementmargin"
	alter column marginrange_end type decimal(4, 2),
	ALTER COLUMN marginrange_end SET DEFAULT 0,
	ALTER COLUMN marginrange_end SET NOT NULL;
comment on column public."agreementmargin".marginrange_end is '';


-- =============================================
-- FIELD: margin_percent decimal(4, 2)
-- =============================================
-- ADD margin_percent
alter table public."agreementmargin" add margin_percent decimal(4, 2) not null default 0;
comment on column public."agreementmargin".margin_percent is '';

-- MODIFY margin_percent
alter table public."agreementmargin"
	alter column margin_percent type decimal(4, 2),
	ALTER COLUMN margin_percent SET DEFAULT 0,
	ALTER COLUMN margin_percent SET NOT NULL;
comment on column public."agreementmargin".margin_percent is '';


-- =============================================
-- FIELD: agreement_id bigint
-- =============================================
-- ADD agreement_id
alter table public."agreementmargin" add agreement_id bigint  ;
comment on column public."agreementmargin".agreement_id is '';

-- MODIFY agreement_id
alter table public."agreementmargin"
	alter column agreement_id type bigint,
	ALTER COLUMN agreement_id DROP DEFAULT,
	ALTER COLUMN agreement_id DROP NOT NULL;
comment on column public."agreementmargin".agreement_id is '';


-- =============================================
-- FIELD: _createby integer
-- =============================================
-- ADD _createby
alter table public."agreementmargin" add _createby integer not null ;
comment on column public."agreementmargin"._createby is 'user yang pertama kali membuat record ini';

-- MODIFY _createby
alter table public."agreementmargin"
	alter column _createby type integer,
	ALTER COLUMN _createby DROP DEFAULT,
	ALTER COLUMN _createby SET NOT NULL;
comment on column public."agreementmargin"._createby is 'user yang pertama kali membuat record ini';


-- =============================================
-- FIELD: _createdate timestamp with time zone
-- =============================================
-- ADD _createdate
alter table public."agreementmargin" add _createdate timestamp with time zone not null default now();
comment on column public."agreementmargin"._createdate is 'waktu record dibuat pertama kali';

-- MODIFY _createdate
alter table public."agreementmargin"
	alter column _createdate type timestamp with time zone,
	ALTER COLUMN _createdate SET DEFAULT now(),
	ALTER COLUMN _createdate SET NOT NULL;
comment on column public."agreementmargin"._createdate is 'waktu record dibuat pertama kali';


-- =============================================
-- FIELD: _modifyby integer
-- =============================================
-- ADD _modifyby
alter table public."agreementmargin" add _modifyby integer  ;
comment on column public."agreementmargin"._modifyby is 'user yang terakhir modifikasi record ini';

-- MODIFY _modifyby
alter table public."agreementmargin"
	alter column _modifyby type integer,
	ALTER COLUMN _modifyby DROP DEFAULT,
	ALTER COLUMN _modifyby DROP NOT NULL;
comment on column public."agreementmargin"._modifyby is 'user yang terakhir modifikasi record ini';


-- =============================================
-- FIELD: _modifydate timestamp with time zone
-- =============================================
-- ADD _modifydate
alter table public."agreementmargin" add _modifydate timestamp with time zone  ;
comment on column public."agreementmargin"._modifydate is 'waktu terakhir record dimodifikasi';

-- MODIFY _modifydate
alter table public."agreementmargin"
	alter column _modifydate type timestamp with time zone,
	ALTER COLUMN _modifydate DROP DEFAULT,
	ALTER COLUMN _modifydate DROP NOT NULL;
comment on column public."agreementmargin"._modifydate is 'waktu terakhir record dimodifikasi';


-- =============================================
-- FIELD: _timestamp timestamp with time zone
-- =============================================
-- ADD _timestamp
alter table public."agreementmargin" add _timestamp timestamp with time zone not null default now();
comment on column public."agreementmargin"._timestamp is 'data timestamp';

-- MODIFY _timestamp
alter table public."agreementmargin"
	alter column _timestamp type timestamp with time zone,
	ALTER COLUMN _timestamp SET DEFAULT now(),
	ALTER COLUMN _timestamp SET NOT NULL;
comment on column public."agreementmargin"._timestamp is 'data timestamp';


-- =============================================
-- INDEX
-- =============================================
DROP INDEX IF EXISTS public.idx$public$agreementmargin$_timestamp;
CREATE INDEX idx$public$agreementmargin$_timestamp ON public.agreementmargin (_timestamp);


-- =============================================
-- FOREIGN KEY CONSTRAINT
-- =============================================
-- Drop Existing Foreign Key Constraint 
ALTER TABLE public."agreementmargin" DROP CONSTRAINT fk$public$agreementmargin$marginrange_id;


-- Add Foreign Key Constraint  
ALTER TABLE public."agreementmargin"
	ADD CONSTRAINT fk$public$agreementmargin$marginrange_id
	FOREIGN KEY (marginrange_id)
	REFERENCES public."marginrange"(marginrange_id);


-- Add As Index, drop dulu jika sudah ada
DROP INDEX IF EXISTS public.idx_fk$public$agreementmargin$marginrange_id;
CREATE INDEX idx_fk$public$agreementmargin$marginrange_id ON public."agreementmargin"(marginrange_id);	

	


-- =============================================
-- UNIQUE INDEX
-- =============================================