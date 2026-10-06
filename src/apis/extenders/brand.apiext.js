export async function headerListCriteria(self, db, searchMap, criteria, sort, columns, args) {
    searchMap.partner_id = 'partner_id = ${partner_id}'
}