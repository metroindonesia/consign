import Context from './partner-context.mjs'


export const extenderHeader = null



const VIEW_VARIANCE = 'view'

export async function init(self, args) {
	console.log('initializing partnerExtender ...')

	// tambahkan extender inisiasi module partner


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

// export function partnerHeaderEdit_isEditDisabled(self, data) {
// 	if (data.partner_isdisabled) {
// 		return true
// 	}
// 	return false
// }

export function headerList_addTableEvents(self, tbl) {
	tbl.addEventListener("rowrender", (evt) => {
		console.log(evt.detail)
		console.log(evt.detail.args.data)
		const { partner_isdisabled } = evt.detail.args.data
		if (partner_isdisabled) {
			evt.detail.tr.setAttribute("data-isdisabled", true)
		} else {
			evt.detail.tr.removeAttribute("data-isdisabled")
		}
	})
}

export function setupActionButtonEvent(self, frm, CurrentState, buttons) {
	const onView = Context.variance == VIEW_VARIANCE
	CurrentState.Actions.newdata.suspend(onView)
	CurrentState.Actions.edit.suspend(onView)
}