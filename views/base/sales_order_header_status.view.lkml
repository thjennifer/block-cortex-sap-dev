view: sales_order_header_status {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.SalesOrderHeaderStatus` ;;

  dimension: at_least_one_of_id_items_not_yet_complete_on_hold_hdals {
    type: string
    description: "Pos. Hold"
    sql: ${TABLE}.AtLeastOneOfIdItemsNotYetCompleteOnHold_HDALS ;;
  }
  dimension: billing_block_status_fsstk {
    type: string
    description: "Overall block status"
    sql: ${TABLE}.BillingBlockStatus_FSSTK ;;
  }
  dimension: billing_incompletion_status_all_items_uvfas {
    type: string
    description: "Item billing data"
    sql: ${TABLE}.BillingIncompletionStatusAllItems_UVFAS ;;
  }
  dimension: billing_incompletion_status_header_uvfak {
    type: string
    description: "Header billing data"
    sql: ${TABLE}.BillingIncompletionStatusHeader_UVFAK ;;
  }
  dimension: billing_status_fkstk {
    type: string
    description: "Billing status"
    sql: ${TABLE}.BillingStatus_FKSTK ;;
  }
  dimension: billing_totals_status_for_intercompany_billing_fkivk {
    type: string
    description: "Totals status"
    sql: ${TABLE}.BillingTotalsStatusForIntercompanyBilling_FKIVK ;;
  }
  dimension_group: changed_on_aedat {
    type: time
    description: "Changed On"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ChangedOn_AEDAT ;;
  }
  dimension: client_mandt {
    type: string
    description: "Client (Mandant)"
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: confirmation_status_bestk {
    type: string
    description: "Confirmed"
    sql: ${TABLE}.ConfirmationStatus_BESTK ;;
  }
  dimension: confirmation_status_for_ale_costa {
    type: string
    description: "Confirmation status"
    sql: ${TABLE}.ConfirmationStatusForAle_COSTA ;;
  }
  dimension: credit_check_data_is_obsolete_cmpsm {
    type: string
    description: "Obsolete credit data"
    sql: ${TABLE}.CreditCheckDataIsObsolete_CMPSM ;;
  }
  dimension: custmer_reserves4_header_status_uvk04 {
    type: string
    description: "Header reserves 4"
    sql: ${TABLE}.CustmerReserves4HeaderStatus_UVK04 ;;
  }
  dimension: customer_reserves1_header_status_uvk01 {
    type: string
    description: "Header reserves 1"
    sql: ${TABLE}.CustomerReserves1HeaderStatus_UVK01 ;;
  }
  dimension: customer_reserves1_sum_of_all_items_uvs01 {
    type: string
    description: "Total reserves 1"
    sql: ${TABLE}.CustomerReserves1SumOfAllItems_UVS01 ;;
  }
  dimension: customer_reserves2_header_status_uvk02 {
    type: string
    description: "Header reserves 2"
    sql: ${TABLE}.CustomerReserves2HeaderStatus_UVK02 ;;
  }
  dimension: customer_reserves2_sum_of_all_items_uvs02 {
    type: string
    description: "Total reserves 2"
    sql: ${TABLE}.CustomerReserves2SumOfAllItems_UVS02 ;;
  }
  dimension: customer_reserves3_header_status_uvk03 {
    type: string
    description: "Header reserves 3"
    sql: ${TABLE}.CustomerReserves3HeaderStatus_UVK03 ;;
  }
  dimension: customer_reserves3_sum_of_all_items_uvs03 {
    type: string
    description: "Total reserves 3"
    sql: ${TABLE}.CustomerReserves3SumOfAllItems_UVS03 ;;
  }
  dimension: customer_reserves4_sum_of_all_items_uvs04 {
    type: string
    description: "Total reserves 4"
    sql: ${TABLE}.CustomerReserves4SumOfAllItems_UVS04 ;;
  }
  dimension: customer_reserves5_header_status_uvk05 {
    type: string
    description: "Header reserves 5"
    sql: ${TABLE}.CustomerReserves5HeaderStatus_UVK05 ;;
  }
  dimension: customer_reserves5_sum_of_all_items_uvs05 {
    type: string
    description: "Total reserves 5"
    sql: ${TABLE}.CustomerReserves5SumOfAllItems_UVS05 ;;
  }
  dimension: delay_status_dcstk {
    type: string
    description: "Delay status"
    sql: ${TABLE}.DelayStatus_DCSTK ;;
  }
  dimension: delivery_incompletion_status_all_items_uvvls {
    type: string
    description: "Item delivery data"
    sql: ${TABLE}.DeliveryIncompletionStatusAllItems_UVVLS ;;
  }
  dimension: delivery_incompletion_status_header_uvvlk {
    type: string
    description: "Header delivery data"
    sql: ${TABLE}.DeliveryIncompletionStatusHeader_UVVLK ;;
  }
  dimension: delivery_status_lfstk {
    type: string
    description: "Delivery status"
    sql: ${TABLE}.DeliveryStatus_LFSTK ;;
  }
  dimension: distribution_status_decentralized_warehouse_processing_vlstk {
    type: string
    description: "Status Decent. Whse"
    sql: ${TABLE}.DistributionStatusDecentralizedWarehouseProcessing_VLSTK ;;
  }
  dimension: document_category_vbtyp {
    type: string
    description: "SD document categ."
    sql: ${TABLE}.DocumentCategory_VBTYP ;;
  }
  dimension: extension_of_sd_document_category_vbtyp_ext {
    type: string
    description: "Doc. Cat. Extension"
    sql: ${TABLE}.ExtensionOfSdDocumentCategory_VBTYP_EXT ;;
  }
  dimension: handling_unit_placed_in_stock_vestk {
    type: string
    description: "HU placed in stock"
    sql: ${TABLE}.HandlingUnitPlacedInStock_VESTK ;;
  }
  dimension: header_incomplete_status_for_packaging_uvpak {
    type: string
    description: "Head.data packaging"
    sql: ${TABLE}.HeaderIncompleteStatusForPackaging_UVPAK ;;
  }
  dimension: header_incomplete_status_for_picking_putaway_uvpik {
    type: string
    description: "Head. data picking/putaway"
    sql: ${TABLE}.HeaderIncompleteStatusForPickingPutaway_UVPIK ;;
  }
  dimension: inbound_delivery_header_not_yet_complete_on_hold_hdall {
    type: string
    description: "On Hold"
    sql: ${TABLE}.InboundDeliveryHeaderNotYetCompleteOnHold_HDALL ;;
  }
  dimension: incompletion_status_all_items_uvals {
    type: string
    description: "Item Data"
    sql: ${TABLE}.IncompletionStatusAllItems_UVALS ;;
  }
  dimension: incompletion_status_header_uvall {
    type: string
    description: "Header data"
    sql: ${TABLE}.IncompletionStatusHeader_UVALL ;;
  }
  dimension: indicator_document_preselected_for_archiving_block {
    type: string
    description: "Indicator Document Preselected For Archiving"
    sql: ${TABLE}.IndicatorDocumentPreselectedForArchiving_BLOCK ;;
  }
  dimension: invoice_list_status_of_billing_document_relik {
    type: string
    description: "Inv.list status"
    sql: ${TABLE}.InvoiceListStatusOfBillingDocument_RELIK ;;
  }
  dimension: manual_completion_of_contract_manek {
    type: string
    description: "Manual Completion of Contract"
    sql: ${TABLE}.ManualCompletionOfContract_MANEK ;;
  }
  dimension: order_related_billing_status_all_items_fksak {
    type: string
    description: "Bill.Stat.Order-Rel."
    sql: ${TABLE}.OrderRelatedBillingStatusAllItems_FKSAK ;;
  }
  dimension: overall_allocation_status_sales_document_header_fsh_ar_stat_hdr {
    type: string
    description: "ARun Status at Header"
    sql: ${TABLE}.OverallAllocationStatusSalesDocumentHeader_FSH_AR_STAT_HDR ;;
  }
  dimension: overall_block_status_header_spstg {
    type: string
    description: "Overall blkd status"
    sql: ${TABLE}.OverallBlockStatusHeader_SPSTG ;;
  }
  dimension: overall_delivery_block_status_all_items_lsstk {
    type: string
    description: "Over. dlv. blk stat."
    sql: ${TABLE}.OverallDeliveryBlockStatusAllItems_LSSTK ;;
  }
  dimension: overall_delivery_status_lfgsk {
    type: string
    description: "Overall dlv.status"
    sql: ${TABLE}.OverallDeliveryStatus_LFGSK ;;
  }
  dimension: overall_packing_status_of_all_items_pkstk {
    type: string
    description: "Packing status"
    sql: ${TABLE}.OverallPackingStatusOfAllItems_PKSTK ;;
  }
  dimension: overall_picking_putaway_status_kostk {
    type: string
    description: "Overall pick.status"
    sql: ${TABLE}.OverallPickingPutawayStatus_KOSTK ;;
  }
  dimension: overall_processing_status_gbstk {
    type: string
    description: "Overall status"
    sql: ${TABLE}.OverallProcessingStatus_GBSTK ;;
  }
  dimension: overall_reference_status_all_items_rfgsk {
    type: string
    description: "Total reference stat"
    sql: ${TABLE}.OverallReferenceStatusAllItems_RFGSK ;;
  }
  dimension: overall_status_of_credit_checks_cmgst {
    type: string
    description: "Overall CreditStatus"
    sql: ${TABLE}.OverallStatusOfCreditChecks_CMGST ;;
  }
  dimension: overall_status_of_warehouse_management_activities_lvstk {
    type: string
    description: "Overall WM status"
    sql: ${TABLE}.OverallStatusOfWarehouseManagementActivities_LVSTK ;;
  }
  dimension: pod_status_on_header_level_pdstk {
    type: string
    description: "Proof of delivery status"
    sql: ${TABLE}.PodStatusOnHeaderLevel_PDSTK ;;
  }
  dimension: post_header_incomplete_status_for_goods_movement_uvwak {
    type: string
    description: "Head. data goods mvmt"
    sql: ${TABLE}.PostHeaderIncompleteStatusForGoodsMovement_UVWAK ;;
  }
  dimension: posting_status_of_billing_document_buchk {
    type: string
    description: "Posting Status"
    sql: ${TABLE}.PostingStatusOfBillingDocument_BUCHK ;;
  }
  dimension: pricing_incompletion_status_all_items_uvprs {
    type: string
    description: "Pricing"
    sql: ${TABLE}.PricingIncompletionStatusAllItems_UVPRS ;;
  }
  dimension: reference_document_header_status_rfstk {
    type: string
    description: "Reference status"
    sql: ${TABLE}.ReferenceDocumentHeaderStatus_RFSTK ;;
  }
  dimension: rejections_status_abstk {
    type: string
    description: "Rejection status"
    sql: ${TABLE}.RejectionsStatus_ABSTK ;;
  }
  dimension: revenue_determination_status_rrsta {
    type: string
    description: "Rev. determ. status"
    sql: ${TABLE}.RevenueDeterminationStatus_RRSTA ;;
  }
  dimension: sales_document_vbeln {
    type: string
    description: "Sales Document"
    sql: ${TABLE}.SalesDocument_VBELN ;;
  }
  dimension: sap_release_saprl {
    type: string
    description: "SAP Release"
    sql: ${TABLE}.SapRelease_SAPRL ;;
  }
  dimension: sd_document_object_vbobj {
    type: string
    description: "Document object"
    sql: ${TABLE}.SdDocumentObject_VBOBJ ;;
  }
  dimension: status_funds_management_fmstk {
    type: string
    description: "Status Funds Management"
    sql: ${TABLE}.StatusFundsManagement_FMSTK ;;
  }
  dimension: status_of_credit_check_against_customer_review_date_cmpse {
    type: string
    description: "Customer review date"
    sql: ${TABLE}.StatusOfCreditCheckAgainstCustomerReviewDate_CMPSE ;;
  }
  dimension: status_of_credit_check_against_export_credit_insurance_cmpsj {
    type: string
    description: "Expt cred. insurance"
    sql: ${TABLE}.StatusOfCreditCheckAgainstExportCreditInsurance_CMPSJ ;;
  }
  dimension: status_of_credit_check_against_financial_document_cmpsi {
    type: string
    description: "Financial document"
    sql: ${TABLE}.StatusOfCreditCheckAgainstFinancialDocument_CMPSI ;;
  }
  dimension: status_of_credit_check_against_highest_dunning_level_cmpsh {
    type: string
    description: "Max.dunning level"
    sql: ${TABLE}.StatusOfCreditCheckAgainstHighestDunningLevel_CMPSH ;;
  }
  dimension: status_of_credit_check_against_maximum_document_value_cmpsc {
    type: string
    description: "Maximum value"
    sql: ${TABLE}.StatusOfCreditCheckAgainstMaximumDocumentValue_CMPSC ;;
  }
  dimension: status_of_credit_check_against_oldest_open_items_cmpsg {
    type: string
    description: "Oldest open items"
    sql: ${TABLE}.StatusOfCreditCheckAgainstOldestOpenItems_CMPSG ;;
  }
  dimension: status_of_credit_check_against_open_items_due_cmpsf {
    type: string
    description: "Overdue open items"
    sql: ${TABLE}.StatusOfCreditCheckAgainstOpenItemsDue_CMPSF ;;
  }
  dimension: status_of_credit_check_against_payment_card_authorization_cmpsk {
    type: string
    description: "Payment card"
    sql: ${TABLE}.StatusOfCreditCheckAgainstPaymentCardAuthorization_CMPSK ;;
  }
  dimension: status_of_credit_check_against_terms_of_payment_cmpsd {
    type: string
    description: "Terms of payment"
    sql: ${TABLE}.StatusOfCreditCheckAgainstTermsOfPayment_CMPSD ;;
  }
  dimension: status_of_credit_check_for_customer_reserve1_cmps0 {
    type: string
    description: "Reserve"
    sql: ${TABLE}.StatusOfCreditCheckForCustomerReserve1_CMPS0 ;;
  }
  dimension: status_of_credit_check_for_customer_reserve2_cmps1 {
    type: string
    description: "Reserve"
    sql: ${TABLE}.StatusOfCreditCheckForCustomerReserve2_CMPS1 ;;
  }
  dimension: status_of_credit_check_for_customer_reserve3_cmps2 {
    type: string
    description: "Reserve"
    sql: ${TABLE}.StatusOfCreditCheckForCustomerReserve3_CMPS2 ;;
  }
  dimension: status_of_credit_check_of_reserves4_cmpsl {
    type: string
    description: "Reserve"
    sql: ${TABLE}.StatusOfCreditCheckOfReserves4_CMPSL ;;
  }
  dimension: status_of_credit_check_sap_credit_management_cmps_cm {
    type: string
    description: "SAP Credit Management"
    sql: ${TABLE}.StatusOfCreditCheckSapCreditManagement_CMPS_CM ;;
  }
  dimension: status_of_dynamic_credit_limit_check_in_the_credit_horizon_cmpsb {
    type: string
    description: "Dynamic check"
    sql: ${TABLE}.StatusOfDynamicCreditLimitCheckInTheCreditHorizon_CMPSB ;;
  }
  dimension: status_of_pick_confirmation_koquk {
    type: string
    description: "Pick confirmation"
    sql: ${TABLE}.StatusOfPickConfirmation_KOQUK ;;
  }
  dimension: status_of_static_credit_limit_check_cmpsa {
    type: string
    description: "Static check"
    sql: ${TABLE}.StatusOfStaticCreditLimitCheck_CMPSA ;;
  }
  dimension: status_of_technical_error_sap_credit_management_cmps_te {
    type: string
    description: "Credit Mgmt TE Status"
    sql: ${TABLE}.StatusOfTechnicalErrorSapCreditManagement_CMPS_TE ;;
  }
  dimension: temporary_inbound_delivery_spe_tmpid {
    type: string
    description: "Temp Inb."
    sql: ${TABLE}.TemporaryInboundDelivery_SPE_TMPID ;;
  }
  dimension: total_goods_movement_status_wbstk {
    type: string
    description: "Total gds mvt stat."
    sql: ${TABLE}.TotalGoodsMovementStatus_WBSTK ;;
  }
  dimension: total_incomplete_status_of_all_items_post_goods_movement_uvwas {
    type: string
    description: "Item data: goods mvmt"
    sql: ${TABLE}.TotalIncompleteStatusOfAllItemsPostGoodsMovement_UVWAS ;;
  }
  dimension: totals_incomplete_status_for_all_items_packaging_uvpas {
    type: string
    description: "It.data packaging"
    sql: ${TABLE}.TotalsIncompleteStatusForAllItemsPackaging_UVPAS ;;
  }
  dimension: totals_incomplete_status_for_all_items_picking_uvpis {
    type: string
    description: "It.data picking/putaway"
    sql: ${TABLE}.TotalsIncompleteStatusForAllItemsPicking_UVPIS ;;
  }
  dimension: transportation_planning_status_header_trsta {
    type: string
    description: "Trns.plan.status"
    sql: ${TABLE}.TransportationPlanningStatusHeader_TRSTA ;;
  }
  dimension: unused_uvgek {
    type: string
    description: "Head.data dang.goods"
    sql: ${TABLE}.Unused_UVGEK ;;
  }
  measure: count {
    type: count
  }
}
