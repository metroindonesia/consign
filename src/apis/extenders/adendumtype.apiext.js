export async function headerListCriteria(self, db, searchMap, criteria, sort, columns, args) {
	searchMap.adendumtype_isdisabled = 'adendumtype_isdisabled = ${adendumtype_isdisabled}'
}
