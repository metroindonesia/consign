export async function headerListCriteria(self, db, searchMap, criteria, sort, columns, args) {
	searchMap.partner_id = 'partner_id = ${partner_id}'
	searchMap.agreement_id = 'partner_id = (SELECT partner_id FROM public.agreement WHERE agreement_id = ${agreement_id})'
	searchMap.brand_isdisabled = 'brand_isdisabled = ${brand_isdisabled}'
}