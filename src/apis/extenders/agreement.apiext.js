import sqlUtil from "@agung_dhewe/pgsqlc";
import db from "@agung_dhewe/webapps/src/db.js";
import { createSequencerLine } from "@agung_dhewe/webapps/src/sequencerline.js";

export async function headerUpdating(self, tx, data) {
  const req = self.req;
  const user_id = req.session.user.userId;

  if (data.iscommit && !data.commitby) {
    data.commitby = user_id;
    data.commitdate = new Date().toISOString();
  }
  if (data.isapprove && !data.approveby) {
    data.approveby = user_id;
    data.approvedate = new Date().toISOString();
  }
}

export async function headerOpen(self, db, data) {
  // console.log("headerOpen", data);
  const commitby = data.commitby;
  const approveby = data.approveby;
  const agreement_id = data.agreement_id;

  sqlUtil.connect(db);
  const [commitbyuser, approvebyuser, newAdendum] = await Promise.all([
    sqlUtil.lookupdb(db, "core.user", "user_id", commitby),
    sqlUtil.lookupdb(db, "core.user", "user_id", approveby),
    db.oneOrNone(
      `select adendum_id, adendum_seq from public.adendum 
       where agreement_id = $1 and isapprove = true 
       order by adendum_seq desc, adendum_id desc limit 1`,
      [agreement_id]
    )
  ]);

  Object.assign(data, {
    commitby: commitbyuser ? commitbyuser.user_fullname : "",
    approveby: approvebyuser ? approvebyuser.user_fullname : "",
    adendum_id: newAdendum ? newAdendum.adendum_id : "",
    adendum_seq: newAdendum ? newAdendum.adendum_seq : ""
  });

  // const commitbyuser = await sqlUtil.lookupdb(db, 'core.user', 'user_id', commitby)
  // const fullname = commitbyuser ? commitbyuser.user_fullname : ''
  // data.commitby = fullname
}

export async function commit(self, db, body, agreement_log) {
  const agreement_id = body.agreement_id;
  const user_id = self.req.session.user.userId;
  const startTime = process.hrtime.bigint();

  const sql = `
		update public.agreement 
		set 
		iscommit = true,
		commitby = $[commitby],
		commitdate = now()
		where agreement_id = $[agreement_id]
	`;

  await db.none(sql, {
    agreement_id: agreement_id,
    commitby: user_id,
  });

  const remark = "Commit by user";
  agreement_log(
    self,
    body,
    startTime,
    "public.agreement",
    agreement_id,
    "COMMIT",
    {},
    remark,
  );
  return true;
}

export async function uncommit(self, db, body, agreement_log) {
  const agreement_id = body.agreement_id;
  const user_id = self.req.session.user.userId;
  const startTime = process.hrtime.bigint();

  const sql = `
		update public.agreement 
		set   
		iscommit = false,
		commitby = $[commitby],
		commitdate = now()
		where agreement_id = $[agreement_id]
	`;

  await db.none(sql, {
    agreement_id: agreement_id,
    commitby: user_id,
  });

  const remark = "Uncommit by user";
  agreement_log(
    self,
    body,
    startTime,
    "public.agreement",
    agreement_id,
    "UNCOMMIT",
    {},
    remark,
  );
  return true;
}

export async function approve(self, db, body, agreement_log) {
  const agreement_id = body.agreement_id;
  const user_id = self.req.session.user.userId;
  const startTime = process.hrtime.bigint();

  const sql = `
		update public.agreement 
		set 
		isapprove = true,
		approveby = $[approveby],
		approvedate = now()
		where agreement_id = $[agreement_id]
	`;

  await db.none(sql, {
    agreement_id: agreement_id,
    approveby: user_id,
  });

  const remark = "Approve by user";
  agreement_log(
    self,
    body,
    startTime,
    "public.agreement",
    agreement_id,
    "APPROVE",
    {},
    remark,
  );
  return true;
}

export async function unapprove(self, db, body, agreement_log) {
  const agreement_id = body.agreement_id;
  const user_id = self.req.session.user.userId;
  const startTime = process.hrtime.bigint();

  const sql = `
		update public.agreement 
		set 
		isapprove = false,
		approveby = $[approveby],
		approvedate = now()
		where agreement_id = $[agreement_id]
	`;

  await db.none(sql, {
    agreement_id: agreement_id,
    approveby: user_id,
  });

  const remark = "Unapprove by user";
  agreement_log(
    self,
    body,
    startTime,
    "public.agreement",
    agreement_id,
    "UNAPPROVE",
    {},
    remark,
  );
  return true;
}

const marginTableName = "public.agreementmargin";

export async function headerCreated(self, tx, ret, data, logMetadata, args) {
  const agreement_id = ret.agreement_id;
  const user_id = data._createby;
  const margs = { section: "margin", prefix: "AGR" };
  const tablename = marginTableName;

  const sequencer = createSequencerLine(tx, {});

  for (let i = 0; i < 10; i++) {
    const mdata = {
      agreement_id,
      _createby: user_id,
      _createdate: new Date().toISOString(),
    };

    const seqdata = await sequencer.increment(margs.prefix);
    mdata.agreementmargin_id = seqdata.id;

    const cmd = sqlUtil.createInsertCommand(tablename, mdata);
    await cmd.execute(mdata);
  }

  logMetadata = {};
}

export async function getPrintData(self, db, body) {
  const { agreement_id } = body;
  sqlUtil.connect(db);

  const sekarang = new Date();
  const offset = sekarang.getTimezoneOffset() * 60000;
  const waktuLokalISO = new Date(sekarang - offset).toISOString().slice(0, -1);

  try {
    const header = await sqlUtil.lookupdb(
      db,
      "public.agreement",
      "agreement_id",
      agreement_id,
    );

    const [partner, site, userCreate] = await Promise.all([
      header.partner_id
        ? sqlUtil.lookupdb(
          db,
          "public.partner",
          "partner_id",
          header.partner_id,
        )
        : null,
      header.site_id
        ? sqlUtil.lookupdb(db, "public.site", "site_id", header.site_id)
        : null,
      header._createby
        ? sqlUtil.lookupdb(db, "core.user", "user_id", header._createby)
        : null,
    ]);

    const data = {
      title: `AGR ${agreement_id}`,
      header: {
        printdate: sqlUtil.formatISODate(waktuLokalISO, "dd/mm/yyyy"),
        agreement_id: header.agreement_id,
        agreement_date: header.agreement_date
          ? sqlUtil.formatISODate(header.agreement_date, "dd/mm/yyyy")
          : "-",
        agreement_datestart: header.agreement_datestart
          ? sqlUtil.formatISODate(header.agreement_datestart, "dd/mm/yyyy")
          : "-",
        agreement_dateend: header.agreement_dateend
          ? sqlUtil.formatISODate(header.agreement_dateend, "dd/mm/yyyy")
          : "-",
        agreement_desc: header.agreement_desc || "-",
        partner_name: partner ? partner.partner_name : "-",
        site_name: site ? site.site_name : "-",
        createby_name: userCreate ? userCreate.user_fullname : "-",
      },
      detilBrand: [],
      detilMargin: [],
      detilDoc: [],
    };

    const sqlBrand = `
      select ab.agreementbrand_id, b.brand_name 
      from public.agreementbrand ab
      left join public.brand b on b.brand_id = ab.brand_id
      where ab.agreement_id = $[agreement_id]
    `;
    const rowsBrand = await db.any(sqlBrand, { agreement_id: agreement_id });
    let iBrand = 0;
    for (let rowBrand of rowsBrand) {
      iBrand++;
      data.detilBrand.push({
        no: iBrand,
        brand_name: rowBrand.brand_name || "-",
      });
    }

    const sqlMargin = `
      select * from public.agreementmargin
      where agreement_id = $[agreement_id]
    `;
    const rowsMargin = await db.any(sqlMargin, { agreement_id: agreement_id });
    let iMargin = 0;
    for (let rowMargin of rowsMargin) {
      iMargin++;
      data.detilMargin.push({
        no: iMargin,
        marginrange_start: rowMargin.marginrange_start,
        marginrange_end: rowMargin.marginrange_end,
        margin_percent: rowMargin.margin_percent,
      });
    }

    const sqlDocs = `
    select * from public.agreementdoc
    where agreement_id = $[agreement_id]
    `;
    const rowsDoc = await db.any(sqlDocs, { agreement_id: agreement_id });
    let iDoc = 0;
    for (let rowDoc of rowsDoc) {
      iDoc++;
      data.detilDoc.push({
        no: iDoc,
        agreementdoc_file: rowDoc.agreementdoc_file,
        agreementdoc_type: rowDoc.agreementdoc_type,
        agreementdoc_desc: rowDoc.agreementdoc_desc,
      });
    }

    return data;
  } catch (err) {
    throw err;
  }
}
