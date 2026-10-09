export async function headerListCriteria(self, db, searchMap, criteria, sort, columns, args) {
	searchMap.site_isdisabled = 'site_isdisabled = ${site_isdisabled}'
}
