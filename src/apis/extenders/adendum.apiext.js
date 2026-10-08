import sqlUtil from '@agung_dhewe/pgsqlc'
import { createSequencerLine } from '@agung_dhewe/webapps/src/sequencerline.js'

export async function headerCreated(self, tx, ret, data, logMetadata, args) {
    const adendum_id = ret.adendum_id
    const agreement_id = data.agreement_id
    const user_id = data._createby || self.req.session.user.userId
    if (!agreement_id) return

    const seqResult = await tx.one(
        `SELECT COUNT(*) + 1 AS seq 
     FROM public.adendum 
     WHERE agreement_id = $1 
       AND adendum_id <> $2`,
        [agreement_id, adendum_id]
    )
    await tx.none(
        `UPDATE public.adendum SET adendum_seq = $1 WHERE adendum_id = $2`,
        [seqResult.seq, adendum_id]
    )

    const sequencer = createSequencerLine(tx, {})
    const prevAdendum = await tx.oneOrNone(
        `select adendum_id from public.adendum 
         where agreement_id = $1 and isapprove = true and adendum_id <> $2
         order by adendum_seq desc, adendum_id desc limit 1`,
        [agreement_id, adendum_id]
    )

    let margins = []
    let brands = []

    if (prevAdendum) {
        // Ambil Margin dari Adendum Approved terakhir (JOIN ke marginrange untuk mengambil start & end)
        margins = await tx.any(
            `select am.marginrange_id, am.margin_percent, 
                    mr.marginrange_start, mr.marginrange_end
             from public.adendummargin am
             left join public.marginrange mr on mr.marginrange_id = am.marginrange_id
             where am.adendum_id = $1`,
            [prevAdendum.adendum_id]
        )
        brands = await tx.any(
            `select brand_id from public.adendumbrand where adendum_id = $1`,
            [prevAdendum.adendum_id]
        )
    } else {
        // Ambil dari Agreement Induk
        margins = await tx.any(
            `select marginrange_id, marginrange_start, marginrange_end, margin_percent 
             from public.agreementmargin where agreement_id = $1`,
            [agreement_id]
        )
        brands = await tx.any(
            `select brand_id from public.agreementbrand where agreement_id = $1`,
            [agreement_id]
        )
    }

    // Insert data Margin ke adendummargin
    for (let m of margins) {
        const seqdata = await sequencer.increment('ADD')
        const mdata = {
            adendummargin_id: seqdata.id,
            adendum_id,
            marginrange_id: m.marginrange_id,
            marginrange_start: m.marginrange_start || 0,
            marginrange_end: m.marginrange_end || 0,
            margin_percent: m.margin_percent || 0,
            _createby: user_id,
            _createdate: new Date().toISOString()
        }
        const cmd = sqlUtil.createInsertCommand('public.adendummargin', mdata)
        await cmd.execute(mdata)
    }

    // Insert data Brand ke adendumbrand
    for (let b of brands) {
        const seqdata = await sequencer.increment('ADD')
        const bdata = {
            adendumbrand_id: seqdata.id,
            adendum_id,
            brand_id: b.brand_id,
            _createby: user_id,
            _createdate: new Date().toISOString()
        }
        const cmd = sqlUtil.createInsertCommand('public.adendumbrand', bdata)
        await cmd.execute(bdata)
    }
}
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

    sqlUtil.connect(db);
    const [commitbyuser, approvebyuser] = await Promise.all([
        sqlUtil.lookupdb(db, "core.user", "user_id", commitby),
        sqlUtil.lookupdb(db, "core.user", "user_id", approveby)
    ]);

    Object.assign(data, {
        commitby: commitbyuser ? commitbyuser.user_fullname : "",
        approveby: approvebyuser ? approvebyuser.user_fullname : "",
    })
}

export async function commit(self, db, body, adendum_log) {
    const adendum_id = body.adendum_id;
    const user_id = self.req.session.user.userId;
    const startTime = process.hrtime.bigint();

    const sql = `
		update public.adendum 
		set 
		iscommit = true,
		commitby = $[commitby],
		commitdate = now()
		where adendum_id = $[adendum_id]
	`;

    await db.none(sql, {
        adendum_id: adendum_id,
        commitby: user_id,
    });

    const remark = "Commit by user";
    adendum_log(
        self,
        body,
        startTime,
        "public.adendum",
        adendum_id,
        "COMMIT",
        {},
        remark,
    );
    return true;
}

export async function uncommit(self, db, body, adendum_log) {
    const adendum_id = body.adendum_id;
    const user_id = self.req.session.user.userId;
    const startTime = process.hrtime.bigint();

    const sql = `
		update public.adendum 
		set   
		iscommit = false,
		commitby = $[commitby],
		commitdate = now()
		where adendum_id = $[adendum_id]
	`;

    await db.none(sql, {
        adendum_id: adendum_id,
        commitby: user_id,
    });

    const remark = "Uncommit by user";
    adendum_log(
        self,
        body,
        startTime,
        "public.adendum",
        adendum_id,
        "UNCOMMIT",
        {},
        remark,
    );
    return true;
}

export async function approve(self, db, body, adendum_log) {
    const adendum_id = body.adendum_id;
    const user_id = self.req.session.user.userId;
    const startTime = process.hrtime.bigint();

    const sql = `
		update public.adendum 
		set 
		isapprove = true,
		approveby = $[approveby],
		approvedate = now()
		where adendum_id = $[adendum_id]
	`;

    await db.none(sql, {
        adendum_id: adendum_id,
        approveby: user_id,
    });

    const remark = "Approve by user";
    adendum_log(
        self,
        body,
        startTime,
        "public.adendum",
        adendum_id,
        "APPROVE",
        {},
        remark,
    );
    return true;
}

export async function unapprove(self, db, body, adendum_log) {
    const adendum_id = body.adendum_id;
    const user_id = self.req.session.user.userId;
    const startTime = process.hrtime.bigint();

    const sql = `
		update public.adendum 
		set 
		isapprove = false,
		approveby = $[approveby],
		approvedate = now()
		where adendum_id = $[adendum_id]
	`;

    await db.none(sql, {
        adendum_id: adendum_id,
        approveby: user_id,
    });

    const remark = "Unapprove by user";
    adendum_log(
        self,
        body,
        startTime,
        "public.adendum",
        adendum_id,
        "UNAPPROVE",
        {},
        remark,
    );
    return true;
}

export function headerListCriteria(self, db, searchMap, criteria, sort, columns) {
    searchMap.agreement_id = 'agreement_id = ${agreement_id}'
    searchMap.isapprove = 'isapprove = ${isapprove}'
}