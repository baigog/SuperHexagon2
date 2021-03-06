--LOOK-UP TABLE DE LAS FUNCIONES SENO Y COSENO.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity senocoseno is
	port(
		clk		:	in	std_logic;
		angulo	:	in	unsigned(9 downto 0);
		seno		:	out	signed(11 downto 0);
		coseno	:	out	signed(11 downto 0)
		);
end senocoseno;

architecture beh of senocoseno is

	constant data_width : natural := 12;
	constant addr_width : natural := 10;
	
	constant mem_size : natural := 2**addr_width;
	subtype rom_word is signed(data_width-1 downto 0);
	type mem_type is array (mem_size-1 downto 0) of rom_word;
	constant mem : mem_type :=
	
(0000 => to_signed(0,12),
0001 => to_signed(12,12),
0002 => to_signed(25,12),
0003 => to_signed(37,12),
0004 => to_signed(50,12),
0005 => to_signed(62,12),
0006 => to_signed(75,12),
0007 => to_signed(87,12),
0008 => to_signed(100,12),
0009 => to_signed(113,12),
0010 => to_signed(125,12),
0011 => to_signed(138,12),
0012 => to_signed(150,12),
0013 => to_signed(163,12),
0014 => to_signed(175,12),
0015 => to_signed(188,12),
0016 => to_signed(200,12),
0017 => to_signed(213,12),
0018 => to_signed(225,12),
0019 => to_signed(238,12),
0020 => to_signed(250,12),
0021 => to_signed(263,12),
0022 => to_signed(275,12),
0023 => to_signed(288,12),
0024 => to_signed(300,12),
0025 => to_signed(312,12),
0026 => to_signed(325,12),
0027 => to_signed(337,12),
0028 => to_signed(350,12),
0029 => to_signed(362,12),
0030 => to_signed(374,12),
0031 => to_signed(387,12),
0032 => to_signed(399,12),
0033 => to_signed(411,12),
0034 => to_signed(424,12),
0035 => to_signed(436,12),
0036 => to_signed(448,12),
0037 => to_signed(460,12),
0038 => to_signed(473,12),
0039 => to_signed(485,12),
0040 => to_signed(497,12),
0041 => to_signed(509,12),
0042 => to_signed(521,12),
0043 => to_signed(534,12),
0044 => to_signed(546,12),
0045 => to_signed(558,12),
0046 => to_signed(570,12),
0047 => to_signed(582,12),
0048 => to_signed(594,12),
0049 => to_signed(606,12),
0050 => to_signed(618,12),
0051 => to_signed(630,12),
0052 => to_signed(642,12),
0053 => to_signed(654,12),
0054 => to_signed(666,12),
0055 => to_signed(678,12),
0056 => to_signed(689,12),
0057 => to_signed(701,12),
0058 => to_signed(713,12),
0059 => to_signed(725,12),
0060 => to_signed(737,12),
0061 => to_signed(748,12),
0062 => to_signed(760,12),
0063 => to_signed(772,12),
0064 => to_signed(783,12),
0065 => to_signed(795,12),
0066 => to_signed(806,12),
0067 => to_signed(818,12),
0068 => to_signed(829,12),
0069 => to_signed(841,12),
0070 => to_signed(852,12),
0071 => to_signed(864,12),
0072 => to_signed(875,12),
0073 => to_signed(886,12),
0074 => to_signed(898,12),
0075 => to_signed(909,12),
0076 => to_signed(920,12),
0077 => to_signed(932,12),
0078 => to_signed(943,12),
0079 => to_signed(954,12),
0080 => to_signed(965,12),
0081 => to_signed(976,12),
0082 => to_signed(987,12),
0083 => to_signed(998,12),
0084 => to_signed(1009,12),
0085 => to_signed(1020,12),
0086 => to_signed(1031,12),
0087 => to_signed(1042,12),
0088 => to_signed(1052,12),
0089 => to_signed(1063,12),
0090 => to_signed(1074,12),
0091 => to_signed(1085,12),
0092 => to_signed(1095,12),
0093 => to_signed(1106,12),
0094 => to_signed(1116,12),
0095 => to_signed(1127,12),
0096 => to_signed(1137,12),
0097 => to_signed(1148,12),
0098 => to_signed(1158,12),
0099 => to_signed(1168,12),
0100 => to_signed(1179,12),
0101 => to_signed(1189,12),
0102 => to_signed(1199,12),
0103 => to_signed(1209,12),
0104 => to_signed(1219,12),
0105 => to_signed(1230,12),
0106 => to_signed(1240,12),
0107 => to_signed(1250,12),
0108 => to_signed(1259,12),
0109 => to_signed(1269,12),
0110 => to_signed(1279,12),
0111 => to_signed(1289,12),
0112 => to_signed(1299,12),
0113 => to_signed(1308,12),
0114 => to_signed(1318,12),
0115 => to_signed(1328,12),
0116 => to_signed(1337,12),
0117 => to_signed(1347,12),
0118 => to_signed(1356,12),
0119 => to_signed(1366,12),
0120 => to_signed(1375,12),
0121 => to_signed(1384,12),
0122 => to_signed(1393,12),
0123 => to_signed(1403,12),
0124 => to_signed(1412,12),
0125 => to_signed(1421,12),
0126 => to_signed(1430,12),
0127 => to_signed(1439,12),
0128 => to_signed(1448,12),
0129 => to_signed(1457,12),
0130 => to_signed(1465,12),
0131 => to_signed(1474,12),
0132 => to_signed(1483,12),
0133 => to_signed(1491,12),
0134 => to_signed(1500,12),
0135 => to_signed(1509,12),
0136 => to_signed(1517,12),
0137 => to_signed(1525,12),
0138 => to_signed(1534,12),
0139 => to_signed(1542,12),
0140 => to_signed(1550,12),
0141 => to_signed(1558,12),
0142 => to_signed(1567,12),
0143 => to_signed(1575,12),
0144 => to_signed(1583,12),
0145 => to_signed(1591,12),
0146 => to_signed(1598,12),
0147 => to_signed(1606,12),
0148 => to_signed(1614,12),
0149 => to_signed(1622,12),
0150 => to_signed(1629,12),
0151 => to_signed(1637,12),
0152 => to_signed(1644,12),
0153 => to_signed(1652,12),
0154 => to_signed(1659,12),
0155 => to_signed(1667,12),
0156 => to_signed(1674,12),
0157 => to_signed(1681,12),
0158 => to_signed(1688,12),
0159 => to_signed(1695,12),
0160 => to_signed(1702,12),
0161 => to_signed(1709,12),
0162 => to_signed(1716,12),
0163 => to_signed(1723,12),
0164 => to_signed(1730,12),
0165 => to_signed(1736,12),
0166 => to_signed(1743,12),
0167 => to_signed(1750,12),
0168 => to_signed(1756,12),
0169 => to_signed(1763,12),
0170 => to_signed(1769,12),
0171 => to_signed(1775,12),
0172 => to_signed(1781,12),
0173 => to_signed(1788,12),
0174 => to_signed(1794,12),
0175 => to_signed(1800,12),
0176 => to_signed(1806,12),
0177 => to_signed(1812,12),
0178 => to_signed(1817,12),
0179 => to_signed(1823,12),
0180 => to_signed(1829,12),
0181 => to_signed(1834,12),
0182 => to_signed(1840,12),
0183 => to_signed(1845,12),
0184 => to_signed(1851,12),
0185 => to_signed(1856,12),
0186 => to_signed(1861,12),
0187 => to_signed(1867,12),
0188 => to_signed(1872,12),
0189 => to_signed(1877,12),
0190 => to_signed(1882,12),
0191 => to_signed(1887,12),
0192 => to_signed(1892,12),
0193 => to_signed(1896,12),
0194 => to_signed(1901,12),
0195 => to_signed(1906,12),
0196 => to_signed(1910,12),
0197 => to_signed(1915,12),
0198 => to_signed(1919,12),
0199 => to_signed(1924,12),
0200 => to_signed(1928,12),
0201 => to_signed(1932,12),
0202 => to_signed(1936,12),
0203 => to_signed(1940,12),
0204 => to_signed(1944,12),
0205 => to_signed(1948,12),
0206 => to_signed(1952,12),
0207 => to_signed(1956,12),
0208 => to_signed(1959,12),
0209 => to_signed(1963,12),
0210 => to_signed(1966,12),
0211 => to_signed(1970,12),
0212 => to_signed(1973,12),
0213 => to_signed(1977,12),
0214 => to_signed(1980,12),
0215 => to_signed(1983,12),
0216 => to_signed(1986,12),
0217 => to_signed(1989,12),
0218 => to_signed(1992,12),
0219 => to_signed(1995,12),
0220 => to_signed(1998,12),
0221 => to_signed(2000,12),
0222 => to_signed(2003,12),
0223 => to_signed(2006,12),
0224 => to_signed(2008,12),
0225 => to_signed(2011,12),
0226 => to_signed(2013,12),
0227 => to_signed(2015,12),
0228 => to_signed(2017,12),
0229 => to_signed(2019,12),
0230 => to_signed(2021,12),
0231 => to_signed(2023,12),
0232 => to_signed(2025,12),
0233 => to_signed(2027,12),
0234 => to_signed(2029,12),
0235 => to_signed(2031,12),
0236 => to_signed(2032,12),
0237 => to_signed(2034,12),
0238 => to_signed(2035,12),
0239 => to_signed(2036,12),
0240 => to_signed(2038,12),
0241 => to_signed(2039,12),
0242 => to_signed(2040,12),
0243 => to_signed(2041,12),
0244 => to_signed(2042,12),
0245 => to_signed(2043,12),
0246 => to_signed(2044,12),
0247 => to_signed(2044,12),
0248 => to_signed(2045,12),
0249 => to_signed(2046,12),
0250 => to_signed(2046,12),
0251 => to_signed(2047,12),
0252 => to_signed(2047,12),
0253 => to_signed(2047,12),
0254 => to_signed(2047,12),
0255 => to_signed(2047,12),
0256 => to_signed(2047,12),
0257 => to_signed(2047,12),
0258 => to_signed(2047,12),
0259 => to_signed(2047,12),
0260 => to_signed(2047,12),
0261 => to_signed(2047,12),
0262 => to_signed(2046,12),
0263 => to_signed(2046,12),
0264 => to_signed(2045,12),
0265 => to_signed(2044,12),
0266 => to_signed(2044,12),
0267 => to_signed(2043,12),
0268 => to_signed(2042,12),
0269 => to_signed(2041,12),
0270 => to_signed(2040,12),
0271 => to_signed(2039,12),
0272 => to_signed(2038,12),
0273 => to_signed(2036,12),
0274 => to_signed(2035,12),
0275 => to_signed(2034,12),
0276 => to_signed(2032,12),
0277 => to_signed(2031,12),
0278 => to_signed(2029,12),
0279 => to_signed(2027,12),
0280 => to_signed(2025,12),
0281 => to_signed(2023,12),
0282 => to_signed(2021,12),
0283 => to_signed(2019,12),
0284 => to_signed(2017,12),
0285 => to_signed(2015,12),
0286 => to_signed(2013,12),
0287 => to_signed(2011,12),
0288 => to_signed(2008,12),
0289 => to_signed(2006,12),
0290 => to_signed(2003,12),
0291 => to_signed(2000,12),
0292 => to_signed(1998,12),
0293 => to_signed(1995,12),
0294 => to_signed(1992,12),
0295 => to_signed(1989,12),
0296 => to_signed(1986,12),
0297 => to_signed(1983,12),
0298 => to_signed(1980,12),
0299 => to_signed(1977,12),
0300 => to_signed(1973,12),
0301 => to_signed(1970,12),
0302 => to_signed(1966,12),
0303 => to_signed(1963,12),
0304 => to_signed(1959,12),
0305 => to_signed(1956,12),
0306 => to_signed(1952,12),
0307 => to_signed(1948,12),
0308 => to_signed(1944,12),
0309 => to_signed(1940,12),
0310 => to_signed(1936,12),
0311 => to_signed(1932,12),
0312 => to_signed(1928,12),
0313 => to_signed(1924,12),
0314 => to_signed(1919,12),
0315 => to_signed(1915,12),
0316 => to_signed(1910,12),
0317 => to_signed(1906,12),
0318 => to_signed(1901,12),
0319 => to_signed(1896,12),
0320 => to_signed(1892,12),
0321 => to_signed(1887,12),
0322 => to_signed(1882,12),
0323 => to_signed(1877,12),
0324 => to_signed(1872,12),
0325 => to_signed(1867,12),
0326 => to_signed(1861,12),
0327 => to_signed(1856,12),
0328 => to_signed(1851,12),
0329 => to_signed(1845,12),
0330 => to_signed(1840,12),
0331 => to_signed(1834,12),
0332 => to_signed(1829,12),
0333 => to_signed(1823,12),
0334 => to_signed(1817,12),
0335 => to_signed(1812,12),
0336 => to_signed(1806,12),
0337 => to_signed(1800,12),
0338 => to_signed(1794,12),
0339 => to_signed(1788,12),
0340 => to_signed(1781,12),
0341 => to_signed(1775,12),
0342 => to_signed(1769,12),
0343 => to_signed(1763,12),
0344 => to_signed(1756,12),
0345 => to_signed(1750,12),
0346 => to_signed(1743,12),
0347 => to_signed(1736,12),
0348 => to_signed(1730,12),
0349 => to_signed(1723,12),
0350 => to_signed(1716,12),
0351 => to_signed(1709,12),
0352 => to_signed(1702,12),
0353 => to_signed(1695,12),
0354 => to_signed(1688,12),
0355 => to_signed(1681,12),
0356 => to_signed(1674,12),
0357 => to_signed(1667,12),
0358 => to_signed(1659,12),
0359 => to_signed(1652,12),
0360 => to_signed(1644,12),
0361 => to_signed(1637,12),
0362 => to_signed(1629,12),
0363 => to_signed(1622,12),
0364 => to_signed(1614,12),
0365 => to_signed(1606,12),
0366 => to_signed(1598,12),
0367 => to_signed(1591,12),
0368 => to_signed(1583,12),
0369 => to_signed(1575,12),
0370 => to_signed(1567,12),
0371 => to_signed(1558,12),
0372 => to_signed(1550,12),
0373 => to_signed(1542,12),
0374 => to_signed(1534,12),
0375 => to_signed(1525,12),
0376 => to_signed(1517,12),
0377 => to_signed(1509,12),
0378 => to_signed(1500,12),
0379 => to_signed(1491,12),
0380 => to_signed(1483,12),
0381 => to_signed(1474,12),
0382 => to_signed(1465,12),
0383 => to_signed(1457,12),
0384 => to_signed(1448,12),
0385 => to_signed(1439,12),
0386 => to_signed(1430,12),
0387 => to_signed(1421,12),
0388 => to_signed(1412,12),
0389 => to_signed(1403,12),
0390 => to_signed(1393,12),
0391 => to_signed(1384,12),
0392 => to_signed(1375,12),
0393 => to_signed(1366,12),
0394 => to_signed(1356,12),
0395 => to_signed(1347,12),
0396 => to_signed(1337,12),
0397 => to_signed(1328,12),
0398 => to_signed(1318,12),
0399 => to_signed(1308,12),
0400 => to_signed(1299,12),
0401 => to_signed(1289,12),
0402 => to_signed(1279,12),
0403 => to_signed(1269,12),
0404 => to_signed(1259,12),
0405 => to_signed(1250,12),
0406 => to_signed(1240,12),
0407 => to_signed(1230,12),
0408 => to_signed(1219,12),
0409 => to_signed(1209,12),
0410 => to_signed(1199,12),
0411 => to_signed(1189,12),
0412 => to_signed(1179,12),
0413 => to_signed(1168,12),
0414 => to_signed(1158,12),
0415 => to_signed(1148,12),
0416 => to_signed(1137,12),
0417 => to_signed(1127,12),
0418 => to_signed(1116,12),
0419 => to_signed(1106,12),
0420 => to_signed(1095,12),
0421 => to_signed(1085,12),
0422 => to_signed(1074,12),
0423 => to_signed(1063,12),
0424 => to_signed(1052,12),
0425 => to_signed(1042,12),
0426 => to_signed(1031,12),
0427 => to_signed(1020,12),
0428 => to_signed(1009,12),
0429 => to_signed(998,12),
0430 => to_signed(987,12),
0431 => to_signed(976,12),
0432 => to_signed(965,12),
0433 => to_signed(954,12),
0434 => to_signed(943,12),
0435 => to_signed(932,12),
0436 => to_signed(920,12),
0437 => to_signed(909,12),
0438 => to_signed(898,12),
0439 => to_signed(886,12),
0440 => to_signed(875,12),
0441 => to_signed(864,12),
0442 => to_signed(852,12),
0443 => to_signed(841,12),
0444 => to_signed(829,12),
0445 => to_signed(818,12),
0446 => to_signed(806,12),
0447 => to_signed(795,12),
0448 => to_signed(783,12),
0449 => to_signed(772,12),
0450 => to_signed(760,12),
0451 => to_signed(748,12),
0452 => to_signed(737,12),
0453 => to_signed(725,12),
0454 => to_signed(713,12),
0455 => to_signed(701,12),
0456 => to_signed(689,12),
0457 => to_signed(678,12),
0458 => to_signed(666,12),
0459 => to_signed(654,12),
0460 => to_signed(642,12),
0461 => to_signed(630,12),
0462 => to_signed(618,12),
0463 => to_signed(606,12),
0464 => to_signed(594,12),
0465 => to_signed(582,12),
0466 => to_signed(570,12),
0467 => to_signed(558,12),
0468 => to_signed(546,12),
0469 => to_signed(534,12),
0470 => to_signed(521,12),
0471 => to_signed(509,12),
0472 => to_signed(497,12),
0473 => to_signed(485,12),
0474 => to_signed(473,12),
0475 => to_signed(460,12),
0476 => to_signed(448,12),
0477 => to_signed(436,12),
0478 => to_signed(424,12),
0479 => to_signed(411,12),
0480 => to_signed(399,12),
0481 => to_signed(387,12),
0482 => to_signed(374,12),
0483 => to_signed(362,12),
0484 => to_signed(350,12),
0485 => to_signed(337,12),
0486 => to_signed(325,12),
0487 => to_signed(312,12),
0488 => to_signed(300,12),
0489 => to_signed(288,12),
0490 => to_signed(275,12),
0491 => to_signed(263,12),
0492 => to_signed(250,12),
0493 => to_signed(238,12),
0494 => to_signed(225,12),
0495 => to_signed(213,12),
0496 => to_signed(200,12),
0497 => to_signed(188,12),
0498 => to_signed(175,12),
0499 => to_signed(163,12),
0500 => to_signed(150,12),
0501 => to_signed(138,12),
0502 => to_signed(125,12),
0503 => to_signed(113,12),
0504 => to_signed(100,12),
0505 => to_signed(87,12),
0506 => to_signed(75,12),
0507 => to_signed(62,12),
0508 => to_signed(50,12),
0509 => to_signed(37,12),
0510 => to_signed(25,12),
0511 => to_signed(12,12),
0512 => to_signed(0,12),
0513 => to_signed(12,12),
0514 => to_signed(25,12),
0515 => to_signed(37,12),
0516 => to_signed(50,12),
0517 => to_signed(62,12),
0518 => to_signed(75,12),
0519 => to_signed(87,12),
0520 => to_signed(100,12),
0521 => to_signed(113,12),
0522 => to_signed(125,12),
0523 => to_signed(138,12),
0524 => to_signed(150,12),
0525 => to_signed(163,12),
0526 => to_signed(175,12),
0527 => to_signed(188,12),
0528 => to_signed(200,12),
0529 => to_signed(213,12),
0530 => to_signed(225,12),
0531 => to_signed(238,12),
0532 => to_signed(250,12),
0533 => to_signed(263,12),
0534 => to_signed(275,12),
0535 => to_signed(288,12),
0536 => to_signed(300,12),
0537 => to_signed(312,12),
0538 => to_signed(325,12),
0539 => to_signed(337,12),
0540 => to_signed(350,12),
0541 => to_signed(362,12),
0542 => to_signed(374,12),
0543 => to_signed(387,12),
0544 => to_signed(399,12),
0545 => to_signed(411,12),
0546 => to_signed(424,12),
0547 => to_signed(436,12),
0548 => to_signed(448,12),
0549 => to_signed(460,12),
0550 => to_signed(473,12),
0551 => to_signed(485,12),
0552 => to_signed(497,12),
0553 => to_signed(509,12),
0554 => to_signed(521,12),
0555 => to_signed(534,12),
0556 => to_signed(546,12),
0557 => to_signed(558,12),
0558 => to_signed(570,12),
0559 => to_signed(582,12),
0560 => to_signed(594,12),
0561 => to_signed(606,12),
0562 => to_signed(618,12),
0563 => to_signed(630,12),
0564 => to_signed(642,12),
0565 => to_signed(654,12),
0566 => to_signed(666,12),
0567 => to_signed(678,12),
0568 => to_signed(689,12),
0569 => to_signed(701,12),
0570 => to_signed(713,12),
0571 => to_signed(725,12),
0572 => to_signed(737,12),
0573 => to_signed(748,12),
0574 => to_signed(760,12),
0575 => to_signed(772,12),
0576 => to_signed(783,12),
0577 => to_signed(795,12),
0578 => to_signed(806,12),
0579 => to_signed(818,12),
0580 => to_signed(829,12),
0581 => to_signed(841,12),
0582 => to_signed(852,12),
0583 => to_signed(864,12),
0584 => to_signed(875,12),
0585 => to_signed(886,12),
0586 => to_signed(898,12),
0587 => to_signed(909,12),
0588 => to_signed(920,12),
0589 => to_signed(932,12),
0590 => to_signed(943,12),
0591 => to_signed(954,12),
0592 => to_signed(965,12),
0593 => to_signed(976,12),
0594 => to_signed(987,12),
0595 => to_signed(998,12),
0596 => to_signed(1009,12),
0597 => to_signed(1020,12),
0598 => to_signed(1031,12),
0599 => to_signed(1042,12),
0600 => to_signed(1052,12),
0601 => to_signed(1063,12),
0602 => to_signed(1074,12),
0603 => to_signed(1085,12),
0604 => to_signed(1095,12),
0605 => to_signed(1106,12),
0606 => to_signed(1116,12),
0607 => to_signed(1127,12),
0608 => to_signed(1137,12),
0609 => to_signed(1148,12),
0610 => to_signed(1158,12),
0611 => to_signed(1168,12),
0612 => to_signed(1179,12),
0613 => to_signed(1189,12),
0614 => to_signed(1199,12),
0615 => to_signed(1209,12),
0616 => to_signed(1219,12),
0617 => to_signed(1230,12),
0618 => to_signed(1240,12),
0619 => to_signed(1250,12),
0620 => to_signed(1259,12),
0621 => to_signed(1269,12),
0622 => to_signed(1279,12),
0623 => to_signed(1289,12),
0624 => to_signed(1299,12),
0625 => to_signed(1308,12),
0626 => to_signed(1318,12),
0627 => to_signed(1328,12),
0628 => to_signed(1337,12),
0629 => to_signed(1347,12),
0630 => to_signed(1356,12),
0631 => to_signed(1366,12),
0632 => to_signed(1375,12),
0633 => to_signed(1384,12),
0634 => to_signed(1393,12),
0635 => to_signed(1403,12),
0636 => to_signed(1412,12),
0637 => to_signed(1421,12),
0638 => to_signed(1430,12),
0639 => to_signed(1439,12),
0640 => to_signed(1448,12),
0641 => to_signed(1457,12),
0642 => to_signed(1465,12),
0643 => to_signed(1474,12),
0644 => to_signed(1483,12),
0645 => to_signed(1491,12),
0646 => to_signed(1500,12),
0647 => to_signed(1509,12),
0648 => to_signed(1517,12),
0649 => to_signed(1525,12),
0650 => to_signed(1534,12),
0651 => to_signed(1542,12),
0652 => to_signed(1550,12),
0653 => to_signed(1558,12),
0654 => to_signed(1567,12),
0655 => to_signed(1575,12),
0656 => to_signed(1583,12),
0657 => to_signed(1591,12),
0658 => to_signed(1598,12),
0659 => to_signed(1606,12),
0660 => to_signed(1614,12),
0661 => to_signed(1622,12),
0662 => to_signed(1629,12),
0663 => to_signed(1637,12),
0664 => to_signed(1644,12),
0665 => to_signed(1652,12),
0666 => to_signed(1659,12),
0667 => to_signed(1667,12),
0668 => to_signed(1674,12),
0669 => to_signed(1681,12),
0670 => to_signed(1688,12),
0671 => to_signed(1695,12),
0672 => to_signed(1702,12),
0673 => to_signed(1709,12),
0674 => to_signed(1716,12),
0675 => to_signed(1723,12),
0676 => to_signed(1730,12),
0677 => to_signed(1736,12),
0678 => to_signed(1743,12),
0679 => to_signed(1750,12),
0680 => to_signed(1756,12),
0681 => to_signed(1763,12),
0682 => to_signed(1769,12),
0683 => to_signed(1775,12),
0684 => to_signed(1781,12),
0685 => to_signed(1788,12),
0686 => to_signed(1794,12),
0687 => to_signed(1800,12),
0688 => to_signed(1806,12),
0689 => to_signed(1812,12),
0690 => to_signed(1817,12),
0691 => to_signed(1823,12),
0692 => to_signed(1829,12),
0693 => to_signed(1834,12),
0694 => to_signed(1840,12),
0695 => to_signed(1845,12),
0696 => to_signed(1851,12),
0697 => to_signed(1856,12),
0698 => to_signed(1861,12),
0699 => to_signed(1867,12),
0700 => to_signed(1872,12),
0701 => to_signed(1877,12),
0702 => to_signed(1882,12),
0703 => to_signed(1887,12),
0704 => to_signed(1892,12),
0705 => to_signed(1896,12),
0706 => to_signed(1901,12),
0707 => to_signed(1906,12),
0708 => to_signed(1910,12),
0709 => to_signed(1915,12),
0710 => to_signed(1919,12),
0711 => to_signed(1924,12),
0712 => to_signed(1928,12),
0713 => to_signed(1932,12),
0714 => to_signed(1936,12),
0715 => to_signed(1940,12),
0716 => to_signed(1944,12),
0717 => to_signed(1948,12),
0718 => to_signed(1952,12),
0719 => to_signed(1956,12),
0720 => to_signed(1959,12),
0721 => to_signed(1963,12),
0722 => to_signed(1966,12),
0723 => to_signed(1970,12),
0724 => to_signed(1973,12),
0725 => to_signed(1977,12),
0726 => to_signed(1980,12),
0727 => to_signed(1983,12),
0728 => to_signed(1986,12),
0729 => to_signed(1989,12),
0730 => to_signed(1992,12),
0731 => to_signed(1995,12),
0732 => to_signed(1998,12),
0733 => to_signed(2000,12),
0734 => to_signed(2003,12),
0735 => to_signed(2006,12),
0736 => to_signed(2008,12),
0737 => to_signed(2011,12),
0738 => to_signed(2013,12),
0739 => to_signed(2015,12),
0740 => to_signed(2017,12),
0741 => to_signed(2019,12),
0742 => to_signed(2021,12),
0743 => to_signed(2023,12),
0744 => to_signed(2025,12),
0745 => to_signed(2027,12),
0746 => to_signed(2029,12),
0747 => to_signed(2031,12),
0748 => to_signed(2032,12),
0749 => to_signed(2034,12),
0750 => to_signed(2035,12),
0751 => to_signed(2036,12),
0752 => to_signed(2038,12),
0753 => to_signed(2039,12),
0754 => to_signed(2040,12),
0755 => to_signed(2041,12),
0756 => to_signed(2042,12),
0757 => to_signed(2043,12),
0758 => to_signed(2044,12),
0759 => to_signed(2044,12),
0760 => to_signed(2045,12),
0761 => to_signed(2046,12),
0762 => to_signed(2046,12),
0763 => to_signed(2047,12),
0764 => to_signed(2047,12),
0765 => to_signed(2047,12),
0766 => to_signed(2047,12),
0767 => to_signed(2047,12),
0768 => to_signed(2047,12),
0769 => to_signed(2047,12),
0770 => to_signed(2047,12),
0771 => to_signed(2047,12),
0772 => to_signed(2047,12),
0773 => to_signed(2047,12),
0774 => to_signed(2046,12),
0775 => to_signed(2046,12),
0776 => to_signed(2045,12),
0777 => to_signed(2044,12),
0778 => to_signed(2044,12),
0779 => to_signed(2043,12),
0780 => to_signed(2042,12),
0781 => to_signed(2041,12),
0782 => to_signed(2040,12),
0783 => to_signed(2039,12),
0784 => to_signed(2038,12),
0785 => to_signed(2036,12),
0786 => to_signed(2035,12),
0787 => to_signed(2034,12),
0788 => to_signed(2032,12),
0789 => to_signed(2031,12),
0790 => to_signed(2029,12),
0791 => to_signed(2027,12),
0792 => to_signed(2025,12),
0793 => to_signed(2023,12),
0794 => to_signed(2021,12),
0795 => to_signed(2019,12),
0796 => to_signed(2017,12),
0797 => to_signed(2015,12),
0798 => to_signed(2013,12),
0799 => to_signed(2011,12),
0800 => to_signed(2008,12),
0801 => to_signed(2006,12),
0802 => to_signed(2003,12),
0803 => to_signed(2000,12),
0804 => to_signed(1998,12),
0805 => to_signed(1995,12),
0806 => to_signed(1992,12),
0807 => to_signed(1989,12),
0808 => to_signed(1986,12),
0809 => to_signed(1983,12),
0810 => to_signed(1980,12),
0811 => to_signed(1977,12),
0812 => to_signed(1973,12),
0813 => to_signed(1970,12),
0814 => to_signed(1966,12),
0815 => to_signed(1963,12),
0816 => to_signed(1959,12),
0817 => to_signed(1956,12),
0818 => to_signed(1952,12),
0819 => to_signed(1948,12),
0820 => to_signed(1944,12),
0821 => to_signed(1940,12),
0822 => to_signed(1936,12),
0823 => to_signed(1932,12),
0824 => to_signed(1928,12),
0825 => to_signed(1924,12),
0826 => to_signed(1919,12),
0827 => to_signed(1915,12),
0828 => to_signed(1910,12),
0829 => to_signed(1906,12),
0830 => to_signed(1901,12),
0831 => to_signed(1896,12),
0832 => to_signed(1892,12),
0833 => to_signed(1887,12),
0834 => to_signed(1882,12),
0835 => to_signed(1877,12),
0836 => to_signed(1872,12),
0837 => to_signed(1867,12),
0838 => to_signed(1861,12),
0839 => to_signed(1856,12),
0840 => to_signed(1851,12),
0841 => to_signed(1845,12),
0842 => to_signed(1840,12),
0843 => to_signed(1834,12),
0844 => to_signed(1829,12),
0845 => to_signed(1823,12),
0846 => to_signed(1817,12),
0847 => to_signed(1812,12),
0848 => to_signed(1806,12),
0849 => to_signed(1800,12),
0850 => to_signed(1794,12),
0851 => to_signed(1788,12),
0852 => to_signed(1781,12),
0853 => to_signed(1775,12),
0854 => to_signed(1769,12),
0855 => to_signed(1763,12),
0856 => to_signed(1756,12),
0857 => to_signed(1750,12),
0858 => to_signed(1743,12),
0859 => to_signed(1736,12),
0860 => to_signed(1730,12),
0861 => to_signed(1723,12),
0862 => to_signed(1716,12),
0863 => to_signed(1709,12),
0864 => to_signed(1702,12),
0865 => to_signed(1695,12),
0866 => to_signed(1688,12),
0867 => to_signed(1681,12),
0868 => to_signed(1674,12),
0869 => to_signed(1667,12),
0870 => to_signed(1659,12),
0871 => to_signed(1652,12),
0872 => to_signed(1644,12),
0873 => to_signed(1637,12),
0874 => to_signed(1629,12),
0875 => to_signed(1622,12),
0876 => to_signed(1614,12),
0877 => to_signed(1606,12),
0878 => to_signed(1598,12),
0879 => to_signed(1591,12),
0880 => to_signed(1583,12),
0881 => to_signed(1575,12),
0882 => to_signed(1567,12),
0883 => to_signed(1558,12),
0884 => to_signed(1550,12),
0885 => to_signed(1542,12),
0886 => to_signed(1534,12),
0887 => to_signed(1525,12),
0888 => to_signed(1517,12),
0889 => to_signed(1509,12),
0890 => to_signed(1500,12),
0891 => to_signed(1491,12),
0892 => to_signed(1483,12),
0893 => to_signed(1474,12),
0894 => to_signed(1465,12),
0895 => to_signed(1457,12),
0896 => to_signed(1448,12),
0897 => to_signed(1439,12),
0898 => to_signed(1430,12),
0899 => to_signed(1421,12),
0900 => to_signed(1412,12),
0901 => to_signed(1403,12),
0902 => to_signed(1393,12),
0903 => to_signed(1384,12),
0904 => to_signed(1375,12),
0905 => to_signed(1366,12),
0906 => to_signed(1356,12),
0907 => to_signed(1347,12),
0908 => to_signed(1337,12),
0909 => to_signed(1328,12),
0910 => to_signed(1318,12),
0911 => to_signed(1308,12),
0912 => to_signed(1299,12),
0913 => to_signed(1289,12),
0914 => to_signed(1279,12),
0915 => to_signed(1269,12),
0916 => to_signed(1259,12),
0917 => to_signed(1250,12),
0918 => to_signed(1240,12),
0919 => to_signed(1230,12),
0920 => to_signed(1219,12),
0921 => to_signed(1209,12),
0922 => to_signed(1199,12),
0923 => to_signed(1189,12),
0924 => to_signed(1179,12),
0925 => to_signed(1168,12),
0926 => to_signed(1158,12),
0927 => to_signed(1148,12),
0928 => to_signed(1137,12),
0929 => to_signed(1127,12),
0930 => to_signed(1116,12),
0931 => to_signed(1106,12),
0932 => to_signed(1095,12),
0933 => to_signed(1085,12),
0934 => to_signed(1074,12),
0935 => to_signed(1063,12),
0936 => to_signed(1052,12),
0937 => to_signed(1042,12),
0938 => to_signed(1031,12),
0939 => to_signed(1020,12),
0940 => to_signed(1009,12),
0941 => to_signed(998,12),
0942 => to_signed(987,12),
0943 => to_signed(976,12),
0944 => to_signed(965,12),
0945 => to_signed(954,12),
0946 => to_signed(943,12),
0947 => to_signed(932,12),
0948 => to_signed(920,12),
0949 => to_signed(909,12),
0950 => to_signed(898,12),
0951 => to_signed(886,12),
0952 => to_signed(875,12),
0953 => to_signed(864,12),
0954 => to_signed(852,12),
0955 => to_signed(841,12),
0956 => to_signed(829,12),
0957 => to_signed(818,12),
0958 => to_signed(806,12),
0959 => to_signed(795,12),
0960 => to_signed(783,12),
0961 => to_signed(772,12),
0962 => to_signed(760,12),
0963 => to_signed(748,12),
0964 => to_signed(737,12),
0965 => to_signed(725,12),
0966 => to_signed(713,12),
0967 => to_signed(701,12),
0968 => to_signed(689,12),
0969 => to_signed(678,12),
0970 => to_signed(666,12),
0971 => to_signed(654,12),
0972 => to_signed(642,12),
0973 => to_signed(630,12),
0974 => to_signed(618,12),
0975 => to_signed(606,12),
0976 => to_signed(594,12),
0977 => to_signed(582,12),
0978 => to_signed(570,12),
0979 => to_signed(558,12),
0980 => to_signed(546,12),
0981 => to_signed(534,12),
0982 => to_signed(521,12),
0983 => to_signed(509,12),
0984 => to_signed(497,12),
0985 => to_signed(485,12),
0986 => to_signed(473,12),
0987 => to_signed(460,12),
0988 => to_signed(448,12),
0989 => to_signed(436,12),
0990 => to_signed(424,12),
0991 => to_signed(411,12),
0992 => to_signed(399,12),
0993 => to_signed(387,12),
0994 => to_signed(374,12),
0995 => to_signed(362,12),
0996 => to_signed(350,12),
0997 => to_signed(337,12),
0998 => to_signed(325,12),
0999 => to_signed(312,12),
1000 => to_signed(300,12),
1001 => to_signed(288,12),
1002 => to_signed(275,12),
1003 => to_signed(263,12),
1004 => to_signed(250,12),
1005 => to_signed(238,12),
1006 => to_signed(225,12),
1007 => to_signed(213,12),
1008 => to_signed(200,12),
1009 => to_signed(188,12),
1010 => to_signed(175,12),
1011 => to_signed(163,12),
1012 => to_signed(150,12),
1013 => to_signed(138,12),
1014 => to_signed(125,12),
1015 => to_signed(113,12),
1016 => to_signed(100,12),
1017 => to_signed(87,12),
1018 => to_signed(75,12),
1019 => to_signed(62,12),
1020 => to_signed(50,12),
1021 => to_signed(37,12),
1022 => to_signed(25,12),
1023 => to_signed(12,12)
);


begin

LookupTable	:	process (clk,angulo)
begin
	seno <= mem(to_integer(angulo));
	coseno <= mem(to_integer(angulo+to_unsigned(256,10)));
end process;

end beh;
