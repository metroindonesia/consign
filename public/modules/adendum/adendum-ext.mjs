import Context from './adendum-context.mjs'

const _adendum_id = "adendumHeaderEdit-obj_adendum_id"
const _datestart = "adendumHeaderEdit-obj_adendum_datestart"
const _dateend = "adendumHeaderEdit-obj_adendum_dateend"
const _iscommit = "adendumHeaderEdit-obj_iscommit"
const _isapprove = "adendumHeaderEdit-obj_isapprove"

export const extenderHeader = {
	obj_agreement_id_selecting_criteria(self, obj_agreement_id, frm, criteria, sort, evt) {
		criteria.isapprove = true
	},

	obj_adendumtype_id_selecting_criteria(self, obj_adendumtype_id, frm, criteria, sort, evt) {
		criteria.adendumtype_isdisabled = false
	}
}

export const extenderBrand = {
	obj_brand_id_selecting_criteria(self, obj_brand_id, frm, criteria, sort, evt) {
		criteria.brand_isdisabled = false
		const frmHeader = evt.detail.CurrentState.getHeaderForm()
		const agreement_id = frmHeader.Inputs['adendumHeaderEdit-obj_agreement_id']?.value
		if (agreement_id) {
			criteria.agreement_id = agreement_id
		}
	}
}

const VIEW_VARIANCE = 'view'

export async function init(self, args) {
	console.log('initializing adendumExtender ...')

	// tambahkan extender inisiasi module adendumF


	/* // contoh menambahkan content dari template extender
	{
		const target = secRec.querySelector('#fRecord-section div[name="column"][exteder]')
		const tpl = document.getElementById('tpl-record-panel')
		if (tpl!=null) {
			const clone = tpl.content.cloneNode(true); // salin isi template
			target.prepend(clone)
		}
	}
	*/

	/* // contoh menambahkan custom validator
	// pada html, tambahkan validator="cobaFunction:paramValue"
	const frm = self.Modules.coaHeaderEdit.getHeaderForm()
	const obj_coa_normal = frm.Inputs['coaHeaderEdit-obj_coa_normal']
	$validators.addCustomValidator('cobaFunction', (v, param)=>{
		  console.log(v)
		  setTimeout(()=>{
				obj_coa_normal.setError('ini error')
		  }, 500)
	})	


	*/
}

async function updateStatusButton(self, frm, CurrentState, buttons, evt) {
	const iscommit = frm.Inputs[_iscommit].value;
	const isapprove = frm.Inputs[_isapprove].value;

	CurrentState.Actions.commit.suspend(iscommit);
	CurrentState.Actions.uncommit.suspend(!iscommit || isapprove);
	CurrentState.Actions.approve.suspend(isapprove || !iscommit);
	CurrentState.Actions.unapprove.suspend(!isapprove);
	CurrentState.Actions.edit.suspend(isapprove)
}

async function btnCommit_onClick(self, frm, CurrentState, buttons, evt) {
	// console.log("commit geys")
	const adendum_id = frm.Inputs[_adendum_id].value;
	// console.log(adendum_id);

	try {
		const url = "adendum/execute";
		const result = await Module.apiCall(url, {
			fnName: "commit",
			adendum_id: adendum_id,
			iscommit: true,
		})

		frm.Inputs[_iscommit].value = true;
		frm.acceptChanges();
		updateStatusButton(self, frm, CurrentState, buttons, evt);
		$fgta5.MessageBox.info("Adendum berhasil dicommit")
	} catch (err) {
		console.error(err)
		$fgta5.MessageBox.error(err.message);
	}
}

async function btnUncommit_onClick(self, frm, CurrentState, buttons, evt) {
	// console.log("uncommit geys")
	const adendum_id = frm.Inputs[_adendum_id].value;
	// console.log(adendum_id);

	try {
		const url = "adendum/execute";
		const result = await Module.apiCall(url, {
			fnName: "uncommit",
			adendum_id: adendum_id,
			iscommit: false,
		})

		frm.Inputs[_iscommit].value = false;
		frm.acceptChanges();
		updateStatusButton(self, frm, CurrentState, buttons, evt);
		$fgta5.MessageBox.info("Adendum berhasil diuncommit")
	} catch (err) {
		console.error(err)
		$fgta5.MessageBox.error(err.message);
	}
}


async function btnApprove_onClick(self, frm, CurrentState, buttons, evt) {
	// console.log("approve geys")
	const adendum_id = frm.Inputs[_adendum_id].value;

	try {
		const url = "adendum/execute";
		const result = await Module.apiCall(url, {
			fnName: "approve",
			adendum_id: adendum_id,
			isapprove: true,
		});

		frm.Inputs[_isapprove].value = true;
		frm.acceptChanges();
		updateStatusButton(self, frm, CurrentState, buttons, evt);
		$fgta5.MessageBox.info("Adendum berhasil diapprove");
	} catch (err) {
		console.error(err);
		$fgta5.MessageBox.error(err.message);
	}
}

async function btnUnapprove_onClick(self, frm, CurrentState, buttons, evt) {
	// console.log("unapprove geys")
	const adendum_id = frm.Inputs[_adendum_id].value;

	try {
		const url = "adendum/execute";
		const result = await Module.apiCall(url, {
			fnName: "unapprove",
			adendum_id: adendum_id,
			isapprove: false,
		});

		frm.Inputs[_isapprove].value = false;
		frm.acceptChanges();
		updateStatusButton(self, frm, CurrentState, buttons, evt);
		$fgta5.MessageBox.info("Adendum berhasil diunapprove");
	} catch (err) {
		console.error(err);
		$fgta5.MessageBox.error(err.message);
	}
}


export function setupActionButtonEvent(self, frm, CurrentState, buttons) {
	const onView = Context.variance == VIEW_VARIANCE
	CurrentState.Actions.newdata.suspend(onView)
	CurrentState.Actions.edit.suspend(onView)

	CurrentState.Actions.commit.addEventListener("click", (evt) => {
		btnCommit_onClick(self, frm, CurrentState, buttons, evt);
	});

	CurrentState.Actions.uncommit.addEventListener("click", (evt) => {
		btnUncommit_onClick(self, frm, CurrentState, buttons, evt);
	});

	CurrentState.Actions.approve.addEventListener("click", (evt) => {
		btnApprove_onClick(self, frm, CurrentState, buttons, evt);
	});

	CurrentState.Actions.unapprove.addEventListener("click", (evt) => {
		btnUnapprove_onClick(self, frm, CurrentState, buttons, evt);
	});
}

export async function adendumHeaderEdit_formOpened(self, frm, CurrentState) {
	const data = frm.getOriginalData();

	const commitby = document.getElementById("fRecord-section-commitby");
	const commitdate = document.getElementById("fRecord-section-commitdate");
	const approveby = document.getElementById("fRecord-section-approveby");
	const approvedate = document.getElementById("fRecord-section-approvedate");

	commitby.innerHTML = data.commitby;
	commitdate.innerHTML = data.commitdate;
	approveby.innerHTML = data.approveby;
	approvedate.innerHTML = data.approvedate;

	updateStatusButton(self, frm, CurrentState);

}

// export async function adendumHeaderEdit_init(self, CurrentState) {
// 	const frm = self.Modules.adendumHeaderEdit.getHeaderForm()
// 	const adendum_id = frm.Inputs[_adendum_id]
// 	const datestart = frm.Inputs[_datestart]
// 	const dateend = frm.Inputs[_dateend]

// 	adendum_id.addEventListener("selected", async (evt) => {
// 		console.log("EVT logs", evt)
// 		const item = evt.detail.selectedData || evt.detail.row || evt.detail.data
// 		if (item) {
// 			if (datestart && item.adendum_datestart) datestart.value = item.ad	endum_datestart
// 			if (dateend && item.adendum_dateend) dateend.value = item.adendum_dateend
// 		}
// 	})
// }


export async function obj_agreement_id_selected(self, obj_agreement_id, frm, evt) {
	// console.log("EVT logs", evt)
	const item = evt.detail.selectedData || evt.detail.row || evt.detail.data

	if (item) {
		const datestart = frm.Inputs[_datestart]
		const dateend = frm.Inputs[_dateend]

		let startDate = item.agreement_datestart
		let endDate = item.agreement_dateend

		try {
			// Cek apakah ada Adendum sebelumnya yang sudah di-approve
			const result = await Module.apiCall('adendum/header-list', {
				criteria: {
					agreement_id: item.agreement_id,
					isapprove: true
				},
				sort: { adendum_seq: 'DESC', adendum_id: 'DESC' },
				limit: 1
			})

			if (result?.data?.length > 0) {
				const prevAdendum = result.data[0]
				if (prevAdendum.adendum_datestart) startDate = prevAdendum.adendum_datestart
				if (prevAdendum.adendum_dateend) endDate = prevAdendum.adendum_dateend
			}
		} catch (err) {
			console.error("Gagal mengambil adendum terbaru:", err)
		}

		if (datestart && startDate) datestart.value = startDate
		if (dateend && endDate) dateend.value = endDate
	}

	// try {
	// 	const detailMargin = await Module.apiCall('adendum/margin-list', {
	// 		criteria: {
	// 			adendum_id: item.adendum_id
	// 		}
	// 	})
	// 	console.log("detail Margin", detailMargin)
	// 	const detailBrand = await Module.apiCall('adendum/brand-list', {
	// 		criteria: {
	// 			adendum_id: item.adendum_id
	// 		}
	// 	})
	// 	console.log("detail Brand", detailBrand)
	// } catch (error) {
	// 	console.error(error)
	// }

	// frm.acceptChanges()

}

export const extenderMargin = {
	obj_marginrange_id_selected(self, obj_marginrange_id, frm, evt) {
		const item = evt.detail.selectedData || evt.detail.row || evt.detail.data
		if (item) {
			const obj_marginrange_start = frm.Inputs['adendumMarginEdit-obj_marginrange_start']
			const obj_marginrange_end = frm.Inputs['adendumMarginEdit-obj_marginrange_end']

			if (obj_marginrange_start) obj_marginrange_start.value = item.marginrange_start
			if (obj_marginrange_end) obj_marginrange_end.value = item.marginrange_end
		}
	}
}

// export const extenderBrand = {
// 	async obj_brand_id_selecting_criteria(self, obj_brand_id, frm, criteria, sort, evt) {
// 		const frmHeader = evt.detail.CurrentState.getHeaderForm()
// 		const agreement_id = frmHeader.Inputs['adendumHeaderEdit-obj_agreement_id']?.value
// 		if (!agreement_id) return

// 		const result = await Module.apiCall('agreement/header-open', { id: agreement_id })
// 		if (result?.partner_id) {
// 			criteria.partner_id = result.partner_id
// 		}
// 	}
// }

export async function adendumHeaderEdit_dataSaving(self, dataToSave, frm, args) {
	const startDate = frm.Inputs[_datestart].value
	const endDate = frm.Inputs[_dateend].value

	if (startDate > endDate) {
		args.cancelSave = true;
		$fgta5.MessageBox.error("startDate tidak boleh lebih besar dari endDate");

	}
}