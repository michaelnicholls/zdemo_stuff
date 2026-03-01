@EndUserText.label: 'collect date adjustmanets'
define abstract entity zmn_date_adjust
 
{
    @EndUserText.label: 'Specific date range'
    @Consumption.valueHelpDefinition: [{ entity: {name: 'ZMN_DATE_RANGE_VH', element: 'Value' }}]
    range : zmn_date_range;
    @EndUserText.label: 'Days to adjust start date'
    start_adjust : abap.int4;
   @EndUserText.label: 'Days to adjust end date'
    end_adjust : abap.int4;
    
}
