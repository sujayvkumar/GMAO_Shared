esma_set_this ()

set (MODSRC
  m_ods.f90 m_roms.f90 m_odsmeta.f m_ods_structure.f m_ods_obsdiags.F90
  m_saber.f m_odsxsup.f90 m_Sndx.F90 m_ODS_Sample.f m_mraob.f90
  )

set (ODSSRC
  ods_cal2time.f  ods_cal2min.f
  ods_julian.f    ods_ncp_itoi4.f  ods_rget.f
  ods_caldat.f    ods_namemonth.f  ods_ncp_itor4.f  ods_scalei.f
  ods_case.f      ods_ncagtc.f     ods_ncp_rtoi1.f  ods_scaleirev.f
  ods_cget.f      ods_ncagti.f     ods_ncp_rtoi2.f  ods_scaler.f
  ods_checki.f    ods_ncagtr.f     ods_ncp_rtoi4.f  ods_scalerrev.f
  ods_checkr.f    ods_ncapti.f     ods_ncp_rtor4.f  ods_setparmc.f
  ods_coards.f    ods_ncaptr.f     ods_ncvgti.f     ods_setparmi.f
  ods_defwsp.f    ods_nccreate.f   ods_ncvgtr.f     ods_setparmr.f
  ods_file.f      ods_ncg_i1toi.f  ods_ncvpti.f     ods_strsearch.f
  ods_getattp.f   ods_ncg_i1tor.f  ods_ncvptr.f     ods_strsize.f
  ods_getc.f      ods_putc.f
  ods_ncvptc.f    ods_ncvgtc.f
  ods_geti.f      ods_ncg_i2toi.f  ods_ncvwsp.f     ods_time2cal.f
  ods_min2cal.f   ods_mraob.f
  ods_getlist.f   ods_ncg_i2tor.f  ods_nget.f       ods_type.f
  ods_getp.f      ods_ncg_i4toi.f  ods_nval.f       ods_updatep.f
  ods_getr.f      ods_ncg_i4tor.f  ods_parm.f       ods_valwsp.f
  ods_handle.f    ods_ncg_r4toi.f  ods_puti.f       ods_vartype.f
  ods_iget.f      ods_ncg_r4tor.f  ods_putlist.f    ods_verindex.f
  ods_imonth.f    ods_ncopen.f     ods_putr.f       ods_vertag.f
  ods_ncp_itoi1.f ods_readp.f      ods_writep.f
  ods_julhr.f     ods_ncp_itoi2.f  ods_resetp.f     odsnxtime.f
  ods_eget.f      ods_dcget.f      ods_dconv.f      ods_dcscan.f
  ods_drad.f      ods_dsbuv.f      ods_dpcp.f       ods_rmdupl.f
  ods_do3lev.f
  )

esma_add_library (${this}
  SRCS ${MODSRC} ${ODSSRC}
  DEPENDENCIES GMAO_mpeu
  INCLUDES ${INC_NETCDF}
  )

if (EXTENDED_SOURCE)
  set_target_properties (${this} PROPERTIES COMPILE_FLAGS ${EXTENDED_SOURCE})
endif()

