// export async function headerListCriteria(self, db, searchMap, criteria, sort, columns, args) {
//     args.tablename = `(
//         SELECT
//             agr.agreement_id AS reporting_id,
//             agr.agreement_id AS agreement_id,
//             p.partner_name,
//             s.site_name,
//             COALESCE(adn.adendum_datestart, agr.agreement_datestart) AS agreement_datestart,
//             COALESCE(adn.adendum_dateend,   agr.agreement_dateend)   AS agreement_dateend,
//             CASE
//                 WHEN COALESCE(adn.adendum_dateend, agr.agreement_dateend) < CURRENT_DATE
//                     THEN 'KEDALUWARSA'
//                 WHEN COALESCE(adn.adendum_dateend, agr.agreement_dateend) <= CURRENT_DATE + INTERVAL '7 days'
//                     THEN 'AKAN KEDALUWARSA'
//                 ELSE 'AKTIF'
//             END AS reporting_status
//         FROM public.agreement agr
//         LEFT JOIN public.partner p ON p.partner_id = agr.partner_id
//         LEFT JOIN public.site s ON s.site_id = agr.site_id
//         LEFT JOIN LATERAL (
//             SELECT adendum_datestart, adendum_dateend
//             FROM public.adendum
//             WHERE agreement_id = agr.agreement_id
//               AND isapprove = true
//             ORDER BY approvedate DESC, adendum_id DESC
//             LIMIT 1
//         ) adn ON true
//         WHERE agr.isapprove = true
//     ) AS t`
// }