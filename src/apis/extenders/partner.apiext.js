export async function headerListCriteria(self, db, searchMap, criteria, sort, columns, args) {
	searchMap.partner_isdisabled = 'partner_isdisabled = ${partner_isdisabled}'
}
