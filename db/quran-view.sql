CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `newschema`.`quran-view` AS
    SELECT 
        `newschema`.`quran`.`english` AS `english`,
        `newschema`.`quran`.`token` AS `token`,
        `newschema`.`quran`.`verse` AS `verse`,
        `newschema`.`quran`.`chapter` AS `chapter`,
        `newschema`.`quran`.`root_word` AS `root_word`,
        `newschema`.`quran`.`buckwalter` AS `buckwalter`,
        `newschema`.`quran_detail`.`type` AS `type`,
        `newschema`.`quran_detail`.`type_detail` AS `type_detail`,
        `newschema`.`verse`.`verse_text` AS `verse_text`,
        `newschema`.`quran_detail`.`id` AS `id`
    FROM
        ((`newschema`.`quran`
        LEFT JOIN `newschema`.`quran_detail` ON (`newschema`.`quran`.`id` = `newschema`.`quran_detail`.`quran_id`))
        LEFT JOIN `newschema`.`verse` ON (`newschema`.`quran`.`verse` = `newschema`.`verse`.`verse`
            AND `newschema`.`quran`.`chapter` = `newschema`.`verse`.`chapter`))
    ORDER BY `newschema`.`quran`.`chapter` , `newschema`.`quran`.`verse` , `newschema`.`quran`.`token`