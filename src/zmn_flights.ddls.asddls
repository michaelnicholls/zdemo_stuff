define view entity zmn_flights
  as select from sflight

  association to ZMN_BOOKINGS as _bookf
    on  sflight.carrid = _bookf.Carrid
    and sflight.connid = _bookf.Connid
    and sflight.fldate = _bookf.Fldate
    and _bookf.Class   = 'F'

  association to ZMN_BOOKINGS as _bookc
    on  sflight.carrid = _bookc.Carrid
    and sflight.connid = _bookc.Connid
    and sflight.fldate = _bookc.Fldate
    and _bookc.Class   = 'C'

  association to ZMN_BOOKINGS as _booky
    on  sflight.carrid = _booky.Carrid
    and sflight.connid = _booky.Connid
    and sflight.fldate = _booky.Fldate
    and _booky.Class   = 'Y'

  association to saplane      as _plane
    on _plane.planetype = sflight.planetype
 association to zmn_book_amount as _amount
    on sflight.carrid = _amount.Carrid
    and sflight.connid = _amount.Connid
    and sflight.fldate = _amount.Fldate

{
  key carrid                                                                        as Carrid,
  key connid                                                                        as Connid,
  key fldate                                                                        as Fldate,

      planetype                                                                     as Planetype,
      cast(coalesce(_bookf.bookings, 0) as s_socc_f)                                as seatsocc_F,
      cast(coalesce(_bookc.bookings, 0)  as s_socc_b)                               as seatsocc_B,
      cast(coalesce(_booky.bookings, 0) as s_seatsocc)                              as seatsocc,
      cast(_plane.seatsmax_b as s_smax_b)                                           as seatsmax_B,
      cast(_plane.seatsmax_f as s_smax_f)                                           as seatsmax_F,
      cast(_plane.seatsmax - (_plane.seatsmax_b + _plane.seatsmax_f) as s_seatsmax) as seatsmax,
       @Semantics.amount.currencyCode: 'currency'
      cast(_amount.Loccuram as s_sum) as paymentsum,
      cast(_amount.Loccurkey as s_currcode) as currency
}
