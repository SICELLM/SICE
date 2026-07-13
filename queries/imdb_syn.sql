EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=172968;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<3 AND t.production_year=2008 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<3194645;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=1742124 AND ci.role_id>2 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>0 AND ci.role_id=2 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2000 AND mc.company_id=160 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<77942 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<71692;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>681261 AND ci.role_id>1 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<9749 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=43268 AND mk.keyword_id<2560;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1278953 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<1029;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND mc.company_id>83328 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=1994 AND mc.company_id>50785 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<80833 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2945474 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>2237;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>4 AND t.production_year<2004 AND mc.company_id<5363;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2013 AND mc.company_id<239 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=62398;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<213849 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>284738;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<80578;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1978 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<4 AND t.production_year=1966 AND mc.company_id<7563 AND mc.company_type_id=2 AND mi.info_type_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1436321;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=2610477 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=43276 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>1127 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<1996;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=2008 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND ci.person_id<2769705 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>40491;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2007 AND mk.keyword_id>19735;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=100 AND mk.keyword_id>430;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.role_id=4 AND mk.keyword_id=2830;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>19819;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2011 AND mk.keyword_id=4755;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<11393 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1965 AND mi.info_type_id<90;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>3 AND t.production_year<2011 AND mi.info_type_id<18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>213;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=27 AND mc.company_type_id=1 AND ci.person_id<1265390;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>868 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2006 AND ci.person_id>473664 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<4 AND t.production_year>1910 AND mc.company_id>1461 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=1995 AND mc.company_id>4436 AND mk.keyword_id>12216;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<4 AND t.production_year<1961 AND mc.company_id>17484 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<1959;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=2000 AND ci.person_id>1066564 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1961 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=1994 AND mi.info_type_id>17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=3587349;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>4 AND t.production_year<2005 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>2678609 AND ci.role_id=2 AND mk.keyword_id<1776;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2043231 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<11373;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>2869415 AND ci.role_id>9 AND mk.keyword_id<2980;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=34013;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>26476;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND mc.company_id=3232 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1256579;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2012 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>4 AND t.production_year=2009 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=1993;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=2007 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<1990 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id=2420177;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2008 AND ci.role_id=1 AND mk.keyword_id<73;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<5374;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND mc.company_id>817 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_type_id>1 AND ci.person_id<394300;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>51095;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>4 AND t.production_year>1966;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=1899 AND mk.keyword_id<398;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>2010 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=2007 AND mk.keyword_id=3256;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<1965 AND mc.company_id>1237;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=1974 AND ci.person_id<3019402 AND ci.role_id>1 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=32057 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1931896 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>2 AND t.production_year<1965;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=1996 AND mc.company_id<11695 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=90962 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=892909 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<39210;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>2006;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=1998 AND mk.keyword_id>16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>4434 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id=527;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<511906 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<1007;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<69853;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=88122;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=1962 AND ci.person_id<1154998 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2279717;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<43106;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=14267;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>1144755 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>1980 AND mk.keyword_id>13634;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<492499 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<145 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>87517 AND mk.keyword_id=9182;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2626616 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND mc.company_id<11379;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1987 AND mk.keyword_id=2651;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<814499 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1259307 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2010 AND mc.company_id>33938 AND ci.person_id<1550792;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>10116;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1123232;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2002 AND mk.keyword_id>870;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>512 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>1970;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id<2697;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=625934 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>112526;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND mk.keyword_id<1002;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<3322691 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<770925 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=6123;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mi.info_type_id>16 AND mk.keyword_id<11728;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<2566764 AND ci.role_id=1 AND mk.keyword_id<2849;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year<2009 AND ci.person_id>1835252 AND ci.role_id<10 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3150139;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1128359;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>2289369 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=18692;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1993 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>2231;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=14805;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year>2008 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>2005 AND mc.company_type_id<2 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND ci.person_id<1139092;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<19691 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year=1996;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2011 AND mi.info_type_id>18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>1998;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=14074;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<969025 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<57549 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id<2 AND mk.keyword_id<96739;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<2006 AND ci.role_id=6 AND mk.keyword_id=13940;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>27699 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=8629;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>99727;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=71485;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=2 AND mi.info_type_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1881200;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=100 AND mk.keyword_id<117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>791670;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<31065;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>6854;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>1959;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1747522 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<4 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1341245 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<4 AND t.production_year=2005;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<286848;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id>1366207;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>1 AND mc.company_id>68 AND mc.company_type_id=1 AND ci.person_id<1673909;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2004 AND mi.info_type_id>98;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1326433;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year<1994 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2011 AND mc.company_id=846 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND mi.info_type_id=108;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id<100 AND mk.keyword_id<56903;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<2010 AND mi.info_type_id>6 AND mk.keyword_id=20330;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1822571 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>1913 AND ci.person_id<364441 AND mk.keyword_id<2276;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=2010 AND mc.company_id=76905 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year=2012 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2011 AND mi.info_type_id=8 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2007 AND mk.keyword_id<38085;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=1958 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1914 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1940 AND mk.keyword_id=36078;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND mi.info_type_id<12;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<34121;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<171 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>16691;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2012 AND ci.person_id<3297942;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>207995;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=78435;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2012 AND ci.person_id<1359374;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND mc.company_id>506;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<1878585 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<2011 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND mi.info_type_id=110 AND mk.keyword_id<8820;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id<7477;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<4519;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>1955 AND mc.company_id>4730;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>1043;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=3 AND mc.company_id=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<4 AND t.production_year<1910 AND mi.info_type_id>73;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2011 AND mc.company_id>111186 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3431631 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id=6087;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=99 AND mk.keyword_id<108021;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mi.info_type_id>1 AND mk.keyword_id>2632;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3287059 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year>2000 AND mi.info_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<2010 AND mi.info_type_id<6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>1312;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>23394;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=2008 AND ci.person_id>2318904 AND ci.role_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id<2970008;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=2 AND t.production_year<1981;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<2006 AND mc.company_id>1117 AND mc.company_type_id<2 AND ci.person_id<2835100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>2 AND t.production_year<1999;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>74824;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1991 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2012 AND mk.keyword_id=2488;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>2010 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>838300;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<1973 AND mi.info_type_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2009 AND mc.company_id>12065;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<4006715 AND ci.role_id<2 AND mk.keyword_id<1574;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>164180 AND mk.keyword_id>90308;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<3 AND t.production_year<1966;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>14227 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2006 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>3 AND t.production_year>2012;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year<2010 AND mc.company_id>10673 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>2013 AND ci.person_id>1093504 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=3508682;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=2 AND t.production_year<1951;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=2921;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id>16398;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2334390 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<503262 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year<1932 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=2 AND t.production_year>2004 AND mc.company_type_id=1 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=3 AND t.production_year>0 AND mi.info_type_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=4 AND t.production_year>2011 AND ci.person_id<2814404 AND ci.role_id>10 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>1143;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year>1926;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<1964;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<712149 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>914574 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>2008 AND ci.person_id<1232956 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>3 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2003 AND ci.person_id>2617999 AND ci.role_id<11;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=1984;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2012 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<2012 AND mi.info_type_id=3 AND mk.keyword_id>4333;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>39961;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>520;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year=1968;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2012 AND ci.person_id>2774432 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>215047 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id<382;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=3 AND t.production_year>1967 AND mc.company_id=27;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<2 AND t.production_year=2010;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2009 AND mk.keyword_id<844;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<3918294;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=784;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>179807 AND ci.person_id<1590332 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1996 AND mc.company_id<12594 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=1966 AND mc.company_id=475 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND mc.company_id>163179 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<2004 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>3451 AND mk.keyword_id=463;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id=15551;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=3 AND t.production_year<2006 AND mk.keyword_id>57;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>1960 AND mi.info_type_id<18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<2010 AND mi_idx.info_type_id<101 AND mk.keyword_id=613;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND ci.person_id>2382635 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2748717;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=2 AND t.production_year>1972 AND ci.person_id<2157530 AND mk.keyword_id<5622;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>798907 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<2004 AND mi_idx.info_type_id=99 AND mk.keyword_id>29318;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2010 AND mk.keyword_id<84;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<2924 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=1948 AND mk.keyword_id<82180;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=1684 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>11781 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1971 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id=25653 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<1999 AND mc.company_id>14695 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2012 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1971;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1921 AND mk.keyword_id=5537;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year<1996 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=21722;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>74220;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=2 AND t.production_year>1989;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id<12346;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2005 AND ci.person_id<2051263 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id<100 AND mk.keyword_id=21400;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>16359;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>7772 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2727553 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<1970 AND ci.person_id=1690420;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id<2849;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mi_idx.info_type_id>100 AND mk.keyword_id<5537;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mc.company_id>140038 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=2 AND t.production_year=1980 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=53797 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<3 AND t.production_year>2010;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1986 AND ci.person_id=3359169 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=26450 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<44130 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=2012 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=159356;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<355;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<6139;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>0 AND mc.company_id<661 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>2012 AND mc.company_id>12788 AND mc.company_type_id=2 AND mk.keyword_id=9980;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>13816 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<2011 AND mc.company_id>53326 AND ci.person_id>1111727;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>1997 AND mi.info_type_id>18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>225585;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1973 AND mk.keyword_id<2499;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1856563 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=1999;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=10357;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<3 AND t.production_year=2006;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<437596 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2003 AND ci.person_id<760114 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1963 AND mk.keyword_id=1878;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<3987;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id=192355;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id<101 AND mk.keyword_id>117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<2005 AND ci.person_id>2566289 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=1999 AND mk.keyword_id<117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2975038;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=6107;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>1720;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>38705;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<1037;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>28212;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>3 AND t.production_year=2008;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>2004 AND ci.role_id<9 AND mk.keyword_id<5654;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2006 AND ci.person_id<438540 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=1990;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>11685;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>3158886;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<675588;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>4 AND t.production_year<2003 AND ci.person_id<374943 AND ci.role_id<2 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2006 AND ci.person_id>3558046;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id>101 AND mk.keyword_id=13203;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND ci.person_id=2114770 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>1775489 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>4 AND t.production_year=2004;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<704 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1294691 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND ci.person_id=2411392 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>261619 AND ci.role_id=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<6 AND t.production_year=2007 AND ci.person_id<56790 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=48495;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3712293 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<2012 AND ci.person_id>2921629 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>3995415;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=4625 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id<3490049 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<4 AND t.production_year=2004 AND ci.person_id<627326 AND mk.keyword_id<7776;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2010 AND mi_idx.info_type_id>100 AND mk.keyword_id<13391;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1669396 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3169524;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=101 AND mk.keyword_id<11997;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>16339 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<2003 AND mk.keyword_id=4926;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND ci.person_id<1799274 AND ci.role_id<10 AND mk.keyword_id>12888;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=4 AND t.production_year<2007 AND mk.keyword_id=599;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1951 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id<6069;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<908593;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=6 AND t.production_year<2002 AND ci.person_id>2403322 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<262;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<24123;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<1965;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<894226 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=2 AND ci.person_id>2797869 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>9843;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=2009 AND mk.keyword_id<32550;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>1991 AND ci.person_id<3281297;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2010 AND mk.keyword_id<20875;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<2011 AND mk.keyword_id<5761;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=4776;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=1861;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>2008 AND mi.info_type_id=7 AND mk.keyword_id<13399;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2000 AND mk.keyword_id>18607;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year<2010;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<2012 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id>99 AND mk.keyword_id>11681;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>16192;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=2 AND t.production_year<1979;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<52025;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year<1985 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=2011 AND mk.keyword_id>7778;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=4 AND t.production_year<2011 AND mc.company_id>3139 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id>16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>2626123;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>44471;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>1807968 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=1976 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1022088 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2578472;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year=2001 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<1613;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>11264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2009 AND mk.keyword_id<51928;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>188560;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>3 AND t.production_year<2012 AND mc.company_id<71838 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<41835;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1102320 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>3468862 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2011 AND ci.person_id<175762;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>509542 AND ci.role_id>3 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year>2004 AND mc.company_id=4223;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>3 AND t.production_year<2011;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year<1986;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2013 AND mc.company_id=6 AND mk.keyword_id<135;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2012 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=5064;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<14348;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2008 AND mk.keyword_id<28744;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2005 AND mk.keyword_id<17591;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>1980 AND mc.company_type_id=2 AND ci.person_id>2726262 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2010 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>286;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1948 AND mc.company_id>9327 AND mk.keyword_id=2873;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>2012 AND mi_idx.info_type_id>99 AND mk.keyword_id>71605;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3978030 AND ci.role_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2013 AND mk.keyword_id=13738;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=37285 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=247105 AND ci.role_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=58642;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year=1987 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>1692308 AND ci.role_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>0 AND mk.keyword_id>12881;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<2004 AND mi.info_type_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=668040;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<203833 AND ci.role_id=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1965 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>3 AND t.production_year=1978;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>3 AND t.production_year<2002 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<12762;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=419543 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=1302987 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year=1980;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>1992;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3125024 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2013 AND mk.keyword_id=20342;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1975;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<3 AND t.production_year=1986 AND mk.keyword_id>8711;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<2005 AND mi_idx.info_type_id>100 AND mk.keyword_id>44842;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mc.company_id<1971 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<1915 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year=2003 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>4 AND t.production_year<2012 AND mc.company_type_id>1 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id<4 AND mk.keyword_id>4853;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2006 AND mc.company_id<27 AND mc.company_type_id>1 AND mi.info_type_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>22180;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=2010 AND mi_idx.info_type_id<101 AND mk.keyword_id<6848;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mi.info_type_id<3 AND mk.keyword_id=16016;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>2348734 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2494362;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<2000 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND t.production_year<2008 AND mc.company_id<3111 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year>2003 AND mi.info_type_id>18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<229;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>9553;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>3322213 AND ci.role_id>2 AND mk.keyword_id>4030;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>2926;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2004 AND mk.keyword_id<4214;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<2010 AND mc.company_id=76590 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>27850;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=1998 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=7108;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id<5557;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2012 AND mc.company_id<49351 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<2009 AND mi.info_type_id=18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>14947 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>245;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<3263 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=6854;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=6507;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>43;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2217115;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=129510;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=8595 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<2191 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id>117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id<4 AND t.production_year>1994;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<2011 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND ci.person_id<799752;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>7990;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year=1984 AND mc.company_id>2415;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id<101 AND mk.keyword_id>7877;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=6469;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>0 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2003 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<5182;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year>2007 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2008 AND mk.keyword_id=21508;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<2005 AND mk.keyword_id<10571;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>1070 AND mc.company_type_id=1 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1961;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>4 AND mk.keyword_id=21645;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND mc.company_id>8558 AND mc.company_type_id>1 AND ci.person_id<3675948 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1987 AND mc.company_type_id=1 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<2011 AND ci.person_id<2999684 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year>0 AND mc.company_id<30240 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1999;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<2000 AND mk.keyword_id=870;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>2008 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=1982;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<13981;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year>2011 AND mc.company_id<3139 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<245;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<12566 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=2 AND t.production_year<2008;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=3 AND mc.company_id=2096 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2011 AND mc.company_id=5636 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=7577;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=1767;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<14963;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2011 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<21640;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=65408;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year=1954 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>2005 AND ci.person_id=238220 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id>3311;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year<2007 AND mc.company_id>17357 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND mi.info_type_id>16 AND mk.keyword_id<6732;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<184491;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<123439 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<153122 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>2007 AND ci.role_id=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>2012 AND mc.company_id>19 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND mi.info_type_id>92 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2885259 AND ci.role_id>9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<295889 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year=2000 AND mc.company_id>35453 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<9557;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<1985;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>1762;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1969 AND mk.keyword_id=1002;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<2006 AND mc.company_id<78506 AND ci.person_id=2730455 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<1993 AND mc.company_id>12472 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=1956 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<626360 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>1994 AND ci.person_id<608748 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<116570;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=1997 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND t.production_year>0 AND mk.keyword_id<43960;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2012 AND ci.person_id<2764953;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=11342;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=2008 AND mk.keyword_id=8807;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>2007 AND ci.person_id>1690974 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id<5887;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1250936;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<14222;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<1995;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2009 AND mk.keyword_id=434;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1917 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<2863528 AND ci.role_id<3 AND mk.keyword_id=491;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=3166 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=2006 AND mk.keyword_id<3323;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND ci.person_id<3109102;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=3190;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>10607;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=2 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>21378;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>716632 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=180325 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3912451;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>2849 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1956;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<11790 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.role_id<10 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1987 AND ci.person_id>4046923;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<1992 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=89600;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1984 AND mc.company_id<14715;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>23021;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>3 AND t.production_year<2011 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>1969 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year>2003 AND mc.company_id<258 AND mc.company_type_id<2 AND ci.person_id>2716426 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>4 AND t.production_year<2015 AND mk.keyword_id>3305;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=2011 AND mi.info_type_id>94;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1008731 AND ci.role_id<9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=4794;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id<92989 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=331539 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=17222;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1996 AND mc.company_id=58476 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>766713 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year>2012 AND ci.role_id>1 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=1992 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND ci.person_id>3087670 AND ci.role_id>1 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<1972 AND mc.company_id<71555 AND mc.company_type_id=2 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=3 AND t.production_year=2001 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=4450;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<82208;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=1996 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>95736;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>2 AND t.production_year=2002 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>27953;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id=7935;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<2005 AND mi.info_type_id<4 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2009 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<2895384;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>1984 AND ci.person_id<724105 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2011 AND mk.keyword_id>1002;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>4 AND mk.keyword_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<6 AND mk.keyword_id>5899;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>2007 AND ci.person_id>486025 AND mi.info_type_id>15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<3 AND ci.person_id<1992934 AND ci.role_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2011 AND ci.role_id>2 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2009 AND ci.person_id<2835223 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3826477 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2010;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<860412 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=37458;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>1 AND t.production_year<1976;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id<1098 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=10354;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=2999;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>11403;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>911160 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1995 AND mc.company_id<391 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2006 AND ci.person_id>2132675 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=1916 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<3 AND t.production_year>1925 AND ci.role_id<3 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2010 AND mk.keyword_id=667;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id<5972;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<978992 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1060528 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2771246;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>87996 AND mc.company_type_id=2 AND ci.person_id<2445288 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1902;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>1435 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=2000 AND mc.company_id>30 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<3 AND t.production_year>1999 AND mc.company_type_id<2 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1994 AND mi.info_type_id>16 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<30237;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2914550;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2006 AND mi.info_type_id=7 AND mk.keyword_id<1552;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1952 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>1419;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=226732;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<1992 AND mk.keyword_id<7426;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>70318;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=7851;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>0 AND mi_idx.info_type_id>100 AND mk.keyword_id>245;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year=1995 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2303814;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>67327;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=1986 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>2007 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2007 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>50099;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1960;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2009 AND mc.company_type_id>1 AND mi.info_type_id>108;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=1 AND t.production_year<2009 AND ci.person_id<1221202;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=2013 AND mc.company_id<8783 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<1660824 AND ci.role_id=1 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=3 AND t.production_year=1982 AND mk.keyword_id=2199;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<23303;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=4 AND t.production_year=1970 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year>1987 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>1036239;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<1955 AND mc.company_id>13543 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year<1966 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<1999 AND ci.role_id>2 AND mk.keyword_id=32914;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2001 AND mi.info_type_id>17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id=1870606 AND ci.role_id<3 AND mk.keyword_id>33054;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND ci.person_id>532528 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2596363 AND ci.role_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2004 AND mi.info_type_id<67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=2 AND t.production_year=2002 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id>3 AND mk.keyword_id>20324;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=1987 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2012 AND ci.person_id>2784696;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<2 AND t.production_year>1959;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<347;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>7491;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_type_id<2 AND ci.person_id>2786037 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<2004 AND ci.person_id=4041770 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2523944 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=1608937 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<9079;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=4 AND mk.keyword_id=2837;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>2011 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=1903777 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1976 AND ci.role_id<10 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<3473421 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>1 AND t.production_year>2007 AND ci.person_id>1439322 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=2374788;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<2 AND t.production_year=1961 AND mk.keyword_id<382;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>1289176;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>552347 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3397776 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<3 AND mi.info_type_id>8 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<2012 AND mk.keyword_id>2488;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1668242;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2006 AND mk.keyword_id>335;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2005 AND ci.person_id>3132323 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<11226 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id>99 AND mk.keyword_id=21711;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2010 AND ci.person_id>1932981 AND mk.keyword_id>41087;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<1913 AND mk.keyword_id>335;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>1 AND mc.company_id>13734 AND ci.person_id>482605;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2009 AND ci.person_id>59946 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>23117 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=137 AND ci.person_id<1585088 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<1998 AND mi.info_type_id=110;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>2 AND t.production_year>1976 AND ci.role_id>10 AND mi.info_type_id=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=11241 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>2 AND ci.person_id<3500747 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3459713 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year>2007 AND mc.company_id<73314 AND mc.company_type_id=2 AND ci.person_id<653027 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>2871241 AND ci.role_id>2 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=138770 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<37206;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<4 AND t.production_year=2005;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2008 AND mk.keyword_id>419;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2011 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<14490 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2004 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<26789;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1420285;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1626482 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=2000 AND mi.info_type_id=107;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND mc.company_id=2281 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>4 AND ci.person_id=2060345 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>20938 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<2012 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=2 AND t.production_year<2007;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2003 AND ci.person_id<825789 AND mk.keyword_id=47;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>6257;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<100116 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>0 AND mc.company_id>82573 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1455638 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year=2012 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>2294780 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=105578 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<2000 AND ci.person_id>3024029 AND ci.role_id>1 AND mk.keyword_id>16406;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>1593;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=384;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2520479 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<29121 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<2010 AND mk.keyword_id<3354;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year=1996 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>27 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=81741;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>2013 AND ci.person_id>1505238;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1984 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND mi.info_type_id=110 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=2632798;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<2006 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<2004 AND mi_idx.info_type_id<100 AND mk.keyword_id=5037;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id<3 AND t.production_year=1979;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2494665 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>992124 AND ci.role_id<9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=370611;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1995 AND mi.info_type_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=2010 AND mi.info_type_id=16 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=1953 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<6158 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<2004;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<1976 AND ci.person_id<622321 AND ci.role_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<90934;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1977 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>29511;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2205136 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<1991 AND mi.info_type_id>16 AND mk.keyword_id<87135;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>11137 AND mc.company_type_id<2 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=3 AND t.production_year<2011 AND ci.person_id>1014810;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year=2008 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=11373 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND mi.info_type_id=2 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<4 AND ci.person_id=1304688;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=1 AND t.production_year=1974;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=31066;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND mi.info_type_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>2012 AND ci.person_id<2890470 AND ci.role_id>2 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=1 AND t.production_year>1956;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3560809;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=7364;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=3576;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<3 AND t.production_year=1961;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<2002 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>530 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mc.company_id<8850 AND mc.company_type_id<2 AND mk.keyword_id<22501;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2012 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>125135;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2372939 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<5379 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2003;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<2006 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND ci.person_id>192089 AND ci.role_id>2 AND mk.keyword_id>16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2968239 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2007 AND mk.keyword_id<3507;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<3392812 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year=1945;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>6380;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>2 AND t.production_year>0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year=2009 AND mc.company_id>6 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=160 AND mc.company_type_id=1 AND mk.keyword_id=47;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=1987 AND ci.person_id<3637864 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>2303157;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1832532 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>61702 AND mk.keyword_id<835;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=437;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND t.production_year=2009;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mi.info_type_id=7 AND mk.keyword_id>1809;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<71001 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year>1992 AND mc.company_id=1465 AND mc.company_type_id=2 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=4 AND t.production_year=1988;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=1897 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=480 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>11475;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<6008;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>4 AND t.production_year>2013 AND mc.company_id<14218 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>2008 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2290738 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2010 AND mk.keyword_id<11187;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1526118;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=45825;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year=2011 AND mc.company_id=2017 AND ci.person_id<2065499 AND ci.role_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<59192;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1937 AND ci.person_id>3184262 AND ci.role_id<7 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>652 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year<2000 AND mc.company_id=461 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2013 AND mi.info_type_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>2007 AND mk.keyword_id>3530;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>752547;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND t.production_year<1989;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<21441 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2010 AND mi_idx.info_type_id<100 AND mk.keyword_id>5161;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1984 AND mk.keyword_id<3546;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=2006 AND mk.keyword_id=5673;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<1995 AND mi.info_type_id<9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>1999 AND ci.person_id<1760213 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>481950;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>1975 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>1739 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>2004 AND mc.company_type_id>1 AND mi.info_type_id>43;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND mc.company_type_id>1 AND ci.person_id>1936738;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<1999 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year=1980 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id=10583 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year=1980 AND mc.company_id<170192 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=8151;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1838944 AND ci.role_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year=2012 AND mk.keyword_id<47106;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<3 AND t.production_year>1981 AND mk.keyword_id>782;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=85125;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1993 AND mk.keyword_id>72739;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2010 AND mi.info_type_id<16 AND mk.keyword_id<5537;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1945483;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>384628 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<3510329 AND ci.role_id=1 AND mi.info_type_id=57;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=1991;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=1954 AND mc.company_id>34 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<1901 AND ci.person_id>2303683 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>46 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3478523;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year<2012 AND ci.person_id>1465328 AND mk.keyword_id>835;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>15661 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2010 AND mk.keyword_id=34439;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2012 AND mk.keyword_id>5827;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=2008 AND mc.company_type_id<2 AND mi.info_type_id<18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<492;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<89051;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1937 AND ci.person_id=3516073;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mc.company_id>1700;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2130324;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year=2009 AND mi.info_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<2 AND t.production_year=2009 AND ci.person_id>71729;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>0 AND mk.keyword_id>411;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<3130 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<14060 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<6209 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=3 AND t.production_year>1919 AND mk.keyword_id=1677;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2013 AND mk.keyword_id<7899;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>29748;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>3486624 AND ci.role_id=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2012 AND mc.company_id=19 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=1969;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=5807;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2007 AND mi_idx.info_type_id<101 AND mk.keyword_id<23394;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2001 AND mi_idx.info_type_id>99 AND mk.keyword_id<11403;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND mc.company_id>6429;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<2 AND t.production_year>1942 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2000 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>1 AND t.production_year=2006 AND mc.company_id=68;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1412452;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2008 AND mc.company_id<6778;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1981;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<758750 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>2011 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<769664;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<4 AND t.production_year=2011 AND mi_idx.info_type_id>101 AND mk.keyword_id<4196;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>48780 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=2011 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=3 AND t.production_year=2008 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=354496 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1994 AND mc.company_type_id<2 AND mk.keyword_id<9636;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>2114200 AND ci.role_id>2 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND t.production_year>1990 AND mc.company_id>56339;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2008 AND mi.info_type_id>18 AND mk.keyword_id>8478;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=1982 AND mk.keyword_id>24892;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<3 AND t.production_year=1993;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1969 AND mk.keyword_id<580;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>4 AND t.production_year>2009 AND mc.company_id>6227 AND mc.company_type_id=2 AND mk.keyword_id<1056;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=2004 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>72874 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND mk.keyword_id=3314;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<3 AND mi.info_type_id>13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>4 AND t.production_year=2007;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<6052;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND ci.person_id<2597390 AND ci.role_id>9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>473469 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<1995 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2757074 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>397;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>20357;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>647;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=1982;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year=2004 AND mc.company_id<1070 AND mc.company_type_id=1 AND mi.info_type_id<105;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2097058 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1915 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2005 AND mk.keyword_id>10946;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year=1970;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>2008 AND mc.company_id>76538;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id>74325;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2001 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year=2012 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1977 AND mk.keyword_id>309;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>178988;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<2012 AND ci.person_id=2810118;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<2012 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2011 AND mi_idx.info_type_id=99 AND mk.keyword_id>875;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=3891;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year=2012 AND mi.info_type_id>8 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1499326 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<7075;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id<101 AND mk.keyword_id<359;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2001 AND mc.company_type_id>1 AND ci.person_id>3573237 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<3 AND t.production_year<1918 AND mi.info_type_id<15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=2003 AND ci.person_id<1818441 AND mk.keyword_id>5758;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<149241 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<4 AND t.production_year=2012 AND mi.info_type_id>98;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2011 AND mk.keyword_id=2548;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year=1968 AND ci.person_id<1275251 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>20921;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND t.production_year>1985;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year=2009 AND mc.company_id>5568 AND mc.company_type_id>1 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>21788;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<1989 AND mk.keyword_id=910;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=2008 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND ci.person_id<3588979 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<12090;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2007 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1788221 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2825147;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2011 AND mk.keyword_id<3009;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=2 AND t.production_year=2010 AND mc.company_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year=2004 AND ci.person_id<2396398 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND mc.company_id=13061 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1986 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=1375;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=1 AND mc.company_id=34044;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<5733;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2010 AND mc.company_id<1910 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1971 AND mc.company_id>923 AND mc.company_type_id=1 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=200085 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year<2008 AND mc.company_id<173763 AND mc.company_type_id<2 AND mi.info_type_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>227627 AND mc.company_type_id=2 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=34640;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id=1215668 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3133631;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1996 AND mk.keyword_id<35544;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND ci.person_id>203770 AND ci.role_id>2 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=1959;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>1896;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id>30425;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2013 AND mc.company_id<85016 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND mc.company_id<71768 AND mc.company_type_id<2 AND mi.info_type_id=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=3584;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2736942 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>1991 AND mk.keyword_id<11967;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>1706985 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<70927 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year>2006 AND mc.company_id<27;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2819182 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<2011 AND ci.role_id=5 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1974 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2012 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_type_id=1 AND ci.person_id<3861149;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year=1965 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=29084;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3906292;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2008 AND mc.company_id<16522 AND ci.person_id<2795119 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=20299;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>4 AND t.production_year>2005;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<18156;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=6429 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<2 AND t.production_year=2009 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>2012 AND mc.company_id>4170 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>82 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<1801160;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2007 AND mk.keyword_id>15309;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<5922;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mc.company_id<230900 AND mc.company_type_id<2 AND mk.keyword_id=39485;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>2853043 AND mk.keyword_id<3169;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<28212;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<6914;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<12391;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1976 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<41793 AND ci.person_id>2062673 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2737620;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=20176 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<14526;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2013 AND mk.keyword_id>5408;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<674;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>1992 AND mk.keyword_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>1994 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>3 AND t.production_year=1962;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=2788;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<61606 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<1974 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>2 AND mk.keyword_id>7768;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<4 AND t.production_year=1961 AND mc.company_id>31;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2010 AND mi_idx.info_type_id>101 AND mk.keyword_id<10780;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2002 AND mk.keyword_id=43106;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>1933777 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=2008 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>74600 AND mc.company_type_id=2 AND ci.person_id>2057778 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>2005 AND ci.person_id<2558091;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2011 AND mc.company_id<6 AND mc.company_type_id=2 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2006 AND mc.company_type_id=1 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1969 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id=33188;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=2 AND t.production_year=2003;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id>230;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>2007 AND mi.info_type_id<4 AND mk.keyword_id>750;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2010 AND mc.company_id>3755 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=39418;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=2005 AND mc.company_id<17738 AND ci.person_id>2037695 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>2010 AND ci.person_id<616360;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>36535;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1996 AND ci.person_id<3477122 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2462788 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>1982 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>20062 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id>4398;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<127102 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND mk.keyword_id<11501;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id=1291;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<743776 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2001 AND mc.company_id=11367 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<2002 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>419;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=1978 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2001 AND mc.company_id<166 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>4 AND t.production_year=1973 AND mi.info_type_id=2 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<1990;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<1997 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=1984 AND mc.company_id>483 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<1427 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<26843;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=10635;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<13046;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=4 AND t.production_year=2010 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<2006 AND ci.person_id<4037687;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<55195 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND ci.person_id<3510664;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>5689;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<4022918;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<1974 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<1996 AND ci.person_id<23733;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<56761;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>19 AND mi.info_type_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=59181 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>3483;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=2 AND t.production_year=1982;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<8637;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>1979 AND ci.person_id<2743948 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<3 AND t.production_year>2005 AND mi.info_type_id=8 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>47157;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=2005 AND ci.person_id=1213931 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2244023 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id=359;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2715974;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<1989;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year=2002 AND mc.company_type_id=2 AND ci.person_id>40863 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<1988 AND ci.person_id>1280035;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>553124;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=3 AND t.production_year>2008 AND mc.company_id>62004 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>2013 AND mc.company_id>7851;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2005 AND mc.company_id>17693 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>11319 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1916 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<3784;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2001 AND ci.person_id<2460586 AND ci.role_id>2 AND mk.keyword_id>3663;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<2007 AND ci.person_id<2501181;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1052767 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2009 AND ci.person_id>1412687 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id>101 AND mk.keyword_id<14889;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<2008 AND mc.company_id<16396 AND mc.company_type_id=1 AND mi.info_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2099065 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1993 AND mc.company_type_id<2 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=49207;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<1995 AND mk.keyword_id>710;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<302 AND mc.company_type_id>1 AND mk.keyword_id<3945;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<16378 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=4 AND mk.keyword_id<4574;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1946;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2962276;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND mk.keyword_id<7609;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=14060 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1800720;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<954352;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=4052079 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<3925562 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>2005 AND mc.company_id=160 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2011 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>2011 AND mc.company_id=1302 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>2926768;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1696471 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=4050707;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>4228;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<1985 AND mc.company_id<7851;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=452 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<3 AND t.production_year<1988 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<41903;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=39167;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND mk.keyword_id=429;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=94995;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<2 AND mk.keyword_id=7121;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3053908 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>15168;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>2863018 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2009 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id>12473;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<1997 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<1994 AND mk.keyword_id<1657;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND mc.company_id=689;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<2010 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<108655;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<210502 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>1376 AND mc.company_type_id=1 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>1 AND mc.company_id>3851 AND ci.person_id>654840 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>2 AND t.production_year=2009 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=122 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year>2009 AND mc.company_id<33739 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND ci.role_id=2 AND mk.keyword_id>4038;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=1969;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<71473 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1994 AND mi.info_type_id<2 AND mk.keyword_id<59123;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2175543;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2011 AND mk.keyword_id<15425;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2006 AND ci.person_id>1438333 AND ci.role_id=9 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id=3992791 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1327705 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=1842951;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>789547 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>3728768 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>1835045 AND mi.info_type_id=105;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND mk.keyword_id>24154;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>26039;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<4 AND mc.company_id>44198 AND mc.company_type_id=1 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<385396 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1964 AND mk.keyword_id>7773;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1295276 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=2008 AND mi.info_type_id<15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=6 AND t.production_year>2011;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1956;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2012 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=363461;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id>99 AND mk.keyword_id<2172;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<83375 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year>2012 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<3 AND mk.keyword_id<2230;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year=1984 AND ci.person_id<2647438 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND ci.person_id<1911238;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=2006 AND mi.info_type_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=2013 AND ci.person_id>1837407 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<915566;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1991;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mi_idx.info_type_id>100 AND mk.keyword_id=6226;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<2001 AND ci.person_id<3002197 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>2359;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2809898 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>2004 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1988 AND mk.keyword_id<121;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1656437 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>11603;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>20 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>1982 AND mc.company_id<452 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2009 AND ci.role_id>1 AND mk.keyword_id>4989;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=1998 AND mc.company_type_id=1 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<6366;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1965 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<733215 AND ci.role_id=3 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND ci.person_id>3142118 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2911839;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1987 AND mi.info_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2010 AND mk.keyword_id>1584;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>2 AND mi_idx.info_type_id=101 AND mk.keyword_id=347;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<26725;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id=1633;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1995 AND mc.company_type_id>1 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=27 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<40999 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<1860728 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>89592;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>3 AND t.production_year<2009 AND ci.person_id<2392764 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>1999;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<218559 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2012 AND mi.info_type_id<18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND ci.role_id>1 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND ci.person_id<175411;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year=2007 AND mk.keyword_id>3842;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<18407;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<2375;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>7640;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id>28339;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND ci.role_id>2 AND mk.keyword_id>2562;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<738 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>6 AND ci.role_id>8 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<10112;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>3 AND t.production_year<1998;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1995;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=14185 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2004 AND ci.person_id<1664359 AND mk.keyword_id<117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id>2489616;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=2008 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year=2002 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=2011 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1968 AND mk.keyword_id<5683;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<3 AND t.production_year>1912 AND mk.keyword_id>3664;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>2007;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year=1999 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2767603;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id>11866;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2006 AND mc.company_type_id>1 AND mk.keyword_id=3155;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=700 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<36275;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<3015 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<1841 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1441525 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2011 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<2004 AND ci.person_id>1134358;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND mc.company_type_id=2 AND mk.keyword_id<898;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>2011 AND mc.company_id=7500 AND mk.keyword_id>11058;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1923 AND ci.person_id<2597757;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=19337;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=49 AND mc.company_type_id=2 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>22340 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=13533;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=1049 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3979972;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<2 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>2 AND t.production_year<2007 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<1994 AND mi.info_type_id=18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2005 AND mk.keyword_id<93374;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mk.keyword_id<1391;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<2009 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<92918 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<618546 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=92467;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND mc.company_id>15053 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<3039 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=120958;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<116606 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=71000;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=228;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2835974;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=2008 AND mi.info_type_id>18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year=1974 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND ci.person_id>2507696 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=3 AND t.production_year=1961;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<856996 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<1996 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=34362;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=3812008;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND ci.person_id=118585;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1897;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2002 AND mc.company_id=92450 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year>1915 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=2009 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2008 AND mc.company_id=145 AND ci.person_id<405635;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2657741 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=1971 AND mc.company_id>424;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1920775 AND ci.role_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<1985 AND mc.company_id=223559;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1999 AND mi.info_type_id=1 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2012 AND mc.company_id<44018 AND mk.keyword_id=731;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2103469;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>4 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2012 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>636205 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=99 AND mk.keyword_id<12015;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1987 AND mk.keyword_id>1096;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND t.production_year>2000 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1970 AND ci.person_id>2432216 AND ci.role_id>1 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<2002 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mi_idx.info_type_id>99 AND mk.keyword_id=65172;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>2 AND t.production_year=2010 AND ci.person_id<1110327 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>92268;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<508;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id>1254784;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1965 AND mc.company_id<73920 AND mc.company_type_id<2 AND mk.keyword_id>77130;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=6 AND mc.company_type_id>1 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<2011 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1978 AND mk.keyword_id<11584;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1939 AND mk.keyword_id<5623;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>3 AND mi.info_type_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<2 AND t.production_year=1963 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=4629;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2003 AND ci.person_id>1143923 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=79928;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND mc.company_type_id=1 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<2012 AND mi.info_type_id>12 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>30584;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>4 AND t.production_year>1994;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<7257;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id=2745214;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year=1986 AND ci.person_id>3228724;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id>9312;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3032662;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND mc.company_id=865 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<16970;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=3311;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=205721;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2011 AND mk.keyword_id<16144;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<1968 AND mc.company_id<11 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=8478;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1943749;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=1994 AND ci.person_id>2102548 AND ci.role_id=4 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND mi.info_type_id>65;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>2646915 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id=2096;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<844567 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND mc.company_id=1067;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>814639 AND ci.role_id=1 AND mi.info_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year>1988;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id<8 AND mk.keyword_id<3052;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2007 AND mc.company_id=4599;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2109999;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2863484 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<2005 AND mi.info_type_id<15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id<378136 AND ci.role_id>9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<3465010 AND ci.role_id=1 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=26897;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<110778;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=1276441 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<1985 AND mk.keyword_id<15057;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>2004 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=1986 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year>2005 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<777025 AND mk.keyword_id>110;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=651;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=2 AND mk.keyword_id=5599;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=2 AND t.production_year=2009 AND mk.keyword_id=117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2005 AND mi.info_type_id>9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year<1964 AND mc.company_id=73 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1968 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1209261 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2012 AND mk.keyword_id>39084;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>4 AND t.production_year<1987;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id>981637;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=2012 AND mc.company_id<5653;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=22318;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year<1995 AND ci.person_id<2817171 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<3236072;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2012 AND mc.company_type_id>1 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=82239 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>567 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=8615;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<28356 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1997;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>1914 AND mk.keyword_id>7772;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<1948 AND mi.info_type_id=18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>2004 AND mc.company_id>72809 AND mc.company_type_id>1 AND ci.person_id>2777587 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>1750 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND t.production_year<2010 AND mk.keyword_id>77075;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>114014 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1589654 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>1936 AND mi.info_type_id=107;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=3200;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id>99 AND mk.keyword_id<4333;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year>2011 AND mc.company_id=122780;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2005 AND mk.keyword_id<865;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>1290293 AND ci.role_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=1905 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1976 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=2187 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=8052;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1985 AND ci.person_id>318669;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>1967 AND ci.person_id=176905;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=10768;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2002 AND mk.keyword_id<613;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=1980;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year=1992;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<2008 AND mc.company_type_id>1 AND ci.person_id<34053 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2011 AND ci.person_id>2055705;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1349589;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<1213;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>18722;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id>1131;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>1983 AND ci.person_id=1044842;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year>2010 AND mc.company_id<160 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>30182;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2007 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>6 AND t.production_year<1986 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id<2 AND mk.keyword_id>73302;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=2 AND t.production_year>2002;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id>7156;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1950 AND ci.person_id>2766384 AND ci.role_id<6 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>0 AND mi.info_type_id<105;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2009 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>94757;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=562621;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<19812;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id>680;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<86882 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>2011 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1662187;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>72552;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1430838;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<9297;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=44355;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<128 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>454761 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<11770 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=2002 AND mi_idx.info_type_id<101 AND mk.keyword_id>16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2012 AND mc.company_id<11 AND mc.company_type_id=1 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND mk.keyword_id>5106;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2006 AND ci.person_id>187484;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>3 AND t.production_year<1989;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND ci.person_id>1733942 AND mk.keyword_id>20003;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1698802;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<11716;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=794036;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year>2003 AND mi.info_type_id>15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=1982 AND ci.person_id<1059141;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>4 AND t.production_year>1972;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2091590 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id>71657;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2760460;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1259304 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1979 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<2011 AND mc.company_id<17460 AND mc.company_type_id>1 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=5328;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>45499;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>1973 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3188675 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>1314065 AND ci.role_id>1 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=663 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mi.info_type_id=7 AND mk.keyword_id>1064;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=2003 AND mc.company_id<18794 AND mc.company_type_id<2 AND mi.info_type_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=1985 AND ci.person_id<3984235 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<4226;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=3 AND t.production_year>2000 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3663838 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2002 AND mk.keyword_id=503;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2008 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year>2012 AND mc.company_id<73 AND ci.person_id>2593181 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year=2005 AND mc.company_type_id>1 AND ci.person_id<604413 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=294108;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2007 AND mi.info_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3117922 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2004 AND mk.keyword_id=782;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND mc.company_id>4625 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=17297 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<21489 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=2011 AND ci.person_id>959880 AND ci.role_id=3 AND mi.info_type_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year=2007 AND ci.role_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>2004 AND ci.person_id>395340 AND ci.role_id=1 AND mk.keyword_id>500;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2048400;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1558699 AND ci.role_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>22368;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>679587 AND ci.role_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<11172;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=3015;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mc.company_type_id>1 AND mk.keyword_id=7682;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>1955 AND ci.person_id=3138029 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year>1911 AND mc.company_id<6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2006 AND mk.keyword_id<550;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=1998 AND mc.company_type_id=1 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>2009 AND mc.company_id<1129;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>969;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<47874 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2003 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<3266;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<12832;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id<3 AND t.production_year<2006;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<2007 AND mc.company_id=1640;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<2 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2907937;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<956725;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<38120 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2012 AND mi.info_type_id>15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1996 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<132947 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>981 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=4 AND t.production_year=2013 AND mk.keyword_id>35815;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<1954 AND mk.keyword_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1997 AND mi_idx.info_type_id>99 AND mk.keyword_id>26087;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2823457;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<858;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=3 AND t.production_year>2008 AND mc.company_id=7264 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>1959 AND ci.person_id<407361 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>2008 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>37127;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=2 AND t.production_year=2005 AND ci.person_id>2956058;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=59232;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=293554 AND ci.role_id<2 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>1929 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=103;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=4 AND t.production_year=1982;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>2011 AND mk.keyword_id>16372;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1481023;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=28287;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=37032;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2005 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=1965 AND ci.person_id<2712954 AND ci.role_id<2 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>11781 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<11245 AND mc.company_type_id<2 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<64232;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2010;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<2001 AND mk.keyword_id>3534;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id=72366;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2003 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id>28957;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=16024 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=471698;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>383938 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2001 AND ci.person_id>246185 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND ci.role_id=1 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<160 AND mc.company_type_id=2 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=21075 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>762190;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>7876 AND mk.keyword_id<47;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_type_id>1 AND ci.role_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=3 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mc.company_id<3721 AND mk.keyword_id>115;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<117863 AND ci.role_id>1 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1495180 AND ci.role_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.role_id>9 AND mk.keyword_id=2643;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<2108;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>13787;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>18445;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id>3152016;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>1488047 AND ci.role_id=2 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>1994 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<15600;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year=1992 AND mc.company_id>6 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id>500;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=2011 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<2007 AND mk.keyword_id=5144;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2004 AND mi.info_type_id=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=2011 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<105953;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>2202;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<3132203 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=5890;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=1987;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND t.production_year<2007 AND mk.keyword_id<266;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=680;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id<2787296 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<4025587 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=3 AND t.production_year<2001;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>41764 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>28390;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>738;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<4 AND t.production_year<2001 AND mc.company_id<2560 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=3561972 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<2011 AND ci.person_id>1310196 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id<10642;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2006 AND mk.keyword_id<18607;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3247723;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2005 AND mk.keyword_id<10233;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1976 AND mk.keyword_id<39813;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>743;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND mc.company_id>11146 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>1791774 AND ci.role_id<10 AND mk.keyword_id=73;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>11149 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<80227 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=669764 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1920 AND mc.company_id<178919 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>213064;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=1142 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year=2011 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>1979 AND mc.company_type_id<2 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3291893;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>1914 AND ci.person_id<2639066 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mk.keyword_id>4601;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1987 AND mc.company_id<49086 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>2005 AND ci.role_id<4 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3090892;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year=2003 AND ci.person_id<302335 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id=77 AND mk.keyword_id=8624;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year=1998 AND ci.person_id<3058577 AND ci.role_id<3 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>19481 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<6177;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=2740471 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>11288 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=12503;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id<3080;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<1985 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<18772;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<2010 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>74085 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2008 AND mi_idx.info_type_id>101 AND mk.keyword_id>795;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_type_id=1 AND ci.person_id=2324295 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>1988 AND mi.info_type_id=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1376776 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<71052 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=100 AND mk.keyword_id<107;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>1948;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>2778165 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=2 AND t.production_year<2012 AND ci.person_id=93260;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<49745 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<21129;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year>2009 AND ci.person_id<359406 AND ci.role_id=3 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>1950;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1995;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>2005 AND mc.company_id>11402 AND mk.keyword_id>115;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2001 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<394 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<1167912 AND ci.role_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>2012 AND mc.company_type_id=1 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>64650;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<7400;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mc.company_id<12420 AND mc.company_type_id<2 AND mk.keyword_id>6421;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2012 AND mk.keyword_id<2488;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2012 AND mk.keyword_id>807;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<7265 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=59659 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<2053301 AND ci.role_id=4 AND mk.keyword_id<7376;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2002 AND mi.info_type_id=16 AND mk.keyword_id<398;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2012 AND mk.keyword_id>8184;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND mi.info_type_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id<3056992 AND ci.role_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<1997 AND ci.person_id<2925931 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>4 AND t.production_year<2010 AND ci.person_id<439960;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<2923;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<1996 AND mk.keyword_id=3186;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<1982 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id>74199 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<309957;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<1998 AND mc.company_id>596;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<2008 AND mi_idx.info_type_id=101 AND mk.keyword_id>4333;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<51060 AND mc.company_type_id=2 AND mk.keyword_id=117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>3 AND t.production_year=2011 AND mk.keyword_id>7525;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=3 AND t.production_year>1968;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<4 AND t.production_year=1979 AND mi.info_type_id<16 AND mk.keyword_id<70;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>19896;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<757624 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<4 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=9772;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id>15 AND mk.keyword_id>562;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>1966;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=23202 AND mc.company_type_id=1 AND mk.keyword_id>31252;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<1210 AND mc.company_type_id=2 AND mk.keyword_id<3337;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>185;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<1961 AND mc.company_id>119692 AND ci.person_id>1463862 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<134991;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>1938 AND mk.keyword_id=53994;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>2002 AND mi.info_type_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>3 AND t.production_year=2007 AND mc.company_id>252 AND mc.company_type_id=2 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=1641;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=3 AND mk.keyword_id=3574;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year<1952 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1982 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=1963 AND mk.keyword_id>2487;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND mc.company_id<62000 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2013 AND mk.keyword_id=335;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=2001 AND mc.company_id>25287;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1992 AND mk.keyword_id=7477;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=2010 AND mc.company_id>6 AND mc.company_type_id>1 AND mi.info_type_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=1121;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<4450;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=13485 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=96777;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year>2005 AND mc.company_id>71188;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>2506254 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=1967 AND ci.person_id>1942435 AND ci.role_id>1 AND mi.info_type_id<15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>2011 AND mc.company_id>14875 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<1999 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<1684;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND ci.person_id<1881736 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=3935079 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2089320;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>2009 AND mi_idx.info_type_id>100 AND mk.keyword_id=3356;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2011 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND mc.company_type_id=1 AND ci.person_id<463447 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>10584;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<1956;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=159;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1985;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1993 AND mc.company_id<164915 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2012 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<2642 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<1980 AND ci.person_id>714457 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2008 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2007 AND mk.keyword_id<6727;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1971 AND mi.info_type_id>13 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<2459200 AND ci.role_id=3 AND mk.keyword_id>54546;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<2859833 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1961 AND ci.person_id>2168135 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id=3 AND mk.keyword_id<33731;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>41307;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id=1470830 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND ci.person_id<720856 AND mk.keyword_id<722;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>2 AND t.production_year=1959 AND mc.company_id>75472;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<1962 AND mk.keyword_id<847;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=52248 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<78673 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2008 AND mk.keyword_id>3244;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<10999;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2007 AND mc.company_id<7851 AND mc.company_type_id>1 AND mk.keyword_id=1326;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1504641;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND t.production_year<2006 AND mc.company_id<1435 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=3909 AND mc.company_type_id=1 AND mk.keyword_id<34122;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<272200;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id<2749069;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2006 AND ci.person_id=1114361 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_type_id<2 AND ci.person_id=3424659 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>4 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2010 AND ci.person_id=431903 AND ci.role_id<8 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2010 AND ci.person_id<2250184 AND ci.role_id>3 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND ci.person_id=1736207 AND ci.role_id=1 AND mk.keyword_id<766;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=1998 AND mc.company_id>1709 AND mk.keyword_id>16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2011 AND mi.info_type_id<16 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>4 AND t.production_year>1995;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>3 AND t.production_year<2012 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>2362641 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>4 AND t.production_year<1993 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=2155;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>6217;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=71006 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=1291;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND ci.person_id<1245139 AND ci.role_id>10 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year<1968 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<1544 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=35077;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>3357;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<63;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1941 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=89546;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2662732;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>86775;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id<3642;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<2 AND t.production_year>1959;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=2010 AND mc.company_id>225;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2010 AND mc.company_id>81341 AND mc.company_type_id>1 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mk.keyword_id>2879;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2005 AND ci.role_id>1 AND mk.keyword_id>5908;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year=1986 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>462797 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<3 AND t.production_year>1981;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND ci.person_id>2334804 AND ci.role_id=10 AND mk.keyword_id>33543;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>17313;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2012 AND ci.person_id>1031408 AND ci.role_id<5 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>0 AND mk.keyword_id=748;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id<1093445 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year>1951;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>5731;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>14699 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2012 AND ci.person_id>437569 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=2008 AND ci.role_id=8 AND mk.keyword_id=5434;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1949;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2431163 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<1911 AND ci.person_id>782701 AND ci.role_id<2 AND mi.info_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=3321;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>428;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<1998 AND mc.company_id=16708;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_type_id<2 AND mk.keyword_id>583;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND ci.person_id<2878634 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND ci.person_id>374978 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2008 AND ci.person_id>1337716 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>11374 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>2009 AND mc.company_id<8278;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>666;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year>2003 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>7300;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>62890;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND mc.company_id<4667 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year>2006 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>3791;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2778959 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=2010 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<19144 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>3 AND ci.person_id>3549070;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year=2005;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=7956;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1225416 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2010 AND ci.person_id>2916473 AND ci.role_id>2 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mc.company_id=9163 AND mc.company_type_id>1 AND mk.keyword_id<712;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND ci.person_id=2822025 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id=207 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1916 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<5907;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND t.production_year=2005 AND mk.keyword_id>11992;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<4 AND t.production_year=2009 AND mi_idx.info_type_id>100 AND mk.keyword_id>5589;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mi.info_type_id=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=1981 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>1427417;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1381981 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2004 AND mk.keyword_id>51196;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2011 AND mc.company_type_id=1 AND mk.keyword_id=310;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<624 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>1805864 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2007;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<16680;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=8078;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND t.production_year>2006 AND mc.company_id>75343 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1004616;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=4 AND t.production_year>0 AND ci.person_id<512522 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1980 AND mk.keyword_id>30292;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_type_id=1 AND ci.person_id=548410;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<1993 AND mc.company_id<3296 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<1972 AND mc.company_id=1461 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id=216318 AND ci.role_id<8 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=3 AND mk.keyword_id<5262;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>667224 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id>16 AND mk.keyword_id<3311;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year>1916 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=574;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=9322;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>2011 AND ci.person_id<1648775;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<157674;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>868 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<11808 AND mc.company_type_id=1 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>15676 AND mi.info_type_id>105;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<1998 AND mk.keyword_id>54814;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year=1960 AND mc.company_id>1724 AND mk.keyword_id>3293;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=2001 AND mc.company_id=166 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<3617;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND mc.company_id=1595 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=2239043 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>1989 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>2425 AND mc.company_type_id=2 AND mi.info_type_id=107;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=12666;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<3141 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>228738;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1149810;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>167764 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<4805 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<27903;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<2011 AND ci.person_id<2947075 AND ci.role_id=4 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>1937 AND ci.person_id>91780 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND ci.person_id<504274 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=4 AND t.production_year<1994 AND mc.company_id>39640 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=4 AND t.production_year>1996 AND mi.info_type_id<16 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2009 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year=1978;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>25053;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=18406;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=2000 AND mi.info_type_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<2011 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=9766;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2010 AND ci.person_id>3003638 AND ci.role_id<10 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>130853;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND ci.person_id=2039178 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=1997;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year>1982 AND mc.company_id<3051;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<46138;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2008 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=1992 AND mc.company_id<1478 AND ci.person_id>2001515;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id>20330;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=949639;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id>15018;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1101431 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_type_id=2 AND mk.keyword_id>2487;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>19 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year<2012 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<34467;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1976 AND mk.keyword_id<888;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=891162;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mc.company_id<11812 AND mk.keyword_id=70;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<813;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND ci.person_id=1900760;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>45400;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=905407 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<3 AND t.production_year<1999 AND ci.person_id>2133 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<737 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=1979 AND ci.person_id>3263665 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year>2005 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<2011 AND ci.person_id>1698890 AND ci.role_id=10 AND mk.keyword_id>46085;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=101 AND mk.keyword_id=2102;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id=3505702 AND mk.keyword_id<103;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year=2001 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=4 AND t.production_year<1997 AND ci.person_id>203160 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.role_id>2 AND mk.keyword_id=27530;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND mi.info_type_id>13 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id=825318 AND mk.keyword_id>20318;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year>2012 AND mi.info_type_id=4 AND mk.keyword_id>50272;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>2001 AND ci.person_id>3005286;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id>8183;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND ci.person_id<1106164;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>2005 AND mi_idx.info_type_id<101 AND mk.keyword_id<4604;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>2009 AND ci.person_id=986009 AND ci.role_id>3 AND mk.keyword_id>84;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>3055;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>1070;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>96176;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<70045;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<75604;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1952 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<16402;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2011 AND mk.keyword_id<8463;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>672428;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=7 AND t.production_year>1955;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<2008 AND mc.company_id<2609 AND mc.company_type_id=2 AND mk.keyword_id=24050;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=2661;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<1934 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<1368 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id>57;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND ci.person_id=2834594 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=174958 AND ci.role_id=4 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=855989;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<133269 AND mc.company_type_id=1 AND mk.keyword_id<3295;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=4 AND t.production_year<2004 AND mk.keyword_id<10074;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1980 AND mk.keyword_id=11863;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2835688 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>707 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=2010 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.role_id>2 AND mk.keyword_id=335;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>3 AND t.production_year<2001;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1935;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=71849;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND mi.info_type_id=18 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>1989 AND mc.company_id<7512 AND mc.company_type_id>1 AND mk.keyword_id=43792;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<3 AND t.production_year=2011 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2012 AND mk.keyword_id<4567;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<17468 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year>2008 AND mc.company_id<240 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>6 AND mc.company_type_id=1 AND mk.keyword_id<45802;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<53860;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year<2010 AND mc.company_id>11141;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<1983 AND ci.person_id<2024005;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2004 AND mk.keyword_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>4 AND t.production_year<2002;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>2012;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<1999 AND mk.keyword_id<2212;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1933110;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id<101 AND mk.keyword_id>2888;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>4 AND t.production_year<1986;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>4 AND mk.keyword_id>178;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=3638 AND mi.info_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2002 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<1989 AND mk.keyword_id>117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id>1697;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>4 AND t.production_year<2008 AND mc.company_id<113016 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1978 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1081492;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=338287;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=2012 AND ci.person_id>2648471 AND mi.info_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<4 AND ci.person_id>513549;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=79672;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2008 AND mk.keyword_id>11016;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<2204;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=2 AND t.production_year>2005 AND ci.person_id>2467169 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<2 AND t.production_year<1947;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=954572;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id<6049;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=2012 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=1997 AND mk.keyword_id<3719;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=29106 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1863587;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2210537 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mi_idx.info_type_id>99 AND mk.keyword_id>495;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id=2625447 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=1949;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<1983 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>38282;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year>2012 AND mc.company_id>14060 AND ci.person_id>2483067;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND ci.person_id=1706587 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND ci.person_id=2595876 AND ci.role_id>1 AND mk.keyword_id<6515;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2002 AND mk.keyword_id<5952;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.production_year<1946;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=2 AND mc.company_id=115;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<2012 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>1929 AND mi_idx.info_type_id<100 AND mk.keyword_id=275;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>2009 AND mk.keyword_id=927;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year=1998 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<9417;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year>2008 AND mi.info_type_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>2010 AND ci.person_id>1600554 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>5830 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<3 AND t.production_year>2004 AND ci.person_id=1603076 AND ci.role_id<5 AND mi.info_type_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=28339;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<2006 AND mc.company_id<424 AND mc.company_type_id>1 AND mk.keyword_id=4983;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<368436 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>1964 AND ci.person_id<2324401;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1985 AND mc.company_id>11203 AND mk.keyword_id>9165;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<8086;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<3311;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<51135 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=4 AND t.production_year=2009;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>59935;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<9985;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2009 AND ci.person_id>3841823 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2012 AND mi.info_type_id<98;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<2439163 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>32268;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>2 AND t.production_year<2011 AND mc.company_id=7851;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=18986;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=1964 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>2006 AND mi.info_type_id=13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year>1970 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<1521;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<50815;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>7692;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=4 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=1 AND t.production_year>2000 AND mc.company_type_id>1 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>2012 AND mi.info_type_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<6374;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=2 AND t.production_year<2011 AND ci.person_id>2023004 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1932;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<21737 AND mc.company_type_id>1 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>12666;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>1959 AND mc.company_id<12871 AND mc.company_type_id>1 AND mk.keyword_id>16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND ci.person_id>1549177;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<2005 AND mi.info_type_id=7 AND mk.keyword_id<47826;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>37810;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>968;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=2 AND t.production_year>2010;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>2864;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>2005 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<2010 AND mk.keyword_id=23472;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=4 AND t.production_year>1997;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2116398;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<2003 AND ci.person_id<1075256 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND t.production_year<2000 AND mc.company_id<4128;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1967 AND mc.company_id>252 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND ci.person_id<3619741 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND ci.person_id>455264 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>834372;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>4834 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>1981 AND mi.info_type_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<1999 AND mc.company_id>138 AND ci.person_id<3283233 AND ci.role_id=11;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1971 AND mk.keyword_id<6406;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<4 AND mi.info_type_id<3 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2012 AND mi_idx.info_type_id<101 AND mk.keyword_id=20319;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<6 AND t.production_year<1913 AND mk.keyword_id>335;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=39600;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=2013;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=2 AND mc.company_id=9969 AND mc.company_type_id<2 AND ci.person_id>3016198 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3115605 AND ci.role_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2009 AND mc.company_id>51;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>594 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year<1991;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<4 AND t.production_year<1994 AND ci.person_id>558569;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year>1994;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<219;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id>1226;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<1854 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.role_id=1 AND mk.keyword_id<19127;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2013 AND mc.company_id>67570 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1807487;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=2 AND t.production_year>1997;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2008 AND ci.person_id<2170822 AND mi.info_type_id>9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<3920;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=1962 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=6 AND mi.info_type_id<98;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2002 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<2012 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2001 AND mc.company_id<1472 AND mc.company_type_id<2 AND ci.role_id<9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=1959 AND mk.keyword_id<6196;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=2007 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<2001 AND mk.keyword_id>3278;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1996 AND ci.person_id<1756961 AND ci.role_id=1 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>2275815 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2008 AND mk.keyword_id>20786;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2012 AND mk.keyword_id<77;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year=2002 AND ci.person_id>1428509;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<451;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=523210 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<2613030 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>11134 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id=15607 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=601437;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1969 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<1986 AND ci.role_id<2 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<2862985 AND ci.role_id>10 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<3025;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2012 AND mi.info_type_id=2 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<100427 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<3755;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id=1013;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<3 AND t.production_year=1948 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<2005 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2007 AND ci.role_id=1 AND mi.info_type_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=2009 AND ci.person_id<2000463 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1959 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<2041;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>180 AND mc.company_type_id=1 AND ci.person_id>678700 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>1716 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1834929 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>4 AND mk.keyword_id=16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>1998;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=78632;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<4 AND t.production_year=2013 AND ci.person_id<930069;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>2010 AND mk.keyword_id>8478;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2001 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<4 AND t.production_year>2005 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2012 AND mk.keyword_id<29033;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>980717 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1984 AND ci.person_id<1356788;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<1976 AND mk.keyword_id<3654;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=4 AND t.production_year=2008;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id<117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=2013 AND mc.company_id=114 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year>2008 AND mc.company_id>86204 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=630656 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year>2004 AND mc.company_id>1010 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=267;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=8074;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>338840 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<82 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.role_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=32344;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>40036;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=899416;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<1977;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id<101 AND mk.keyword_id>13037;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year=2012 AND mc.company_type_id=2 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mi_idx.info_type_id=100 AND mk.keyword_id=21041;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2011 AND mc.company_id=172553;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>3 AND t.production_year>1996;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>2005 AND mi.info_type_id<17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year<1988 AND mc.company_id>22429 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>2013 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>98685;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>2008 AND mc.company_id>253 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<4 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id<3 AND t.production_year<1968;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2034492;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<1527;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>1953 AND mc.company_id=2394 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2411392 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2005 AND mk.keyword_id>5083;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>5925;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<2012 AND mc.company_id<686 AND mk.keyword_id=11272;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id>166664 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<13643;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1993 AND mi_idx.info_type_id>99 AND mk.keyword_id>34200;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=6039;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id=84762;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year<1975;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=3782;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1862606 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2002 AND mk.keyword_id<7301;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>1755702;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>2010 AND mi.info_type_id>3 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id<114062;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1328902 AND ci.role_id<9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1797855 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>1371584;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year<2005 AND mc.company_id=49;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=2001 AND mc.company_id<12512;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2006 AND mk.keyword_id>13914;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mi_idx.info_type_id<100 AND mk.keyword_id=71742;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=180022;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>2005 AND mc.company_id<1461 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=2011 AND mc.company_id=8142;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=11138 AND mc.company_type_id>1 AND ci.person_id>2284654 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2008 AND mi.info_type_id=7 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2004;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=178;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id<11 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>8734;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year<1960 AND mc.company_id=4625 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<10712;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<2006 AND mk.keyword_id<16154;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1997 AND mc.company_type_id<2 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id=1722605 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>4 AND t.production_year=2000;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<52 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<2008 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<70496;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1405322;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>15405 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2006;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3324126;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2009 AND mi.info_type_id=1 AND mk.keyword_id>137;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>3420485 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1980 AND ci.person_id<1674553 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>2013 AND mc.company_id>33713 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND mc.company_id=12948;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1992 AND mk.keyword_id>20794;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<3 AND t.production_year>2005 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND mc.company_id=6 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<958;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=3 AND t.production_year=1993 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>2008 AND ci.person_id<3029930 AND ci.role_id>3 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>4 AND mi_idx.info_type_id=100 AND mk.keyword_id<1107;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=11135 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=1990 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<1946759 AND ci.role_id<6 AND mi.info_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>2611687 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=1984 AND mk.keyword_id>8087;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=2006 AND mi.info_type_id=7 AND mk.keyword_id=2926;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year<1955;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<4 AND t.production_year=2007;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=2007 AND ci.person_id<825497 AND ci.role_id>1 AND mk.keyword_id<249;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id<3663;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id=2561;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=100782 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=2011 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>1532228 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1998 AND mk.keyword_id<15487;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=2008 AND mc.company_id<11807 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>2000 AND mc.company_id=160 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2012 AND mk.keyword_id>9127;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1033380;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<13037;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND mc.company_id=18644 AND ci.person_id>1788016;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=3241038 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=1995 AND mc.company_id<197 AND mc.company_type_id<2 AND mk.keyword_id<317;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3482159 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND t.production_year<1996 AND mi.info_type_id=8 AND mk.keyword_id<1749;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>2 AND t.production_year>2004 AND mk.keyword_id<3430;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id<829281 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2001 AND ci.person_id<2816281 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=1659485 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id=1164311;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<81256;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2011 AND mk.keyword_id>1771;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<3 AND mc.company_id>7588 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1913 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<2006 AND mk.keyword_id<845;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3921479;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=79033 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>2011 AND ci.person_id<3059723;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>1987;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1143397;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>2006 AND mi_idx.info_type_id<101 AND mk.keyword_id=11745;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2004 AND mc.company_type_id=1 AND mk.keyword_id=21162;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<142234;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=11203 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id<7082;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1965 AND mk.keyword_id<64087;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=100 AND mk.keyword_id<135;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2011 AND mc.company_id<34 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>17069;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<800248 AND ci.role_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2009 AND mc.company_id>1675 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=3 AND t.production_year<2008 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2004 AND mc.company_id<137789 AND mc.company_type_id=2 AND mk.keyword_id>359;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<1955 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<2006 AND mc.company_id>464 AND mc.company_type_id>1 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id<101 AND mk.keyword_id=47696;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=2 AND t.production_year=1992 AND mc.company_id<71269 AND mc.company_type_id<2 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mi_idx.info_type_id<100 AND mk.keyword_id<6934;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2000 AND mk.keyword_id<8576;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<18790;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=4 AND t.production_year=1991;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=4 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2553389 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1969;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year>1934;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<728784 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1978 AND mk.keyword_id<35875;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>18048 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1913 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2010 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2031507;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=9452;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=11446;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND ci.person_id>3126683 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year>2006 AND mc.company_id>949 AND mc.company_type_id>1 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<923 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<1910;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>887321 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2008 AND ci.person_id>1918076 AND mk.keyword_id<12664;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=647 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<2009 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id<52544;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=3 AND mi.info_type_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id>58653;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<4 AND t.production_year=2013 AND mi.info_type_id>16 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=50279;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=10224 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=7463;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1996 AND mk.keyword_id<2706;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<1968 AND ci.person_id>2142114 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>30168 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id=72067;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2013 AND ci.person_id>2536472;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>2 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2007 AND ci.person_id<1621855;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=1567380 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=1997 AND mi.info_type_id>15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year>2012 AND mc.company_id<20036 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND mc.company_id>15987 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1996 AND mk.keyword_id<7633;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<20641;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>27 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=1107;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<15217;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_type_id=1 AND mk.keyword_id<12640;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<3888577 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>2004 AND mc.company_id>34 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<52362;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=2497;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id=48969;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<1975;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1960 AND mc.company_id<77508 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2009 AND mc.company_id<210036 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<4 AND t.production_year>1998 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_type_id<2 AND ci.person_id<77948 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<1979 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=10487;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=2 AND t.production_year>2008 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>86055;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mk.keyword_id<3508;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1520998 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1049589;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<535566 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<277760 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND ci.role_id<6 AND mk.keyword_id>2987;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<1959 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<3 AND ci.person_id>93945 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>3 AND t.production_year<1965 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1953;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3253131 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3706709 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<871 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1547564 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2008 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND mi.info_type_id>4 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<2005 AND mc.company_id<14405 AND mc.company_type_id=1 AND ci.person_id<2592313 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<1993 AND ci.person_id>934028 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<257963 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<2012 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=1988 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year=2008 AND mc.company_id=27 AND mc.company_type_id=2 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<1998 AND mc.company_id<54517;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year<1989;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id=1989239;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=990343 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=2285214 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2002 AND mi.info_type_id=15 AND mk.keyword_id>6406;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=3116;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<1933 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<17390;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2004 AND ci.person_id=3145887 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2011 AND mk.keyword_id=7789;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND mi.info_type_id>3 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>2 AND t.production_year<2000 AND mc.company_id<12673 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND ci.person_id>2378251 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year=1917;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2012 AND ci.person_id>1733930;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id=12764;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2012 AND mc.company_id<82 AND mc.company_type_id<2 AND mk.keyword_id>6071;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>11554 AND mc.company_type_id>1 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=19770 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year=1983 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2001 AND mc.company_id>772 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>7851;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=525;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2001 AND ci.person_id=1489933 AND ci.role_id<6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<2004 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<424 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3209414 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<500;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>1 AND t.production_year<2009;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2013 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<2 AND t.production_year<1998 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mi.info_type_id>4 AND mk.keyword_id=2988;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=2001 AND mc.company_id=1427;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>2007 AND mc.company_id<1407 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=92197;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<1994 AND mi.info_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id=315;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id>2082;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=13241;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1171279 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<2 AND t.production_year<2004 AND mi.info_type_id<105;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2012 AND mk.keyword_id<643;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<33660;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>6308;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<64;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<2001 AND ci.role_id>8 AND mk.keyword_id>5679;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<1985 AND ci.person_id<1094577 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<19842;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<1993 AND mk.keyword_id>1079;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1997 AND mk.keyword_id=10644;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2082466 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id<3636;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<1977 AND mi.info_type_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id<11 AND mk.keyword_id>4095;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<2011 AND ci.person_id>2853378 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1915 AND mi.info_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=3 AND t.production_year>1997;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2011 AND ci.person_id>595907 AND mk.keyword_id=2958;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2006 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year=1940;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year>2006 AND mc.company_id<29217 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=1983 AND ci.person_id>1097557;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>4959;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>12104;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=87539;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>1902 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>20758;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2416556;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2004 AND mk.keyword_id<831;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<1254 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>72051 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<2 AND t.production_year=1910;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>7271;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<4 AND t.production_year=2001;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<1995 AND mi.info_type_id>1 AND mk.keyword_id=11985;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3176978;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=1861698;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>4 AND t.production_year>1960 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<1964 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=1984 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>1957 AND mc.company_id<312 AND mc.company_type_id=2 AND mi.info_type_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>1994 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND ci.person_id>1805302 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>1973 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=62202;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year<2010 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mi.info_type_id=15 AND mk.keyword_id>60374;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1990;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<18430;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=2011 AND mc.company_id<6893 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1944;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<2011 AND mi_idx.info_type_id=100 AND mk.keyword_id>12249;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>2011 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>19968;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<3 AND t.production_year>2010;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>2 AND mc.company_id>33408 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>460;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>2321121 AND ci.role_id=2 AND mi.info_type_id<18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<3 AND mi_idx.info_type_id>100 AND mk.keyword_id=2488;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3917903;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year=2009 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=213004;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2011 AND ci.person_id>2339435 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id=98 AND mk.keyword_id>2088;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>38910;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>3418903 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>17711;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=1936;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2006 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>1970 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>38903;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<4 AND t.production_year=2005 AND mc.company_id<34 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=8131;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=4 AND t.production_year=1999 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<3062882 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<1977 AND mk.keyword_id<228;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>2013 AND mi.info_type_id>98;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=16724;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year>2008 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id=20001;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id<2788618 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=2007 AND mk.keyword_id>14544;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=3 AND t.production_year<1965 AND mi.info_type_id<16 AND mk.keyword_id<10030;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<2 AND t.production_year>1968 AND ci.person_id<3893598 AND ci.role_id>1 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=3137931;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>29599 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<123007 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<2009 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=1996 AND mc.company_id=114 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1982 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>2010;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2002 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<4 AND t.production_year<2004 AND mk.keyword_id=1126;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<968962;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<2012 AND ci.person_id<2184242 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=2006 AND mk.keyword_id=29960;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<2978;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>5521 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id>738576 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=1918 AND mk.keyword_id>12334;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2010 AND mi_idx.info_type_id=100 AND mk.keyword_id<2099;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=12308 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year<2009 AND mc.company_id>19 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=3046;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>2449;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<2004 AND ci.person_id>2198068 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>2010 AND mc.company_id>1275;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year<2004 AND ci.role_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=18656;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<24857;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>11026;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<4234 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id<7 AND t.production_year>1944;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<6 AND mc.company_id<43866 AND mc.company_type_id<2 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>1351 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=2010 AND mi_idx.info_type_id>100 AND mk.keyword_id>3394;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year>1927 AND mk.keyword_id=6291;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<2003 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2126101 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1982 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1921 AND mi.info_type_id<108;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=675;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>2011 AND ci.person_id<842227 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>11253 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id>536;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>7384;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2000 AND mk.keyword_id=2418;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>61;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1969;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<155298;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>2006;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=2000 AND mi.info_type_id>87;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>5169;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2752575 AND ci.role_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year=1967 AND ci.person_id>2132679;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>452 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<1968 AND mc.company_id>33829 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<14131 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<1989 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3896215 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1984 AND ci.person_id>2229520 AND ci.role_id<4 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>4 AND t.production_year<1989;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year>2001 AND mc.company_id>4114 AND ci.person_id>843779 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>2005 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1534530;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1976 AND mk.keyword_id=359;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2013 AND ci.person_id<2331224 AND ci.role_id>3 AND mk.keyword_id<61198;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=1624;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=16507 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=1915 AND ci.person_id>389281 AND ci.role_id>2 AND mi.info_type_id<9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year<2012 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id<1648266 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<62321 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>2559280 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=100 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=20662;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year>1985;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND mc.company_id=11146 AND mc.company_type_id=2 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=1985 AND ci.person_id>481349 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2009 AND mk.keyword_id<10468;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=2013 AND ci.person_id>1051577 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1962 AND mi.info_type_id=7 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>1735020 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2188106 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=1979 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND ci.role_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1137052 AND ci.role_id>9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<122 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1997;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND mk.keyword_id=9274;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND ci.role_id>2 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year>1957 AND mk.keyword_id=2809;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<3043299 AND ci.role_id<4 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year=2012 AND mc.company_id<11209 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id>1405537 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=1 AND t.production_year<2011 AND ci.person_id=2827559;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>1975 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=2 AND t.production_year=1956 AND ci.person_id<913277 AND ci.role_id>1 AND mi.info_type_id<107;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<76379 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2009 AND mk.keyword_id=17822;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>13502 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<1977 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<22212 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<85125;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<11340;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>3 AND ci.person_id>447839 AND ci.role_id<2 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id=32562;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2010 AND mi.info_type_id<16 AND mk.keyword_id>20099;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year>1981 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2012 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=78199;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=5854;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<413172;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id>99 AND mk.keyword_id<20318;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND t.production_year<1989 AND mc.company_id>1942 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND mi.info_type_id=17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<311;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year=1989;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<922103 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>915985 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year<2007 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=1363705;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<2004 AND mk.keyword_id=17683;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1019415 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=4 AND t.production_year>1997;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2010 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND ci.person_id<3847619 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id<7979;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND ci.person_id=1257579;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id=2528541 AND ci.role_id<3 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=1595;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2011 AND mk.keyword_id<674;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=1957 AND ci.person_id>1574959;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=1986 AND mk.keyword_id<782;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<3446032;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2001 AND mc.company_id=56793 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>3618410 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3207788 AND ci.role_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>2 AND mk.keyword_id<347;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>3393;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<2005;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>1990 AND mc.company_id<19668;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2303635 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1965 AND mk.keyword_id=15565;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2009 AND mk.keyword_id<4370;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2006 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND mk.keyword_id>25667;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3422633 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<662421;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1831853 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>37129;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>4 AND t.production_year=2012 AND mc.company_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<5813;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<419 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2110146 AND ci.role_id<9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=121078 AND ci.role_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=14569 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=2000 AND mc.company_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<199532;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>256407;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id<4 AND t.production_year<1964;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year>2008 AND mc.company_id=90331;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>3681;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=724;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year=2011 AND ci.person_id=2008367;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<2 AND ci.person_id>495419 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=384516 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1147437;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1965 AND mk.keyword_id=7464;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id<3 AND mk.keyword_id=5640;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2006 AND mk.keyword_id=18409;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>907769;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<29027;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<7340 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>1954 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2012 AND ci.person_id<3080508 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=2003 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1986 AND mi.info_type_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=2004 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2108994 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=1967 AND ci.person_id<643234;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2012 AND ci.person_id<2547034 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=44065;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<28339;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<1973 AND mi.info_type_id>6 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<149 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<1965 AND mk.keyword_id<24436;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3205176 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<1968 AND ci.person_id<2459994 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>7635;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=778827 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<3026493 AND ci.role_id=10 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<1015;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>2007 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=1 AND mc.company_id<1371 AND mc.company_type_id>1 AND ci.person_id<163891 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND ci.person_id<3318933 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=47874 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=2949296 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>16509;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1895579 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=23391 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1949 AND mk.keyword_id>26781;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year=1994;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=6 AND t.production_year>2008 AND mk.keyword_id>9857;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<850493 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id=66;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<4 AND mk.keyword_id=3660;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=2005 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1176576;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1996 AND mc.company_id>182956 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2006 AND ci.person_id>360986 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>1972 AND mk.keyword_id>8918;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<303501;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=32124;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1840563 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=1996 AND ci.person_id<1128758 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<3111;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2012 AND mk.keyword_id>16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<1928 AND mi.info_type_id>15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>1982 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=1968 AND mk.keyword_id<3221;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>524887;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>10922 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>14603;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>8597;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2009 AND mk.keyword_id=78939;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2007 AND mk.keyword_id>2137;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<18529;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=4 AND t.production_year=2004 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>10114 AND mk.keyword_id>8670;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2009;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>2007 AND ci.person_id>1645406;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<1396961 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2007 AND ci.person_id>1031664 AND ci.role_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<159 AND mk.keyword_id>335;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<1989 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<71671 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>4626 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND mi.info_type_id<103 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id=3046961 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>4591;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<197598;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<11041;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=15690;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=1908;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id=14340;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2000 AND mi_idx.info_type_id>101 AND mk.keyword_id<371;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<1595;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=2005 AND mc.company_id<116168 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=238639 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1987 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id<1707;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<39015 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=20344;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>1977 AND mc.company_id>12743;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1980 AND mk.keyword_id>4882;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>1011824;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<1980 AND ci.person_id<2184796 AND ci.role_id>4 AND mk.keyword_id>1587;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1987 AND mk.keyword_id<724;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mi_idx.info_type_id<101 AND mk.keyword_id<2359;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2808271 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>2077166 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1985 AND mk.keyword_id=245;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>3 AND t.production_year<1976 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<7682;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2009 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1710315;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1966 AND mc.company_id>40377;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=2 AND t.production_year>2008 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=2007 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=7487 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=2011 AND ci.person_id>2090149 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1259067 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1771955;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1997;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=1975 AND mk.keyword_id>20342;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<53322;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2000 AND mc.company_id<11244;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>13392;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>81959;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>69206 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>5591;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=944;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<265 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1725678 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year=1997 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<15804 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mi.info_type_id>2 AND mk.keyword_id>18297;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=1990 AND mi.info_type_id>15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2006 AND mc.company_id<708;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<3 AND t.production_year<2013;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=2010 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=1998 AND mc.company_id<12151 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1138153 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND ci.role_id>2 AND mi.info_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=1668;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1993;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=4 AND t.production_year=2008 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<1930 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=1999 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>339;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year=1966 AND ci.person_id>3377109 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>850358 AND ci.role_id>1 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>2010 AND ci.person_id<2124860 AND ci.role_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id=741 AND mc.company_type_id=1 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3306312 AND ci.role_id=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=27075;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=648 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND ci.person_id<1673546;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id>2637708 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id=23977;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=191224;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2003 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<2004 AND mk.keyword_id>44094;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2003 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=2011 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year=2009 AND ci.person_id>737234;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id>5037;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2893981 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=3991;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>16138 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND mc.company_id>21705 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1959 AND mk.keyword_id>3154;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<2003 AND mi.info_type_id=3 AND mk.keyword_id=783;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year=1977 AND mc.company_type_id>1 AND ci.person_id<3407843 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=73481 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<1987 AND mi_idx.info_type_id<101 AND mk.keyword_id>5374;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2007 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>1900 AND mc.company_id>119949 AND mk.keyword_id<19131;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<646110 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id=3175898 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=4 AND ci.person_id>2664673 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<2009 AND mk.keyword_id<5766;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year=1992 AND mc.company_id>11203 AND mc.company_type_id=2 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>7524;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=1969 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<29186;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>2 AND t.production_year>2010 AND ci.role_id>1 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id>98 AND mk.keyword_id<8454;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>31913;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<1989 AND mi.info_type_id<15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2004 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2003 AND mi.info_type_id=8 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<1985 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id>10316;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>1966 AND mk.keyword_id>108;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year<1911 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1914 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>1970 AND ci.person_id<2620054 AND ci.role_id<4 AND mi.info_type_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>3618;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<71360 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1940 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3123422;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<2012 AND mc.company_id<14038 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>520862;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1977 AND mc.company_id=17460 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=1972;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<4 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2005 AND mk.keyword_id<16141;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>180997 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=1947 AND mc.company_id>67911 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<1945 AND mc.company_id>663;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>2012 AND ci.role_id=1 AND mk.keyword_id>92804;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1969 AND mk.keyword_id>5445;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>1958;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=9557;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2011 AND mc.company_id>6008 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<11792;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<1260 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=14913;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year<1988;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=22133;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<846 AND mc.company_type_id=2 AND mk.keyword_id=4333;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>1958;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2010 AND ci.person_id>999029 AND ci.role_id=3 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1967 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND mk.keyword_id<5549;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>11377 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>2006 AND ci.person_id>3424824 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=1969 AND mc.company_id<24466;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>2298 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=4607;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=313 AND mc.company_type_id<2 AND mi.info_type_id<18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1995 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND mk.keyword_id<310;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<63 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=28339 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1602074;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2902560;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>1965 AND ci.person_id>1677678 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=86997 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>2 AND t.production_year=1970;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2005 AND mc.company_type_id=2 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>2012 AND mi.info_type_id<108;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<22672 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2345931;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=51149;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2399269 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<1958 AND mi.info_type_id=98;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>3 AND t.production_year<2003 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2009 AND mk.keyword_id=2401;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=23268;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>2012 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=2001 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year=1963 AND ci.person_id>565167 AND ci.role_id<10 AND mk.keyword_id<2276;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2943324;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=1990 AND mi.info_type_id>2 AND mk.keyword_id<247;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<6 AND t.production_year=1997;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>76208 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mc.company_id>5099 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1981;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1306541 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2007 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=1997 AND ci.role_id>6 AND mk.keyword_id=12080;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<4333;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=280445 AND ci.role_id<3 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2010 AND mk.keyword_id>29317;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1998 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=1968 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2011 AND mi_idx.info_type_id<100 AND mk.keyword_id<27642;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2008 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id<1748;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2009 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>159 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>262;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>11849;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1980 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<6 AND t.production_year<2012;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>3 AND mk.keyword_id>10926;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1938 AND mi.info_type_id>3 AND mk.keyword_id>9316;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<15937;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<225;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<2003 AND mc.company_type_id<2 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>2003 AND mc.company_id>2187 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=4 AND mc.company_id<71767 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1860955 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<2 AND t.production_year=1970 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2000 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=7732;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1997 AND mi.info_type_id>1 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=79126 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=56116;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>27864;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<1991 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<1999 AND mk.keyword_id=918;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=398;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<14075;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND mc.company_id>166;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=2008 AND mi_idx.info_type_id<100 AND mk.keyword_id>2330;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.role_id<4 AND mk.keyword_id=2053;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1948 AND ci.person_id<1709149 AND ci.role_id=3 AND mk.keyword_id>10018;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1150074 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=11322 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=5961;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<3 AND mk.keyword_id<2346;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>1990 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<2 AND mk.keyword_id>14586;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=6772;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2011 AND mk.keyword_id<7329;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2010 AND mi.info_type_id=2 AND mk.keyword_id>270;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<4992 AND mc.company_type_id=1 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>1975;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<2010 AND mi.info_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1986 AND mk.keyword_id<1738;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>4 AND t.production_year<1979 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1991;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<27228;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<809378 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2012 AND mc.company_id>223212 AND ci.person_id<659932 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1690014 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND mk.keyword_id>2297;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<7350;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<6887;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2002 AND mk.keyword_id>14873;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<252 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2075441;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<917;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=1959 AND mc.company_id<19 AND mi.info_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2013 AND mk.keyword_id=4682;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND mi.info_type_id=2 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=3252229;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=24754;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2886098;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<147344;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=1980 AND mi.info_type_id>105;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<2005 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>1997 AND ci.person_id<2935346 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1824755;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND mi.info_type_id<5 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>8559 AND ci.person_id>2378369;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>24663;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>851026;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>44736;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>1914;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>1989 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year>1961 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2009 AND mc.company_type_id<2 AND mk.keyword_id=1084;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<4 AND t.production_year<2008 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<2717748;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<2006 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1998 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=7436 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=925499 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id>77798 AND ci.role_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<1512033 AND ci.role_id>4 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id=11387 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>2011 AND mc.company_id<12208;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>374402;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2006 AND mc.company_id>2609;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<2 AND mi.info_type_id<13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=3473 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>2 AND t.production_year=2004 AND mc.company_id=452 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<2082;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>55849 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2598401 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>403347 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year<1994 AND mc.company_id<517 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year>1991 AND mc.company_id<657;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<1950 AND mk.keyword_id>536;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=1914 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=2002 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>3 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<4 AND t.production_year=2000;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=3 AND t.production_year<1999 AND mc.company_id>3099 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>1986;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<2010 AND mi.info_type_id>18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year<1983 AND mc.company_id>73394 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<1914;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2006 AND mc.company_id>166956 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND t.production_year<1999 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=1992 AND mi.info_type_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=2007 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id<2930876;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<13769;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<2005 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id>4452;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>11414;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>60918;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=561;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<40688;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mc.company_id=1134;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id<150;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2176774;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<1952 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=2002 AND ci.person_id>2737181;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=580164 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<192;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3444009 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>1423112 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=9453;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1976 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2013 AND ci.person_id<3146531 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2005 AND mk.keyword_id>4196;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year=2001 AND mk.keyword_id=414;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id>2215370;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>126767;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>2011 AND ci.person_id<1038895 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=312 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=2002 AND mk.keyword_id<16131;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2006 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND mc.company_id>26466 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2006 AND ci.person_id=962623 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>9044 AND mc.company_type_id=1 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year>2004 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=6739;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=1998 AND ci.person_id>429179;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year>1992 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2001 AND ci.person_id<2651564 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>28355 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2006 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<1912 AND ci.person_id>245049 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<1998 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.role_id<7 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<2013 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=13784;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=1085 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=3 AND t.production_year>2010 AND mc.company_type_id<2 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=2008 AND ci.person_id=2719745 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year=2005 AND mc.company_id>439;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<11866;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND mc.company_id<102992;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_type_id=2 AND mk.keyword_id>89376;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<74262 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>2007 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id=784;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<4 AND t.production_year<2010 AND mk.keyword_id>33685;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND mi.info_type_id=106;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=9366;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND mi.info_type_id>4 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2641451 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<91629;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>2012 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2008 AND mk.keyword_id<15919;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=7135;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<1501 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND mi.info_type_id=61 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<50503;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<866;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year=2005 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mi_idx.info_type_id>99 AND mk.keyword_id<370;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND mc.company_id>24088 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1353911 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<9152 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_type_id=2 AND ci.person_id=232691;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=62728 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>2 AND t.production_year<1983;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<29678 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=2 AND t.production_year<2008 AND mk.keyword_id=21304;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=31738;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1961 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id=2801527 AND ci.role_id>1 AND mk.keyword_id<47;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2760940;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id<101 AND mk.keyword_id<309;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>178590 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1995 AND mi_idx.info_type_id<101 AND mk.keyword_id<5376;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2011 AND ci.person_id=1661259 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>1877;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year<2013 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id=21397;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id=3173;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<1286 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>46847;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<3 AND t.production_year>2007 AND mk.keyword_id=3908;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=26012 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>1204 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<5507 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>141751 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<3 AND t.production_year>1969 AND ci.person_id<3174747;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<1975 AND mi.info_type_id=18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<2011 AND ci.person_id<2442261 AND ci.role_id=1 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>2849 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=665;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=2005 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>36307;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=1995 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id<100 AND mk.keyword_id>7844;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1296893 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=8178;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=20015;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2012 AND ci.person_id<269589;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<1953 AND mi.info_type_id>1 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<4 AND t.production_year>2009 AND mi.info_type_id>2 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>2 AND t.production_year=2000 AND mc.company_type_id=1 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=3 AND t.production_year=2008 AND mk.keyword_id>35668;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1396996 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1997 AND ci.person_id<2801644 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year>2001 AND ci.person_id<2169071 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1983 AND ci.person_id>1949705 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<10584 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2011 AND mk.keyword_id<16195;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id=8977;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=240;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<2013 AND mk.keyword_id<3660;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id<102;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year=1992;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=6 AND t.production_year>2001;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=2003 AND mi_idx.info_type_id=101 AND mk.keyword_id<1450;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>79646;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<2004 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<3 AND t.production_year>2000 AND ci.role_id>2 AND mk.keyword_id=6379;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1303945;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1089321 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2006 AND mk.keyword_id>348;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<16962;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>1582560 AND ci.role_id>8 AND mk.keyword_id<4433;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=1995;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=1925 AND mc.company_id>160;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<1353641 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=90507 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>1880177 AND ci.role_id>3 AND mi.info_type_id=80;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<88454;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<305;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mc.company_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=23893;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2701836;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id=1080 AND mc.company_type_id=1 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>2 AND t.production_year=2012 AND mc.company_id<2302 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=3 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>1740619 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year=2010 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year>1993 AND mc.company_id>12 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<27177 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=101 AND mk.keyword_id=7105;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1137178;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>4 AND t.production_year=1999 AND mc.company_id>11379;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<8925;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2009 AND mi.info_type_id<6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mc.company_id<11776 AND mk.keyword_id=25307;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id<16 AND mk.keyword_id<28414;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND ci.person_id>1665233;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1913 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=1987 AND mi_idx.info_type_id=99 AND mk.keyword_id<347;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<2008 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=2318950 AND ci.role_id<8 AND mi.info_type_id<13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<18414;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year>1941 AND mk.keyword_id=24382;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2005 AND mk.keyword_id=2155;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<1997 AND ci.person_id>2403322 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=2001 AND mk.keyword_id>7936;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id>975687;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<3 AND t.production_year=2008 AND mk.keyword_id<2554;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<1993;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2006 AND ci.person_id>2510530;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id<1081211 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=54640;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=2007 AND mk.keyword_id>16500;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1956 AND mi.info_type_id=13 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2011 AND mk.keyword_id<16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2011 AND mc.company_id>11;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<22876 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<1994 AND mc.company_id>184 AND mc.company_type_id=2 AND mk.keyword_id=196;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=42528;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>16489;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year=1960 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND ci.person_id<3099303 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2007 AND mk.keyword_id=7692;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<3827817 AND ci.role_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1979 AND mi.info_type_id=16 AND mk.keyword_id>875;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year>1950;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<1378;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<16909 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2007 AND mk.keyword_id>36969;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>3554613;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=6 AND t.production_year>2011 AND ci.person_id>1131659;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=1993 AND mk.keyword_id<5587;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND ci.person_id<986195 AND ci.role_id=1 AND mk.keyword_id=3253;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<35033;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND ci.person_id<3534845 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2602498;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<3 AND t.production_year=1991;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<19075;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2010 AND mi.info_type_id>18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=26814;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=419 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2005 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>1903 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=2000 AND mc.company_id<11185;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>280678;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<19664;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=113942;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND t.production_year<1993 AND mc.company_id=6 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2010 AND mi.info_type_id<108;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>72835 AND ci.person_id>11880 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<72034;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>2000 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<361578 AND ci.role_id<9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<6534;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1995 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=6307;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>68635;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=43462;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND ci.person_id=3422487;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=3283416 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=1731;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1968 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_info mi WHERE mi.info_type_id>93;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id<6 AND mk.keyword_id>1370;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.role_id=10 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2010 AND mk.keyword_id<3322;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1749092;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<419 AND mc.company_type_id>1 AND ci.role_id>9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<4 AND t.production_year<2006 AND ci.person_id>3975924;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>18669;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<1979 AND mc.company_type_id>1 AND ci.person_id>4034290 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>42898;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<1984 AND mk.keyword_id>910;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1975 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>1968 AND mi_idx.info_type_id>99 AND mk.keyword_id>3910;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1960 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=1997 AND mi.info_type_id>8 AND mk.keyword_id=5031;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND ci.person_id=3065181 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<1989 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>1957 AND mc.company_id>27581 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=4 AND mk.keyword_id>103;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year<2010 AND mc.company_id<401 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<50132;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2005 AND mc.company_id<288;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=1985 AND mi_idx.info_type_id=99 AND mk.keyword_id=66;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<1969;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mi.info_type_id=16 AND mk.keyword_id<11662;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=240 AND mc.company_type_id=2 AND mi.info_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<1963 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<4 AND t.production_year>2009 AND mk.keyword_id>359;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>307957;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<2017 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1960 AND mi.info_type_id<8 AND mk.keyword_id=1409;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id=16191;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1014810;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=2 AND t.production_year<1978;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1974;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<1954;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<6 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>2002;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=11302;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1984 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<2003 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<74927;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<1991 AND mi.info_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2008 AND mc.company_id<930 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=1993 AND ci.person_id>1013195 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2001 AND mk.keyword_id>335;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1989 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=10893 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND ci.person_id<3268224;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=2293745 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1975 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<196;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=751 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=1741;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<1086;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=28315;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>882457 AND mk.keyword_id<1749;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>61603;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1961;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>958 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=75176 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2010 AND mk.keyword_id=16411;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND mc.company_type_id=2 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2007 AND mk.keyword_id>151;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<12507 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2874637 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=1402330;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2008 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year<1946 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1997 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=30562 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<51767;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<14300;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id=3046083 AND mk.keyword_id>875;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>2 AND t.production_year<2008 AND mc.company_id>164 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>49956 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>2006 AND ci.person_id>78503;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<2013 AND mc.company_id<258 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2012 AND mi_idx.info_type_id<100 AND mk.keyword_id>1742;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>2013 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year<2000 AND mc.company_id>79928;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1998 AND ci.person_id<1781828 AND ci.role_id<2 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=1974 AND mi.info_type_id>18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<1964 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=8094;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=2004 AND mk.keyword_id=7405;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1213951 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year=2009 AND ci.person_id>1407923;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1986;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<3 AND t.production_year>2012 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>184;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=1996 AND mc.company_id=6 AND mc.company_type_id>1 AND mk.keyword_id<893;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=1975 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=586;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>2 AND t.production_year>1986 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<169375 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<1942 AND ci.person_id<2798687;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=52465 AND mc.company_type_id>1 AND mi.info_type_id<107;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2009 AND ci.role_id=1 AND mk.keyword_id<20504;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2012 AND mi.info_type_id>17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year<1976;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<3771135 AND ci.role_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2009 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>14178 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>2659644 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>1992;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<36301;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>61421;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<2007 AND mc.company_id<50752 AND mc.company_type_id>1 AND mk.keyword_id=27111;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<8191;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<3807053 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year>2008 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>10836;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>3431;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND ci.role_id<8 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3353432 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>347570;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>1996 AND ci.person_id>2583306 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1638734 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>2013 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>2868 AND mk.keyword_id>13166;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year>1940 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<2 AND t.production_year>2006 AND ci.person_id>1082487 AND ci.role_id<10 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<6429;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=3784;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND ci.person_id=2980455;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND mc.company_id<156232 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2011;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2803066 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>11156 AND mc.company_type_id=1 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<6428;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>2985698 AND ci.role_id<8 AND mk.keyword_id=32539;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<1959;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<2 AND t.production_year<2012 AND mc.company_id>19 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>2006 AND mi.info_type_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<14735 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<1992 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>2012 AND mi.info_type_id=18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>228803;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND ci.person_id>235435 AND mi.info_type_id>15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>2025 AND mk.keyword_id>1613;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>2 AND mi.info_type_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year>2000 AND ci.person_id=2494163 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=2985968;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<521 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3933085;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=2 AND mk.keyword_id<263;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=44292 AND mc.company_type_id=1 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>117591;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=164704;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year<2011 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3292284 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<2011 AND mi.info_type_id>94;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<3273830 AND ci.role_id>1 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2825009;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=2008 AND ci.person_id=639599;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=3262;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<2003 AND ci.role_id<2 AND mk.keyword_id<2488;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2315489;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1924 AND mk.keyword_id=335;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<611494;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2008 AND mc.company_id<38180 AND mk.keyword_id=11879;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=1985 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=1993 AND mk.keyword_id>5958;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<1999 AND ci.person_id=3147384;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=111 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=1984;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year>1972 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<826823 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=101 AND mk.keyword_id=13887;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<1982 AND mc.company_id=19 AND mc.company_type_id=2 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id=480;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1994 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND mc.company_type_id<2 AND mi.info_type_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<1563330 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=2012 AND mk.keyword_id<382;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=663;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2830931 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1567398;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>7723;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id=2 AND mk.keyword_id>7731;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=5889;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2002 AND mk.keyword_id<2578;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<1834;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2013 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>1972 AND mc.company_id>6227 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1993 AND mk.keyword_id<9465;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<3 AND t.production_year<1918;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>525 AND mc.company_type_id<2 AND ci.person_id<1067255 AND ci.role_id<11;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id=1116;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<1588823 AND ci.role_id<2 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3868405;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2005 AND mc.company_type_id=1 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>11723;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<252;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<1953 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1711439 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<5810;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<3 AND t.production_year>2013;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<4 AND t.production_year=2006;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=1986;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=2005 AND mc.company_id<6 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>2 AND t.production_year<2000;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<83503 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<1386107 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=887636;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_type_id<2 AND ci.person_id>2925820;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>2 AND t.production_year>2000;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year<1966;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND mi.info_type_id<3 AND mk.keyword_id<8012;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<649;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<4 AND t.production_year>1987;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mk.keyword_id=2085;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=7 AND t.production_year>1928;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2008 AND mk.keyword_id<118234;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<2007;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id>10313;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id<418562 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=101205;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2000 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>8800;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>1283 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1877031;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<4 AND t.production_year<2002 AND mc.company_id>26971 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>190721 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<2003 AND ci.person_id>2336717;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND t.production_year>1989 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.role_id=2 AND mk.keyword_id=41270;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<1587098;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=214491 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>8681 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=70096;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1985 AND mk.keyword_id=3393;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>219872 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2008 AND mk.keyword_id<9499;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>4 AND t.production_year>2012 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>2010 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>2004 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>2000 AND mi.info_type_id=18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2010 AND mc.company_id<131104 AND mc.company_type_id=1 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=3128594 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2008 AND mi.info_type_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1987 AND mk.keyword_id>335;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year=2013 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=2 AND mk.keyword_id=5899;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>24860;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<3117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>85419;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=836 AND mc.company_type_id=1 AND mk.keyword_id<355;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id<16515;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2012 AND mc.company_id=72109 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<84 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>77353;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year=1993;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1911 AND mk.keyword_id>249;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>1982 AND mc.company_id=1327 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id=16 AND mk.keyword_id<70878;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2013 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id>99 AND mk.keyword_id>20342;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>3683;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=7272;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=110364 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>45454 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<17704 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>322275;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=11226;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<3794 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<2012 AND ci.person_id=1041011 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1954 AND mk.keyword_id=8800;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=105391;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<1347 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=3 AND ci.person_id>914551;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=2006 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=2 AND t.production_year<1997 AND mk.keyword_id=2403;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=2012 AND ci.person_id<2732697 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2006 AND ci.person_id>2356313 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2381865;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND ci.person_id=1325281 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id=3662;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2008 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>16915;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<3 AND t.production_year=1988 AND mi.info_type_id>16 AND mk.keyword_id<5069;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year<1998 AND mc.company_id<11288 AND mc.company_type_id=1 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND mk.keyword_id<419;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2580276 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>2 AND t.production_year=1999 AND mi.info_type_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=1967 AND ci.person_id<3638036;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<376291;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1998 AND ci.person_id=899949;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>2009 AND ci.person_id>1987090 AND mk.keyword_id>16144;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=2008 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id>117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=305 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=90570;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=677331;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>4 AND t.production_year>1969;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year=1985 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>1989 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>1969 AND mc.company_id=11185 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<1981 AND mc.company_id<125342 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<4 AND mk.keyword_id<13787;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>2 AND t.production_year<1993;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2005 AND mc.company_id>7696 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>24279;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>11387 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2012 AND mc.company_id>232074 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2005 AND mk.keyword_id>196;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<3 AND t.production_year=2007 AND mc.company_id>424;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<19732;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2007 AND mk.keyword_id<23070;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=2 AND t.production_year=2008;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<518;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<75641;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<45513 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>72526 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<1503324;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<72106;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1922;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>3 AND t.production_year>2005;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id=588152;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<1912;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>64071;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=2010 AND ci.role_id>4 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<481372 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=1959 AND mc.company_id<159;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<180824 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3060946;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=2007 AND ci.person_id=1132286;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2010 AND mk.keyword_id=3695;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1092764;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>234 AND ci.person_id<987868;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<3164891 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1210542 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>2011 AND mc.company_id=13204 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2011 AND mk.keyword_id>16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1723664 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>7661;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id=7 AND mk.keyword_id=3511;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=2 AND t.production_year>0;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year>2009;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<11339 AND mk.keyword_id<10093;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=1125330;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2951316;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2012 AND ci.person_id=2922734 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=6474 AND mk.keyword_id<20319;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id>101 AND mk.keyword_id>4500;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<1443;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<2012 AND ci.person_id<3796079 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>2012 AND ci.person_id>1272734 AND mi.info_type_id>17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year=1964 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>4 AND t.production_year>2011 AND ci.person_id>2264452 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=2012 AND mc.company_id<1408;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=17207 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>18630 AND mi.info_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_type_id=2 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=1974 AND ci.person_id<104199;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2591891 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>928701 AND mk.keyword_id=5928;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>4025 AND mk.keyword_id>115;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<1999 AND mk.keyword_id=353;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>24855 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=13269;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=2006 AND ci.person_id>1165308 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=2011 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>2010 AND ci.person_id<1902253 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1726818 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2339110;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>26432;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1712939 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>48370;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_info mi WHERE mi.info_type_id=109;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=86846;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>2008 AND mc.company_id<58725 AND mc.company_type_id<2 AND mi.info_type_id<18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<1998 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<3 AND t.production_year=2000;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>2012 AND ci.person_id=2127820 AND ci.role_id=2 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id>101 AND mk.keyword_id<57396;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=4360;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<1933 AND mi.info_type_id>103;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=1989 AND ci.person_id>1732302;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=78042;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year>2010 AND mc.company_id>68614 AND mc.company_type_id<2 AND mk.keyword_id<3040;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND mc.company_id<878 AND mc.company_type_id=2 AND mk.keyword_id>2365;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>2008 AND mi.info_type_id<6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id<2690;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<1964 AND mc.company_id<96786 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>1998 AND ci.person_id<3877236 AND mi.info_type_id>98;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1977 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=11865 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<1988 AND ci.person_id>3590147 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=38523 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1589475;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<51035;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>1952 AND mi_idx.info_type_id>99 AND mk.keyword_id>12109;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id<861839 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<2609 AND mc.company_type_id>1 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>379030 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=2010 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=55096;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=4625 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<640625 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=2001 AND mc.company_id=67;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<865;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2600955 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1969 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year=2010 AND ci.person_id<3744568 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=2012 AND mc.company_id<12751;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>78907 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<5026;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2011 AND ci.person_id>2173234 AND ci.role_id>3 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>1544;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1917;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year=1999;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<298091 AND ci.role_id<9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=44137 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=60766;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2010 AND mk.keyword_id=53226;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<1986 AND ci.person_id>1102055 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>1991 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<3 AND t.production_year=2009 AND mk.keyword_id>57731;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=2007 AND ci.person_id=3800935 AND ci.role_id>5 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<34390;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1950 AND mi.info_type_id=8 AND mk.keyword_id=10863;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<14978;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2000 AND mc.company_id<15005 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND ci.role_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1407353 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=94770;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<14436;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2013 AND mi.info_type_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>401 AND ci.person_id>1653351 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>2012 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=101 AND mk.keyword_id>4869;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>2011 AND mc.company_id=11127;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=1 AND t.production_year<1996;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=56043;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2013 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=1994 AND mc.company_id>51000;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=2826011;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2011 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=3335684 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=2009 AND mk.keyword_id=245;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<1982 AND ci.person_id<1435145;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<3 AND t.production_year=2008;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2010 AND mi_idx.info_type_id<101 AND mk.keyword_id<13448;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3332189 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year=1975 AND mc.company_id<15931 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2775582 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1932 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=8616;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>2006 AND mc.company_id=596;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id>7 AND mk.keyword_id<571;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>2164387 AND ci.role_id>10 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=2 AND t.production_year=1995;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<3 AND t.production_year<2004 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=937735;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND mi.info_type_id<3 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=2543190;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id=111169 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1985 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<7337;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>1196;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<84168 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<14263 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year>1987 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2013 AND ci.person_id<2713831 AND mi.info_type_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2000 AND mi_idx.info_type_id=100 AND mk.keyword_id>20152;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND mc.company_id=419 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=2850;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2000 AND mk.keyword_id=11931;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>1991 AND mi_idx.info_type_id=99 AND mk.keyword_id<4678;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id>65671;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1895049 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<1942 AND mk.keyword_id>39301;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2005 AND ci.person_id<2414505 AND ci.role_id=1 AND mk.keyword_id<94462;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<1987 AND mc.company_id<27;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND mc.company_id>73 AND mk.keyword_id<4196;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>1552546 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3582400 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=2009 AND mi.info_type_id=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<1999 AND ci.person_id<2336398 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<2 AND t.production_year>1975 AND ci.person_id<3182084 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=1992 AND mk.keyword_id=12888;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>99229 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<3016109;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<10414;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=21580 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id>1712;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<1004974;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<1775;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1670499 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=5579;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<52 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>3976923;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<1989 AND ci.role_id=1 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=11180;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=2518333;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>110481;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id>3961072 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<4625 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>2005 AND ci.person_id=1801897;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>85087;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2004 AND mk.keyword_id>50942;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2720610 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year<1976;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=1 AND t.production_year<1988;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=101 AND mk.keyword_id=6039;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>90974;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=4 AND t.production_year>1966 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<572129;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<51672;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2001 AND mk.keyword_id>9464;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1649323 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<2011 AND mi.info_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id=32627;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<104322;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>2449752 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>0 AND ci.person_id=1981756;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>210626;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1965;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year=1987;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<12904 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>1955 AND ci.role_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>28817;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=1994 AND mc.company_id>44018;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mk.keyword_id=658;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2013 AND mc.company_id<115184 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<631;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>2562;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year>2009 AND mi.info_type_id<105;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2004 AND ci.person_id<778452 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<22693;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<698822 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1937;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND ci.person_id<154911;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=2 AND t.production_year=1996 AND mk.keyword_id<2488;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2265757 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<13015 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=1956;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>2009 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=2010 AND mi.info_type_id=16 AND mk.keyword_id=3510;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2009 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year<1912 AND ci.person_id<2030726;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>19 AND mc.company_type_id>1 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1650825 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>2013 AND mi.info_type_id<15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=310061 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND mi.info_type_id=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<7563 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<14009;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>2004 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<2403;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>1399893 AND ci.role_id>6 AND mi.info_type_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<31342;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1325640 AND ci.role_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<11717 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=2002 AND mc.company_id>76217;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year>1974 AND mi.info_type_id<16 AND mk.keyword_id>992;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND mc.company_id>42954 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id=3194645;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=1040;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<2005 AND ci.person_id>319532 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<371686 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=54050;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>6 AND t.production_year=2011;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<2002 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<4 AND t.production_year<1989 AND mc.company_id<252;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.role_id>1 AND mk.keyword_id=4177;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2005 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id=2752;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2007 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<69415 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_type_id=2 AND ci.person_id>1519035 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2003 AND mc.company_id<118924 AND mk.keyword_id<3401;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year=1996 AND ci.person_id>1296693;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<1285;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id=990354 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<4515;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=58726;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>1964 AND mi_idx.info_type_id=99 AND mk.keyword_id=1046;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.role_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>1995 AND ci.person_id>50842 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>38680 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1939 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<78819 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND ci.person_id<2270381 AND ci.role_id>10 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year<1981 AND ci.person_id<1663961;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year=1980 AND mc.company_id<81952 AND mc.company_type_id=2 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>4 AND mc.company_id>1405;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id>7105;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1308661 AND ci.role_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<385;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=1969 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<137364;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=102998;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id<1400402 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=2009 AND mi_idx.info_type_id>99 AND mk.keyword_id=5767;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<2012 AND mi.info_type_id=15 AND mk.keyword_id<1657;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>2008 AND ci.person_id<929257 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=2021;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=2004 AND mc.company_id<229543 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=14918;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1417394 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2005 AND mc.company_id=29121 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<1997 AND ci.person_id=984234;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>2010 AND mc.company_id>13129;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id<959;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=657 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year<2003 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<30488;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<12065 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<2002 AND mi.info_type_id>3 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>2002 AND mi.info_type_id=8 AND mk.keyword_id<5234;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=8180;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=14008;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2013 AND ci.person_id>1423144 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=2005 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id=11252;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>317;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=29065;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>1915 AND ci.person_id<502217 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>12309;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id=15755;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1980 AND ci.role_id<10 AND mk.keyword_id>236;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>2415 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2010 AND mk.keyword_id=4777;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=85193;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year>1903 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=15105;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year>1958 AND mk.keyword_id<213;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2732626;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>4 AND t.production_year=2010;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=2013 AND mk.keyword_id=309;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<1958 AND mc.company_type_id=1 AND mk.keyword_id<2197;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>1919 AND mc.company_id<5259 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2000 AND mk.keyword_id>10018;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>41271;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>668154;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=2008 AND ci.role_id=4 AND mi.info_type_id<15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2924878;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=3 AND ci.person_id<1293203 AND ci.role_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2004 AND mc.company_id<74218;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND ci.person_id>955712 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>1131;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<2664312 AND mk.keyword_id<33730;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>11435 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<1995 AND ci.person_id<560076 AND ci.role_id=1 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1989 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=40855;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<4 AND t.production_year=2005;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=23042 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=1984 AND ci.person_id>1315454 AND ci.role_id<11;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1987 AND mk.keyword_id<24496;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>3 AND t.production_year>1974 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1996 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=1999 AND mk.keyword_id>2163;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<1350;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<11339 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=2 AND t.production_year<2007 AND ci.person_id<247753 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=19 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=1995 AND mc.company_id>83825 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id<2488;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=2001 AND ci.person_id<470347 AND ci.role_id>1 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id=3 AND mk.keyword_id=24241;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2791608 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<1071;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2010 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>1 AND ci.person_id<2346137;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=23663;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>540966 AND mi.info_type_id>18;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year>1915;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id<3384;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<1994 AND mc.company_id>11141;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>1571586 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<2007 AND mi.info_type_id<107;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year<2009 AND mc.company_id<33083 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>448 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1159923;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<115154;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND mc.company_id=1794;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1999 AND mk.keyword_id>4609;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>82215 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>1652779 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<2008 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=3982 AND mc.company_type_id>1 AND ci.person_id<402408;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<4 AND t.production_year>2008 AND mk.keyword_id>48982;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=2009 AND mc.company_id>302;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<773052;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id>961930 AND ci.role_id<9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<1980;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=1 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year<1953 AND mc.company_id<19 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<1904 AND mc.company_id>97694 AND mk.keyword_id<2109;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>1974 AND ci.person_id<394554 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<2008 AND mi_idx.info_type_id>101 AND mk.keyword_id>11764;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>71609;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=24248;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<3 AND t.production_year>2003 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=2466;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.role_id=3 AND mk.keyword_id<58638;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=7565;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND mk.keyword_id=918;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year<2011 AND mc.company_id>15192 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>82;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=8113;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>43763;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year>1957 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1948 AND mk.keyword_id>1584;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<105790 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=50942;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>2 AND t.production_year>2008 AND ci.person_id>1015120;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>2 AND t.production_year=1996 AND mc.company_id<72363 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=252 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>2008 AND mi.info_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year=2013 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<2005 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>3305375 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2104596;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND ci.person_id=3268003 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3311611;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=3 AND t.production_year>1981 AND mc.company_id=13630 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2001 AND mk.keyword_id<15267;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<27554;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.role_id=4 AND mk.keyword_id>2488;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>1991 AND mk.keyword_id=807;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year<1997 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=16708;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=100 AND mk.keyword_id<5443;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>2003 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2009;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<72622 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<3 AND t.production_year<2008 AND ci.person_id<606672 AND ci.role_id=1 AND mk.keyword_id<186;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=2009 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>1 AND t.production_year>1995;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>11541;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id>3 AND mk.keyword_id<32880;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=2005 AND ci.role_id=2 AND mk.keyword_id=20032;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<1969;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=1994 AND mk.keyword_id<4888;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<1979 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_type_id=1 AND ci.person_id>1688096 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>2005 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=11856 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id>12938;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<1993 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<5691 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>2059297 AND ci.role_id<10 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2009 AND mi_idx.info_type_id>100 AND mk.keyword_id>2551;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year=2013;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<23037 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<1966;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<2006 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>1499054 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<1985 AND mk.keyword_id=3987;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=3 AND t.production_year>1960;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year<1999 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>96797;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2012 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id>2346;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2009 AND mc.company_type_id=1 AND mk.keyword_id<1759;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3692156 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=34309;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=2561;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2541955 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=245;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>2011 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>4469;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2004 AND mk.keyword_id<395;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1450361;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=966218 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>0 AND mi.info_type_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id>7 AND mk.keyword_id>5208;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1994 AND mk.keyword_id>2238;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>1972 AND ci.person_id<1030799 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=2 AND t.production_year>2004;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=449;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2009 AND mi.info_type_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>6271;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=1999 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<2 AND mc.company_id>67 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1606613 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>10495;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>3090045 AND mk.keyword_id>465;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<1967 AND ci.person_id>519292;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=2007 AND mk.keyword_id<81098;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<1958 AND mc.company_id>12922 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<11418;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=4 AND t.production_year<1991 AND mk.keyword_id>1515;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND mc.company_id=19 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1975 AND ci.person_id<449724 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year<2010 AND mc.company_id>160;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1988 AND mk.keyword_id=16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1912 AND mk.keyword_id>7078;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1893465 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>12540 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<1998 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2005 AND ci.person_id=2431555;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>1992 AND mi.info_type_id<11;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<2 AND mi.info_type_id<2 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<2009 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id>5390;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>6 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=1989 AND mc.company_type_id<2 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2776337 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year=1994;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>2007 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=233723 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2895055 AND ci.role_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id<11483;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id<2124;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<166 AND mc.company_type_id=2 AND mi.info_type_id>104;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>2006 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<1958 AND ci.person_id<764565 AND ci.role_id>2 AND mk.keyword_id>2554;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<747353;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<1973;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id<23129;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>174540 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>2172839 AND ci.role_id<8 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>1916 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1023213 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1002465;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>1995 AND ci.person_id>630345 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<2372881 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND mc.company_id<1402 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year=2011 AND ci.role_id<2 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2305035 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=610 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1976 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=1990 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id>1463874 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2788480 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND mc.company_id>19 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<2011 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=2007 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=2003 AND ci.person_id<986535;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=46984;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<185302 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>2 AND t.production_year<2006 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1998 AND mi.info_type_id>18 AND mk.keyword_id<438;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year<2005 AND ci.person_id=877163;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=3 AND ci.person_id>1248559;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year>2004 AND mc.company_id>59402 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>1142;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<5295;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=426325;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<2987;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=63036;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<1951 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=7125;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2009 AND mi.info_type_id>17 AND mk.keyword_id<230;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=23486 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND ci.person_id<1366932 AND ci.role_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3554433 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>11863;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<452199 AND ci.role_id=2 AND mi.info_type_id<102;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=490167;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>27 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1954 AND mk.keyword_id=2913;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>2159745;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id>490;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=5239;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<3 AND mi.info_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=711262;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1917 AND mk.keyword_id<36083;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=1991 AND mc.company_id<27;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2014 AND mk.keyword_id=987;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1996 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1942 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_type_id=1 AND mk.keyword_id<55;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id>100 AND mk.keyword_id>2327;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<1938 AND ci.person_id<2290872 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND mi.info_type_id<4 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2011 AND mi_idx.info_type_id>100 AND mk.keyword_id<4725;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=9674;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>2 AND mi.info_type_id<6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>12383;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<1236;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id=83559;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<3 AND t.production_year>1996 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2011 AND mk.keyword_id=4853;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<2011;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2010 AND ci.person_id<3054241 AND ci.role_id=2 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>207 AND ci.person_id=3675751;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2001 AND ci.person_id>2536455 AND ci.role_id=11;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<2008 AND ci.person_id>2488690 AND ci.role_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>4002860 AND ci.role_id>4 AND mk.keyword_id>2560;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id=8315;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id=10936;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year>1991 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=11325 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=10414;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=21561;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<3728237;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<1981 AND ci.person_id>3128303;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1996 AND mk.keyword_id<15137;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2007 AND ci.role_id=1 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=74754;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND mc.company_id>1484 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>2006 AND mi.info_type_id>2 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND mc.company_id>18567 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=22047;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=4 AND mc.company_id<4963 AND mc.company_type_id=1 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND mk.keyword_id=2243;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<2187;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<1994 AND ci.role_id<7 AND mk.keyword_id=24922;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2000;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year<1977 AND ci.person_id<3488346 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<436 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id<101 AND mk.keyword_id=5299;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2961289 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mi.info_type_id>16 AND mk.keyword_id=2629;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.role_id=1 AND mk.keyword_id>56678;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>7050;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>2485853 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>4 AND t.production_year<2010 AND mk.keyword_id=2888;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND mc.company_id<124879;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<11203 AND mc.company_type_id=1 AND mi.info_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>15729;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<683645;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<4032196 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mi_idx.info_type_id<101 AND mk.keyword_id=398;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year=2010 AND mc.company_id=1318;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=1996 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2013 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=4 AND t.production_year<1984 AND ci.person_id<2554781 AND ci.role_id=3 AND mk.keyword_id<23739;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<473870 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<29456;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<4 AND t.production_year<1992 AND ci.person_id>1087495;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2016989 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1457695 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2005 AND mc.company_id<302 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2010 AND mc.company_id<13989 AND mk.keyword_id>335;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2001 AND mi_idx.info_type_id<100 AND mk.keyword_id=2935;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id>95982;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<1996;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>1967 AND mk.keyword_id=3999;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<1998 AND mc.company_id<27092 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<8739;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1907;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>2041548 AND ci.role_id>2 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<56907 AND mc.company_type_id>1 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<2006 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3512472;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<1953;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=1993 AND mk.keyword_id<1732;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<941592 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<687 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>4 AND ci.role_id>4 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=793;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND mi.info_type_id=94;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2004 AND ci.person_id<2767784;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1388683 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=610 AND mc.company_type_id=1 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1985 AND mi.info_type_id>16 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2010 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=3037;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=12943;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND mc.company_id<49249 AND mc.company_type_id=2 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<676631 AND ci.role_id<10 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=1965 AND mc.company_id<93661;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=101 AND mk.keyword_id=348;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2013 AND ci.person_id<250764 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year<2012 AND mc.company_id>40462 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2005 AND mk.keyword_id<2021;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<1987;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_type_id=1 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=81010 AND mi.info_type_id<13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year<2007 AND mc.company_id<428;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>4 AND t.production_year<1995 AND mc.company_id<93911;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>2004 AND mi_idx.info_type_id=99 AND mk.keyword_id>33463;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year>2010 AND ci.person_id<1720440;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2539487 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<2004 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id=1238268;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<9505;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id>7 AND mk.keyword_id=2418;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2011 AND mk.keyword_id<16785;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year>1981 AND ci.person_id<578210 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=1 AND t.production_year<2010 AND mc.company_id<80806 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1961 AND mk.keyword_id=3792;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<953;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1956 AND mk.keyword_id>5204;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year<1986 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<2629132 AND ci.role_id=3 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2003 AND mk.keyword_id=59595;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1106503;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=2004 AND ci.person_id<3532055 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>979;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>3099 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>44018 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<2013 AND mi.info_type_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<78917;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1840921 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=20605 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year>2010 AND ci.role_id>1 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1960 AND mc.company_id<56246 AND mc.company_type_id<2 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=522656;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<1961 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_type_id=2 AND mi.info_type_id<106;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<1997 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1740619 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<2887;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>3020619 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1965 AND mi.info_type_id=98;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>2007 AND mc.company_id<11238 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=2007 AND mc.company_id>22158 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<988538 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2498317;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3264004;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<1991 AND mi.info_type_id<6 AND mk.keyword_id=2943;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<823;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year>2001 AND ci.person_id<3928178;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND ci.person_id>559135 AND ci.role_id>10 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>1 AND mc.company_id>82069 AND mc.company_type_id=2 AND ci.person_id>2027100 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year=2012 AND ci.person_id<2741651 AND ci.role_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<1989 AND mc.company_id<18810 AND mk.keyword_id<264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id=2561;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3538735;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>2009 AND mi.info_type_id=16 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=16402;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2008 AND mc.company_id>1308;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND mc.company_id>166;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=2 AND t.production_year>2003 AND mk.keyword_id>2199;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>2006 AND ci.person_id<2389310 AND ci.role_id<3 AND mi.info_type_id<17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>3 AND t.production_year<2012 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND ci.person_id<1954001;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<1952;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2003 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>64604;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>15795;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>4 AND mk.keyword_id=4297;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mc.company_id<94995 AND mk.keyword_id>186;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND mk.keyword_id=79749;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<4 AND t.production_year>2008 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year<2009 AND mc.company_id=143299;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND mi.info_type_id>9 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<42432 AND mc.company_type_id=2 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2008 AND mc.company_id=77349 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2005 AND mi.info_type_id>2 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3859539;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=1995 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year<1973 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year>2007 AND mi.info_type_id>4 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>3258882 AND mk.keyword_id=7078;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<2008 AND ci.person_id<773157 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<1984 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<322;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>3 AND t.production_year<1993;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<2012;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mi.info_type_id>18 AND mk.keyword_id<137;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2000 AND mk.keyword_id<3636;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<127481 AND mc.company_type_id=2 AND mk.keyword_id=1951;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>320435 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=317766;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=1987 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=24317;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2004 AND mk.keyword_id>12097;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>4 AND ci.person_id<561510 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>13221;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>41892;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>6008 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year<2008 AND mc.company_id<11313 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<68558;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=2013 AND mk.keyword_id>991;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND ci.person_id<2333441 AND ci.role_id=10 AND mk.keyword_id>20762;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id<6 AND mk.keyword_id=4047;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<3 AND t.production_year<2008;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1953 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=31325 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year=2005 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>2000;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>10323;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year>1930;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=525520;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<1978 AND mc.company_type_id>1 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year<2013 AND mc.company_id<6 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<133 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year=2005 AND mi.info_type_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3635033 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>1912 AND ci.role_id<10 AND mk.keyword_id<502;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>1408530 AND ci.role_id<3 AND mk.keyword_id>16809;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>1994 AND ci.person_id=3965561 AND ci.role_id>8 AND mi.info_type_id<17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=96536;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year>2012 AND ci.person_id>397474 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year>1940 AND mi.info_type_id>16 AND mk.keyword_id>1714;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=2292;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<401 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year=2003 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=5327;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>10111;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2010 AND ci.person_id>439921;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<228373 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>52725;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year<1999 AND mk.keyword_id=8227;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mk.keyword_id<959;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id<347;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=3 AND t.production_year<2009;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>3 AND t.production_year>1978 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id>18 AND mk.keyword_id<20504;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>4060016 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>26557;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id<2996965 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>69928;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2009 AND mc.company_type_id>1 AND mk.keyword_id>679;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>1677387 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1925 AND ci.person_id>1401385;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2281283;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<2137091 AND ci.role_id>6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<4 AND t.production_year<2005 AND mc.company_id<11870 AND mi.info_type_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=228;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year>2010 AND mi.info_type_id>8 AND mk.keyword_id=383;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1909;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>1 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>4 AND ci.person_id>713389;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=1917;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2007 AND mi_idx.info_type_id=101 AND mk.keyword_id=48524;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=9988;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=158616 AND ci.role_id<6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<11418 AND mc.company_type_id>1 AND mi.info_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=2012 AND mi.info_type_id>3 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1975 AND mk.keyword_id<27368;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1914 AND mk.keyword_id>19735;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<4 AND t.production_year=1956 AND mc.company_id>14300 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2466809 AND ci.role_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>1974 AND ci.person_id=204453;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1995 AND ci.person_id<1885540;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<43863;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2002 AND mk.keyword_id>15084;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<2003 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=36091;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id>11903;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<21147;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2313041;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND mc.company_id<1527 AND mc.company_type_id>1 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2007 AND mk.keyword_id<26238;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<3 AND t.production_year=1989 AND mi.info_type_id<15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id>2927041 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1321180;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND ci.person_id<3433871 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=49249;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2010 AND mk.keyword_id>1515;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2826119 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2872770;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<6211;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year=2011 AND mc.company_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<2011 AND mi_idx.info_type_id>101 AND mk.keyword_id=7081;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=137905;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year=2004 AND mc.company_id>34 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<15378;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year=1994;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>7869;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<2013 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2010 AND mk.keyword_id=11445;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=813469 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2494881 AND ci.role_id<7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2000 AND mi.info_type_id<106 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<7851;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>7851 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>2691406 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>1463;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id<101 AND mk.keyword_id<10866;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<16115;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<820747 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2002 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>2004 AND mc.company_id<1710 AND mc.company_type_id=1 AND ci.person_id>1637524 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=1518;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2010 AND mk.keyword_id=11245;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=13572;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND mk.keyword_id>4099;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>1967;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<137 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>1976 AND ci.person_id>3716829 AND ci.role_id>4 AND mk.keyword_id=335;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>2003 AND mc.company_id<32611 AND mi.info_type_id<106;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<723443 AND ci.role_id>9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<69534 AND mc.company_type_id=1 AND mk.keyword_id<5312;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>2006 AND ci.person_id>2816627 AND ci.role_id<10 AND mk.keyword_id=2827;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>4 AND t.production_year>2006;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<4 AND t.production_year>1993;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year>2011 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year>1996;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=2008 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<11839;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2913898 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<2004 AND mk.keyword_id=29475;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<366953;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>9024;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<14157 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=930;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=769;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year<2010 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1438744 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>8558 AND mc.company_type_id>1 AND ci.person_id<2984481 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2004 AND ci.person_id<1563921 AND mk.keyword_id=3499;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1969 AND mk.keyword_id<25984;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>221;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=9390;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>2400433 AND ci.role_id<3 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year=1992 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>93 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>4 AND t.production_year=2007;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<7350;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year>2012 AND mc.company_id<1451 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>1 AND t.production_year>1989;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=99194;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3534396 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>3480;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND mk.keyword_id>992;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=1952 AND mi.info_type_id>16 AND mk.keyword_id>432;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=1967 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<3 AND t.production_year>2002 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1996 AND mi.info_type_id=4 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=136461 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<2007 AND ci.person_id=2703363;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<2005 AND ci.person_id>2341864;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=2012 AND mk.keyword_id=2201;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3970129 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<2000 AND mi.info_type_id<17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<18706;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<11941;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<103280;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=35054;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=2009 AND ci.role_id=5 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>2 AND t.production_year>1948;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND ci.person_id>2861640;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id=8 AND mk.keyword_id>5297;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>1042680 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<2 AND t.production_year>1911;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year=2002;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>4 AND t.production_year<1996;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>1980 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<1615;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2012 AND ci.role_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year<2000 AND mc.company_id<6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=2 AND mc.company_id>79756;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3855602 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND mi.info_type_id>1 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year>1978 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>1 AND t.production_year<1959;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>46197;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=2009 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<36392 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND mi.info_type_id>98 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>7168;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2007 AND mk.keyword_id<797;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1989 AND ci.role_id=2 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<6 AND t.production_year=1973;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>4 AND mc.company_id>6926 AND mc.company_type_id=2 AND ci.person_id<530597;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>12737;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<69271;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<2340;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>14846;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2004 AND mc.company_id<20427 AND mk.keyword_id<25296;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1858277;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=40209 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<100030;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>6225;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=1999 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>2805368 AND ci.role_id>9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year<1985 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year<2010 AND mc.company_id<42541 AND mi.info_type_id<15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>1327653 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=9492;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>3 AND t.production_year<1938;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=306515 AND ci.role_id<9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=3 AND t.production_year<2009 AND mc.company_id>239 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>4 AND t.production_year<1953 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>2 AND t.production_year>2010 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<45851 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<1798117 AND ci.role_id>1 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1996 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year<2009 AND ci.role_id=6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=1992 AND ci.person_id<3750295;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2583195 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>11145 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=3 AND t.production_year=1997 AND ci.person_id>386835 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2008 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND mc.company_type_id=1 AND ci.person_id<3978504;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>14922;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id<1382;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id<16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<1990 AND ci.person_id<1289678 AND ci.role_id<2 AND mk.keyword_id=3521;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2010 AND mi.info_type_id<13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>252027 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id>16 AND mk.keyword_id=10104;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=2008 AND mk.keyword_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1347087;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1999 AND ci.person_id=1164479 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND mc.company_id<20235;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year>0 AND mi_idx.info_type_id<101 AND mk.keyword_id<16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id=11264 AND mc.company_type_id=2 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=2907675 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=9174;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>2071795 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id=1396 AND mc.company_type_id=1 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=52;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=3311036 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id>6960;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<1997 AND ci.person_id>2557075 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>10295 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<459 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2008 AND ci.person_id<2062618 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>3519621 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id<4 AND t.production_year=1941;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year<1973 AND mc.company_type_id<2 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id<1498 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=88364;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=3 AND t.production_year=2006 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=578700 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND t.production_year>2002 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<82 AND mc.company_type_id<2 AND mk.keyword_id=793;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1983 AND mk.keyword_id>3639;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=2011 AND ci.person_id>2224539 AND ci.role_id=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>4 AND t.production_year>1968;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year<1986 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<8787;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<4 AND mk.keyword_id<12917;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year<1912 AND mi.info_type_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=78330 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>1999 AND mk.keyword_id<15867;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=2 AND t.production_year>2011 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id<4 AND t.production_year=1983;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1993 AND ci.person_id>56020 AND ci.role_id>1 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>0 AND mc.company_id=666 AND mc.company_type_id=1 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2133508;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_type_id>1 AND mk.keyword_id<5673;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>2010 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=1700;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year>2000 AND mk.keyword_id<9713;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>19261;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<874165 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>2 AND mk.keyword_id<2158;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id=71 AND mk.keyword_id=4886;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1501643;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<169;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>1998 AND ci.person_id<2632798;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2013 AND mc.company_id>11690;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>72745;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=1376;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<100309 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2011 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=20531;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3685269 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=1997;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND mc.company_id<264 AND mc.company_type_id=1 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id=887764 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year>2007 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=4 AND mc.company_id<4226 AND mc.company_type_id<2 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year>2008 AND mk.keyword_id<1595;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND ci.role_id=8 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<182961;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>1909 AND ci.person_id<3033660;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND mc.company_id>15344 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<1979 AND mk.keyword_id<221;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>371;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year>2002 AND ci.person_id<91254 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND ci.role_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>735;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year>2010 AND mi.info_type_id=15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<61278;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year=2010 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_type_id>1 AND mk.keyword_id<17567;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>47258;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<2025 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>3 AND t.production_year>2005;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<2013 AND mi.info_type_id>3 AND mk.keyword_id<2879;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<2006 AND mi.info_type_id=4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=999932 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND ci.person_id>574512 AND ci.role_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=4 AND t.production_year>1990 AND ci.person_id>2501889 AND ci.role_id>2 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3579913 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=1976;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=1983 AND mk.keyword_id>16501;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=2005 AND mc.company_id<81410;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year>2000 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year=2007 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>72919 AND ci.person_id>707872;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=3 AND t.production_year>2007 AND mk.keyword_id<79661;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>12660;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=72914 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND mc.company_type_id=1 AND ci.person_id>2624951 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id<233881 AND mc.company_type_id=1 AND ci.person_id<190941 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2459947 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>0 AND mc.company_id=76885 AND mc.company_type_id=2 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=1434 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<768549 AND mk.keyword_id=5704;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>55345;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<39918;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<4 AND t.production_year<2010 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id=4 AND t.production_year>2000;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>330629;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=24031 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mk.keyword_id<14017;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year<1978 AND mc.company_id=6655;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<3 AND ci.person_id>2376438 AND mk.keyword_id<12512;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>9788 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<1983 AND mk.keyword_id=19927;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=43385 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year=2005 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>2 AND mk.keyword_id>989;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2004 AND mc.company_type_id=2 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>1 AND t.production_year<2001 AND ci.person_id>3459377;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=1990 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<1963275 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<1909 AND mk.keyword_id>16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<49490;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>94486 AND ci.role_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>2012 AND mi.info_type_id>98;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=2004;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>4870 AND ci.person_id>117361 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<5889;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<807;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2012 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND mc.company_id<88113 AND mk.keyword_id=347;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=711 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>33256;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND mc.company_id<1312 AND mc.company_type_id>1 AND mk.keyword_id>62;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<47506 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<1992 AND mk.keyword_id>3629;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1961 AND mk.keyword_id=1066;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=6 AND mk.keyword_id<1603;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1356569;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>27 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1959 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>437 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<4 AND mi.info_type_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>37826;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>272 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<150930 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<88987 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year<2009 AND mi.info_type_id=5 AND mk.keyword_id<77;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>81045;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year<2012 AND mi.info_type_id<8 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>11706 AND mc.company_type_id<2 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1642022 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=1984 AND mk.keyword_id=1226;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=3 AND t.production_year=1968;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND mc.company_id>27 AND ci.person_id=2815171 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<2008 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=1899 AND mi.info_type_id=7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year=2009 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=2012 AND ci.person_id<2861083 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.production_year=2005 AND mc.company_id>11378 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>8504;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=2002 AND ci.person_id=1858618;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=3900;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND mc.company_id<292 AND mc.company_type_id=2 AND mk.keyword_id>72791;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=3147849 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<3 AND t.production_year<1998 AND mk.keyword_id=1512;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mk.keyword_id=1198;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=35980;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>628361 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=4038;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<1963 AND mk.keyword_id>25761;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=1997 AND mc.company_id>1427 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2002 AND mk.keyword_id<4514;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<7 AND ci.person_id>40662;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year=1963;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1971 AND mk.keyword_id=3002;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id=2123853 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>9922;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=1999 AND mk.keyword_id<7076;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year=2009 AND mk.keyword_id=2523;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=2012 AND mk.keyword_id>6014;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2011 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>22;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<4 AND t.production_year=2013;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2002 AND mk.keyword_id<310;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2716666 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=15637 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<241356 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1968 AND ci.person_id<3552809 AND ci.role_id>2 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<29863;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year=2006 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id>1 AND t.production_year<2010 AND mc.company_id<87719;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND mi.info_type_id=61;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<294290;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND mc.company_id=521;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mc.company_type_id=2 AND mk.keyword_id=52940;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year<2013 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=56044 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2004 AND mi_idx.info_type_id<101 AND mk.keyword_id=1116;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year<2000 AND mk.keyword_id>62;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2005 AND mk.keyword_id<34590;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=7 AND t.production_year=1996;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year<2011 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1993 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<6016;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year<1992;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<4 AND t.production_year<2009 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=1962 AND mk.keyword_id>683;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>1945 AND mi.info_type_id<2 AND mk.keyword_id<11436;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2007 AND mi_idx.info_type_id>101 AND mk.keyword_id>414;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year=2001 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=1972 AND ci.person_id>552659 AND ci.role_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year<2005 AND mi.info_type_id=16 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=1 AND mc.company_id>4657 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3514419;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1991111;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>1 AND t.production_year>2011 AND mc.company_id=13794 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=6499;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.production_year>2006 AND mc.company_id<27030 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=12089;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2007 AND mk.keyword_id=16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<3889 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2521427;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=7 AND t.production_year=2001 AND mc.company_id>50752 AND mi.info_type_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>6 AND mc.company_type_id<2 AND mk.keyword_id>7118;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1568260 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=1994 AND ci.person_id>2634633 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>957245 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<10256 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>3285133 AND ci.role_id>8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>2621140 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1658663;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<170733 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<810154 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<2888;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id=196516 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>11203;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND mc.company_id>9557 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=2007 AND ci.person_id<1325418 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id>61757 AND mc.company_type_id<2 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>582377;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id>2 AND t.production_year>2002;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year=1974 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<13700;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<900749 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<3236;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>583692 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id=7 AND mk.keyword_id=405;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2001 AND mi.info_type_id=16 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1988;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<7103;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.production_year=1920;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>1682 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND ci.person_id>1113205 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=1190 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<1999 AND mk.keyword_id=55124;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=6397;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>107268 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year<2011 AND mc.company_id=995 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1576817 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>38304 AND ci.role_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id>3 AND t.production_year<1965 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year=1941 AND ci.person_id>2772415 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=2551;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id=100 AND mk.keyword_id<9326;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=1 AND t.production_year=2004 AND mk.keyword_id=20869;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>41922;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>91035 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id=1 AND t.production_year=1987 AND mc.company_id<265;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1033058 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id<2468;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<21183;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=2008 AND ci.person_id>1352097;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1722286;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=1967 AND mi.info_type_id<17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>17859;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>508223 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id<3 AND t.production_year<2004;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2011 AND mk.keyword_id>15689;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<3650956 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<16195;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=797238;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<1971 AND mi.info_type_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<1972 AND ci.person_id<1803427 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<84048;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<78628;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2013 AND mk.keyword_id<1312;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.production_year>2007 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.production_year=2009 AND ci.person_id>2812597;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=8177;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=2411;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=1994 AND mk.keyword_id=3658;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>1666;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2535894 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id>3287;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=4412;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<853690 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>539844 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2007 AND mk.keyword_id=72;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year>1987 AND mc.company_id=87859 AND mc.company_type_id=2 AND mi.info_type_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2012 AND mk.keyword_id>15117;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<86998 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=2002 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>1 AND t.production_year=1982 AND mk.keyword_id=1272;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1996;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2005 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year=2006 AND ci.person_id>135569 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>4 AND t.production_year>1991 AND mc.company_id<5173;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1496180 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=201;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year=1968 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=1930 AND mi_idx.info_type_id<101 AND mk.keyword_id<498;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=26328 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>21063 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year=2006 AND ci.person_id<2221102;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<2 AND t.production_year<1992;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=1979;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=7 AND t.production_year>1963 AND mi.info_type_id>98;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<83304;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<2 AND t.production_year<2013;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2243948;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id=1 AND t.production_year=1976 AND mc.company_id<685 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=69176 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=1902 AND mi.info_type_id>13;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>1993 AND mk.keyword_id<15084;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id>6 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1995 AND mi.info_type_id=8 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year>2004 AND mi.info_type_id<3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<152822;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<80168;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<7 AND t.production_year=1943 AND mi.info_type_id>17;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id>2 AND ci.person_id=2690184 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id=735661;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id<2686 AND mi_idx.info_type_id=100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2011 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2007 AND mk.keyword_id>16264;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<8721;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<2010 AND ci.role_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>3661;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>791831;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year>1952;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year>2009 AND ci.person_id=1628184;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND ci.person_id=2482947 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<4 AND t.production_year>2011 AND mi.info_type_id>16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<43265;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year=2010 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1938;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1137052;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1980 AND mi_idx.info_type_id=99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<75943 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=7 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<2514;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.role_id=1 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.production_year=2008 AND mk.keyword_id<3434;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>494;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=2010 AND ci.person_id<1781410;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3429318 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id<7 AND t.production_year>1996 AND mc.company_id=331;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id=818104 AND mi.info_type_id<16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.kind_id>4 AND t.production_year>2004 AND mc.company_id<4714 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>1966598;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id>1 AND mc.company_id>33322 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>3038647;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id<21517;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.production_year<2012 AND ci.role_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>2737348 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=76048 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1936153 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>1976 AND ci.person_id=54577 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<2 AND t.production_year>2006 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<1992;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=2983511 AND ci.role_id>9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND mk.keyword_id<44111;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<208799 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t WHERE t.kind_id=4 AND t.production_year<2008;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1139578 AND ci.role_id=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year=1974 AND ci.person_id<543531;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>36706 AND mc.company_type_id=2 AND mk.keyword_id=5300;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2012 AND mk.keyword_id<6194;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.person_id>1741807 AND mi.info_type_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.role_id>1 AND mk.keyword_id>19852;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year>2007 AND mk.keyword_id=3060;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<463908 AND ci.role_id=9;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=480 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<392746 AND ci.role_id>2 AND mk.keyword_id=1420;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year=2000 AND ci.role_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<517434 AND ci.role_id=3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id>99 AND mk.keyword_id>4333;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND t.kind_id=4 AND mi.info_type_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>2011;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mk.keyword_id<29124;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2573477 AND ci.role_id>2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id<7814;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>1940;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<28570;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.kind_id<7 AND t.production_year>1965 AND mc.company_id=160 AND mc.company_type_id>1 AND mi.info_type_id>108;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id<2 AND ci.role_id<8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>4 AND t.production_year>1957;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id>3 AND t.production_year>2012;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2010 AND mk.keyword_id<2565;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id=1 AND t.production_year>2013 AND mc.company_id<133039 AND mc.company_type_id=1 AND ci.person_id>1040128 AND ci.role_id=5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<3114560 AND ci.role_id<10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=86460;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND t.production_year=1995 AND ci.role_id<5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<1857593 AND mi_idx.info_type_id>101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year>2011 AND mk.keyword_id=245;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id>1 AND t.production_year>1937 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year>1962 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<4 AND t.production_year=2004 AND mi.info_type_id=2 AND mk.keyword_id<6043;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>2002 AND mi.info_type_id=8;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year<1991 AND mc.company_id>9557 AND mc.company_type_id=1 AND mi.info_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id>3 AND mc.company_id<686 AND mc.company_type_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mk.keyword_id=3344;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<183711 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>429885 AND ci.role_id<4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx WHERE t.id=mi_idx.movie_id AND t.production_year<1964 AND mi_idx.info_type_id<101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id<2501413 AND ci.role_id=10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year=1965 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<53716;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,cast_info ci WHERE t.id=mc.movie_id AND t.id=ci.movie_id AND t.kind_id<7 AND t.production_year>1997 AND ci.person_id=2802626 AND ci.role_id>4;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id>4 AND mk.keyword_id=7054;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id<1838662 AND ci.role_id>1 AND mi_idx.info_type_id<100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=1 AND t.production_year<2009 AND ci.person_id=3229516;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<80891;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<1837;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id=32374 AND mc.company_type_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id<3368 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND ci.person_id<2092521 AND mk.keyword_id<16348;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<2010 AND mk.keyword_id<3030;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info_idx mi_idx WHERE t.id=ci.movie_id AND t.id=mi_idx.movie_id AND ci.person_id>328006 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=34475;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.production_year>1973 AND mi.info_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=1980 AND mc.company_id>6582;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND mc.company_id=42773;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id=27995;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year=1987 AND mi_idx.info_type_id=101;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id<74151;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND ci.person_id>196958 AND ci.role_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>43797 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND mk.keyword_id>1078;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=44301;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=608733;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2839902;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year<1962 AND mk.keyword_id<217;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<75971;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=533;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<12156;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>5044;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=2010 AND mc.company_id>216 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_info mi WHERE t.id=ci.movie_id AND t.id=mi.movie_id AND ci.role_id>5 AND mi.info_type_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<37419;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.production_year<2009 AND ci.role_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year<2001 AND mi_idx.info_type_id>100 AND mk.keyword_id<1753;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id=1 AND t.production_year>2008 AND mi.info_type_id<7 AND mi_idx.info_type_id>100;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi WHERE t.id=mi.movie_id AND t.kind_id<2 AND t.production_year<2003 AND mi.info_type_id>3;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id>11143 AND mc.company_type_id<2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>1674901 AND ci.role_id<6;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<1948 AND mc.company_id<11147 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id>2254977 AND ci.role_id>5;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=1978674 AND ci.role_id>1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND mi.info_type_id=4 AND mk.keyword_id>1947;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND mc.company_id>312;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id>5876 AND mk.keyword_id<3833;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_keyword mk WHERE t.id=mi.movie_id AND t.id=mk.movie_id AND t.production_year<2006 AND mi.info_type_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id>19118;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND mi_idx.info_type_id>100 AND mk.keyword_id>59920;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND t.production_year<2011 AND mk.keyword_id<1582;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info_idx mi_idx WHERE t.id=mc.movie_id AND t.id=mi_idx.movie_id AND t.kind_id>3 AND mc.company_id>45379 AND mc.company_type_id=1;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci,movie_keyword mk WHERE t.id=ci.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=2010 AND mk.keyword_id<130554;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info mi,movie_info_idx mi_idx WHERE t.id=mi.movie_id AND t.id=mi_idx.movie_id AND t.kind_id<7 AND t.production_year>2011 AND mi.info_type_id=15 AND mi_idx.info_type_id>99;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<4 AND t.production_year=1946;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<2337114 AND ci.role_id>10;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.production_year>2007 AND mk.keyword_id<3078;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id<7 AND t.production_year>1997 AND mk.keyword_id=13056;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_info mi WHERE t.id=mc.movie_id AND t.id=mi.movie_id AND t.production_year<2007 AND mi.info_type_id>15;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND mc.company_id=79869;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc,movie_keyword mk WHERE t.id=mc.movie_id AND t.id=mk.movie_id AND mc.company_id<11713 AND mk.keyword_id>11399;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=16;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_companies mc WHERE mc.company_id=131454;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id=3518182;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,cast_info ci WHERE t.id=ci.movie_id AND t.kind_id=7 AND t.production_year<2012 AND ci.role_id>7;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.kind_id<7 AND t.production_year=1994;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id=2740;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM cast_info ci WHERE ci.person_id<1644221 AND ci.role_id=2;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_info_idx mi_idx,movie_keyword mk WHERE t.id=mi_idx.movie_id AND t.id=mk.movie_id AND t.production_year<2000 AND mk.keyword_id=1046;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_keyword mk WHERE t.id=mk.movie_id AND t.kind_id=7 AND mk.keyword_id=230;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM title t,movie_companies mc WHERE t.id=mc.movie_id AND t.production_year=1975 AND mc.company_id<13351;

EXPLAIN (FORMAT JSON, ANALYZE, VERBOSE) SELECT * FROM movie_keyword mk WHERE mk.keyword_id<13189;
