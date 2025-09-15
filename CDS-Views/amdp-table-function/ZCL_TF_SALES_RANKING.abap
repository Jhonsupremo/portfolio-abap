*&---------------------------------------------------------------------*
CLASS zcl_tf_sales_ranking DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS calculate_employee_performance
        FOR TABLE FUNCTION zsd_tf_sales_ranking.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_tf_sales_ranking IMPLEMENTATION.

  METHOD calculate_employee_performance BY DATABASE FUNCTION
                                        FOR HDB
                                        LANGUAGE SQLSCRIPT
                                        OPTIONS READ-ONLY
                                        USING  vbak vbap kna1 .

    declare lv_previous_year int := :p_year - 1;

     lt_current_sales =
     select
     h.mandt as Client,
     h.kunnr as Customer,
     k.name1 as Customer_Name,
     count( distinct h.vbeln ) as Total_Orders,
     sum( i.netwr ) as Total_amount,
     avg( i.netwr ) as Average_Order_Value
     from vbak as h
     inner join vbap as i on h.vbeln = i.vbeln
     inner join kna1 as k on h.kunnr = k.kunnr
     where  year( h.erdat ) = :p_year
     and  h.vkorg = :p_sales_org
     AND LEFT( h.erdat, 4 ) = :p_year
     group by  h.mandt, h.kunnr, k.name1;

*   Vendas do ano anterior para comparação

      lt_previous_sales =
      select
      h.kunnr as Customer,
      sum( i.netwr ) as previous_amount
      from vbak as h
      inner join vbap as i on h.vbeln = i.vbeln
      wHERE h.vkorg = :p_sales_org
        AND LEFT(h.erdat, 4) = :lv_previous_year
        AND h.vbtyp = 'C'
       GROUP BY h.mandt, h.kunnr;

*    Análise final com ranking e categorização
 -- RETURN com tipos corretos
  RETURN select
      -- client : mandt; (CLNT 3)
      cast(c.client as char(3)) as client,

      -- customer : kunnr; (CHAR 10)
      cast(c.customer as char(10)) as customer,

      -- customer_name : name1; (CHAR 35)
      cast(c.customer_name as char(35)) as customer_name,

      -- total_sales : abap.dec(15,2); (decimal 15,2)
      cast(c.Total_Orders as decimal(15,2)) as total_sales,

      -- sales_rank : int4; (integer)
      cast(rank() OVER (ORDER BY c.Total_Orders desc) AS integer) as sales_rank,

      -- percentile : abap.dec(5,2); 8(decimal 5,2)
      cast(percent_rank() OVER (ORDER BY c.Total_Orders) * 100 as decimal(5,2)) as percentile,

      -- growth_rate : abap.dec(5,2); (decimal 5,2)
      cast(
        case
          WHEN p.previous_amount is null or p.previous_amount = 0 THEN 0.00
          ELSE ROUND(((c.Total_Orders - p.previous_amount) / p.previous_amount) * 100, 2)
        END AS decimal(5,2)
      ) as growth_rate,

      -- category : abap.char(10); (CHAR 10)
      CAST(
        CASE
          WHEN percent_rank() OVER (ORDER BY c.Total_Orders) >= 0.9 THEN 'VIP_PLAT'
          WHEN percent_rank() OVER (ORDER BY c.Total_Orders) >= 0.8 THEN 'VIP_GOLD'
          WHEN percent_rank() OVER (ORDER BY c.Total_Orders) >= 0.6 THEN 'PREMIUM'
          WHEN percent_rank() OVER (ORDER BY c.Total_Orders) >= 0.4 THEN 'STANDARD'
          ELSE 'BASIC'
        END AS CHAR(10)
      ) as category

    FROM :lt_current_sales as c
    LEFT JOIN :lt_previous_sales as p ON c.customer = p.customer
    WHERE c.Total_Orders > 0
    ORDER BY c.Total_Orders desc;


  endmethod.

ENDCLASS.
