import Context from './brand-context.mjs'


export const extenderHeader = {
	obj_partner_id_selecting_criteria(self, obj_partner_id, frm, criteria, sort, evt) {
		criteria.partner_isdisabled = false
	}
}



const VIEW_VARIANCE = 'view'

export async function init(self, args) {
	console.log('initializing brandExtender ...')

	// tambahkan extender inisiasi module brand


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

export function headerList_addTableEvents(self, tbl) {
	tbl.addEventListener('rowrender', (evt) => {
		// console.log("evt.detail", evt.detail)
		// console.log("evt.detail.args.data", evt.detail.args.data)

		const { brand_isdisabled } = evt.detail.args.data
		if (brand_isdisabled) {
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