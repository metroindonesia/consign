-- agreement.sql


/* =============================================
 * CREATE TABLE public."agreementdoc"
 * ============================================*/
create table public."agreementdoc" (
	agreementdoc_id bigint not null,
	constraint agreementdoc_pk primary key (agreementdoc_id)
);
comment on table public."agreementdoc" is '';	


-- =============================================
-- FIELD: agreementdoc_file text
-- =============================================
-- ADD agreementdoc_file
alter table public."agreementdoc" add agreementdoc_file text  ;
comment on column public."agreementdoc".agreementdoc_file is '';

-- MODIFY agreementdoc_file
alter table public."agreementdoc"
	alter column agreementdoc_file type text,
	ALTER COLUMN agreementdoc_file DROP DEFAULT,
	ALTER COLUMN agreementdoc_file DROP NOT NULL;
comment on column public."agreementdoc".agreementdoc_file is '';


-- =============================================
-- FIELD: agreementdoc_type text
-- =============================================
-- ADD agreementdoc_type
alter table public."agreementdoc" add agreementdoc_type text  ;
comment on column public."agreementdoc".agreementdoc_type is '';

-- MODIFY agreementdoc_type
alter table public."agreementdoc"
	alter column agreementdoc_type type text,
	ALTER COLUMN agreementdoc_type DROP DEFAULT,
	ALTER COLUMN agreementdoc_type DROP NOT NULL;
comment on column public."agreementdoc".agreementdoc_type is '';


-- =============================================
-- FIELD: agreementdoc_desc text
-- =============================================
-- ADD agreementdoc_desc
alter table public."agreementdoc" add agreementdoc_desc text  ;
comment on column public."agreementdoc".agreementdoc_desc is '';

-- MODIFY agreementdoc_desc
alter table public."agreementdoc"
	alter column agreementdoc_desc type text,
	ALTER COLUMN agreementdoc_desc DROP DEFAULT,
	ALTER COLUMN agreementdoc_desc DROP NOT NULL;
comment on column public."agreementdoc".agreementdoc_desc is '';


-- =============================================
-- FIELD: agreement_id bigint
-- =============================================
-- ADD agreement_id
alter table public."agreementdoc" add agreement_id bigint  ;
comment on column public."agreementdoc".agreement_id is '';

-- MODIFY agreement_id
alter table public."agreementdoc"
	alter column agreement_id type bigint,
	ALTER COLUMN agreement_id DROP DEFAULT,
	ALTER COLUMN agreement_id DROP NOT NULL;
comment on column public."agreementdoc".agreement_id is '';


-- =============================================
-- FIELD: _createby integer
-- =============================================
-- ADD _createby
alter table public."agreementdoc" add _createby integer not null ;
comment on column public."agreementdoc"._createby is 'user yang pertama kali membuat record ini';

-- MODIFY _createby
alter table public."agreementdoc"
	alter column _createby type integer,
	ALTER COLUMN _createby DROP DEFAULT,
	ALTER COLUMN _createby SET NOT NULL;
comment on column public."agreementdoc"._createby is 'user yang pertama kali membuat record ini';


-- =============================================
-- FIELD: _createdate timestamp with time zone
-- =============================================
-- ADD _createdate
alter table public."agreementdoc" add _createdate timestamp with time zone not null default now();
comment on column public."agreementdoc"._createdate is 'waktu record dibuat pertama kali';

-- MODIFY _createdate
alter table public."agreementdoc"
	alter column _createdate type timestamp with time zone,
	ALTER COLUMN _createdate SET DEFAULT now(),
	ALTER COLUMN _createdate SET NOT NULL;
comment on column public."agreementdoc"._createdate is 'waktu record dibuat pertama kali';


-- =============================================
-- FIELD: _modifyby integer
-- =============================================
-- ADD _modifyby
alter table public."agreementdoc" add _modifyby integer  ;
comment on column public."agreementdoc"._modifyby is 'user yang terakhir modifikasi record ini';

-- MODIFY _modifyby
alter table public."agreementdoc"
	alter column _modifyby type integer,
	ALTER COLUMN _modifyby DROP DEFAULT,
	ALTER COLUMN _modifyby DROP NOT NULL;
comment on column public."agreementdoc"._modifyby is 'user yang terakhir modifikasi record ini';


-- =============================================
-- FIELD: _modifydate timestamp with time zone
-- =============================================
-- ADD _modifydate
alter table public."agreementdoc" add _modifydate timestamp with time zone  ;
comment on column public."agreementdoc"._modifydate is 'waktu terakhir record dimodifikasi';

-- MODIFY _modifydate
alter table public."agreementdoc"
	alter column _modifydate type timestamp with time zone,
	ALTER COLUMN _modifydate DROP DEFAULT,
	ALTER COLUMN _modifydate DROP NOT NULL;
comment on column public."agreementdoc"._modifydate is 'waktu terakhir record dimodifikasi';


-- =============================================
-- FIELD: _timestamp timestamp with time zone
-- =============================================
-- ADD _timestamp
alter table public."agreementdoc" add _timestamp timestamp with time zone not null default now();
comment on column public."agreementdoc"._timestamp is 'data timestamp';

-- MODIFY _timestamp
alter table public."agreementdoc"
	alter column _timestamp type timestamp with time zone,
	ALTER COLUMN _timestamp SET DEFAULT now(),
	ALTER COLUMN _timestamp SET NOT NULL;
comment on column public."agreementdoc"._timestamp is 'data timestamp';


-- =============================================
-- INDEX
-- =============================================
DROP INDEX IF EXISTS public.idx$public$agreementdoc$_timestamp;
CREATE INDEX idx$public$agreementdoc$_timestamp ON public.agreementdoc (_timestamp);




-- =============================================
-- UNIQUE INDEX
-- =============================================