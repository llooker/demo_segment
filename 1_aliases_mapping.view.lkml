view: aliases_mapping {
  derived_table: {
    sql_trigger_value: select current_date ;;
    sortkeys: ["looker_visitor_id", "alias"]
    distribution: "alias"
    sql: with
      all_mappings as (
        select anonymous_id
        , user_id
        , received_at as received_at
        from segment.tracks

        union

        select user_id
          , null
          , received_at
        from segment.tracks
      )

      select
        distinct anonymous_id as alias
        , first_value(user_id ignore nulls) OVER ()

        , coalesce(first_value(user_id ignore nulls)
        over(
          partition by anonymous_id
          order by received_at
          rows between unbounded preceding and unbounded following),anonymous_id) as looker_visitor_id
      from all_mappings
       ;;
  }

  # Anonymous ID
  dimension: alias {
    primary_key: yes
    type: string
    sql: ${TABLE}.alias ;;
  }

  # User ID
  dimension: looker_visitor_id {
    type: string
    sql: ${TABLE}.looker_visitor_id ;;
  }
}
