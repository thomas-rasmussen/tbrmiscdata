library(dplyr)

#### Import data ####

dat1 <- read.csv(colClasses = "character", text = "
NewCommunityCode,OldCommunityCode,RegionCode,CountyCode,NewCommunityName,OldCommunityName,CountyName,RegionName
615,601,082,60,Horsens,Brædstrup (del af),Vejle Amt,Midtjylland
615,609,082,60,Horsens,Gedved,Vejle Amt,Midtjylland
615,615,082,60,Horsens,Horsens,Vejle Amt,Midtjylland
746,601,082,60,Skanderborg,Brædstrup (del af),Vejle Amt,Midtjylland
756,625,082,60,Ikast-Brande,Nørre-Snede,Vejle Amt,Midtjylland
766,613,082,60,Hedensted,Hedensted,Vejle Amt,Midtjylland
766,619,082,60,Hedensted,Juelsminde,Vejle Amt,Midtjylland
766,627,082,60,Hedensted,Tørring-Uldum (del af),Vejle Amt,Midtjylland
846,719,081,70,Mariagerfjord,Mariager (del af),Århus Amt,Nordjylland
773,773,081,76,Morsø,Morsø,Viborg Amt,Nordjylland
787,765,081,76,Thisted,Hanstholm,Viborg Amt,Nordjylland
787,785,081,76,Thisted,Sydthy,Viborg Amt,Nordjylland
787,787,081,76,Thisted,Thisted,Viborg Amt,Nordjylland
820,793,081,76,Vesthimmerlands,Aalestrup (del af),Viborg Amt,Nordjylland
846,793,081,76,Mariagerfjord,Aalestrup (del af),Viborg Amt,Nordjylland
630,627,083,60,Vejle,Tørring-Uldum (del af),Vejle Amt,Syddanmark
101,101,084,13,København,København,Københavns Kommune,Hovedstaden
147,147,084,14,Frederiksberg,Frederiksberg,Frederiksberg Kommune,Hovedstaden
151,151,084,15,Ballerup,Ballerup,Københavns Amt,Hovedstaden
153,153,084,15,Brøndby,Brøndby,Københavns Amt,Hovedstaden
155,155,084,15,Dragør,Dragør,Københavns Amt,Hovedstaden
157,157,084,15,Gentofte,Gentofte,Københavns Amt,Hovedstaden
159,159,084,15,Gladsaxe,Gladsaxe,Københavns Amt,Hovedstaden
161,161,084,15,Glostrup,Glostrup,Københavns Amt,Hovedstaden
163,163,084,15,Herlev,Herlev,Københavns Amt,Hovedstaden
165,165,084,15,Albertslund,Albertslund,Københavns Amt,Hovedstaden
167,167,084,15,Hvidovre,Hvidovre,Københavns Amt,Hovedstaden
169,169,084,15,Høje-Taastrup,Høje-Taastrup,Københavns Amt,Hovedstaden
173,173,084,15,Lyngby-Tårbæk,Lyngby-Tårbæk,Københavns Amt,Hovedstaden
175,175,084,15,Rødovre,Rødovre,Københavns Amt,Hovedstaden
183,183,084,15,Ishøj,Ishøj,Københavns Amt,Hovedstaden
185,185,084,15,Tårnby,Tårnby,Københavns Amt,Hovedstaden
187,187,084,15,Vallensbæk,Vallensbæk,Københavns Amt,Hovedstaden
190,189,084,15,Furesø,Værløse,Københavns Amt,Hovedstaden
230,181,084,15,Rudersdal,Søllerød,Københavns Amt,Hovedstaden
240,171,084,15,Egedal,Ledøje-Smørum,Københavns Amt,Hovedstaden
190,207,084,20,Furesø,Farum,Frederiksborg Amt,Hovedstaden
201,201,084,20,Allerød,Allerød,Frederiksborg Amt,Hovedstaden
210,208,084,20,Fredensborg,Fredensborg-Humlebæk,Frederiksborg Amt,Hovedstaden
210,227,084,20,Fredensborg,Karlebo,Frederiksborg Amt,Hovedstaden
217,217,084,20,Helsingør,Helsingør,Frederiksborg Amt,Hovedstaden
219,219,084,20,Hillerød,Hillerød,Frederiksborg Amt,Hovedstaden
219,231,084,20,Hillerød,Skævinge,Frederiksborg Amt,Hovedstaden
219,233,084,20,Hillerød,Slangerup (del af),Frederiksborg Amt,Hovedstaden
223,223,084,20,Hørsholm,Hørsholm,Frederiksborg Amt,Hovedstaden
230,205,084,20,Rudersdal,Birkerød,Frederiksborg Amt,Hovedstaden
240,235,084,20,Egedal,Stenløse,Frederiksborg Amt,Hovedstaden
240,237,084,20,Egedal,Ølstykke,Frederiksborg Amt,Hovedstaden
250,209,084,20,Frederikssund,Frederikssund,Frederiksborg Amt,Hovedstaden
250,225,084,20,Frederikssund,Jægerspris,Frederiksborg Amt,Hovedstaden
250,229,084,20,Frederikssund,Skibby,Frederiksborg Amt,Hovedstaden
250,233,084,20,Frederikssund,Slangerup (del af),Frederiksborg Amt,Hovedstaden
260,211,084,20,Frederiksværk-Hundested,Frederiksværk,Frederiksborg Amt,Hovedstaden
260,221,084,20,Frederiksværk-Hundested,Hundested,Frederiksborg Amt,Hovedstaden
270,213,084,20,Gribskov,Græsted-Gilleleje,Frederiksborg Amt,Hovedstaden
270,215,084,20,Gribskov,Helsinge,Frederiksborg Amt,Hovedstaden
253,253,085,25,Greve,Greve,Roskilde Amt,Sjælland
259,259,085,25,Køge,Køge,Roskilde Amt,Sjælland
259,267,085,25,Køge,Skovbo,Roskilde Amt,Sjælland
265,255,085,25,Roskilde,Gundsø,Roskilde Amt,Sjælland
265,263,085,25,Roskilde,Ramsø,Roskilde Amt,Sjælland
265,265,085,25,Roskilde,Roskilde,Roskilde Amt,Sjælland
269,269,085,25,Solrød,Solrød,Roskilde Amt,Sjælland
336,271,085,25,Stevns,Vallø,Roskilde Amt,Sjælland
350,251,085,25,Lejre,Bramsnæs,Roskilde Amt,Sjælland
350,257,085,25,Lejre,Hvalsø,Roskilde Amt,Sjælland
350,261,085,25,Lejre,Lejre,Roskilde Amt,Sjælland
306,305,085,30,Odsherred,Dragsholm,Vestsjællands Amt,Sjælland
306,327,085,30,Odsherred,Nykøbing-Rørvig,Vestsjællands Amt,Sjælland
306,343,085,30,Odsherred,Trundholm,Vestsjællands Amt,Sjælland
316,315,085,30,Holbæk,Holbæk,Vestsjællands Amt,Sjælland
316,321,085,30,Holbæk,Jernløse,Vestsjællands Amt,Sjælland
316,339,085,30,Holbæk,Svinninge,Vestsjællands Amt,Sjælland
316,341,085,30,Holbæk,Tornved,Vestsjællands Amt,Sjælland
316,345,085,30,Holbæk,Tølløse,Vestsjællands Amt,Sjælland
320,313,085,30,Faxe,Haslev,Vestsjællands Amt,Sjælland
326,301,085,30,Kalundborg,Bjergsted,Vestsjællands Amt,Sjælland
326,309,085,30,Kalundborg,Gørlev,Vestsjællands Amt,Sjælland
326,317,085,30,Kalundborg,Hvidebæk,Vestsjællands Amt,Sjælland
326,319,085,30,Kalundborg,Høng,Vestsjællands Amt,Sjælland
326,323,085,30,Kalundborg,Kalundborg,Vestsjællands Amt,Sjælland
329,329,085,30,Ringsted,Ringsted,Vestsjællands Amt,Sjælland
330,311,085,30,Slagelse,Hashøj,Vestsjællands Amt,Sjælland
330,325,085,30,Slagelse,Korsør,Vestsjællands Amt,Sjælland
330,331,085,30,Slagelse,Skælskør,Vestsjællands Amt,Sjælland
330,333,085,30,Slagelse,Slagelse,Vestsjællands Amt,Sjælland
340,303,085,30,Sorø,Dianalund,Vestsjællands Amt,Sjælland
340,335,085,30,Sorø,Sorø,Vestsjællands Amt,Sjælland
340,337,085,30,Sorø,Stenlille,Vestsjællands Amt,Sjælland
370,307,085,30,Næstved,Fuglebjerg,Vestsjællands Amt,Sjælland
320,351,085,35,Faxe,Fakse,Storstrøms Amt,Sjælland
320,385,085,35,Faxe,Rønnede,Storstrøms Amt,Sjælland
336,389,085,35,Stevns,Stevns,Storstrøms Amt,Sjælland
360,355,085,35,Lolland,Holeby,Storstrøms Amt,Sjælland
360,359,085,35,Lolland,Højreby,Storstrøms Amt,Sjælland
360,363,085,35,Lolland,Maribo,Storstrøms Amt,Sjælland
360,367,085,35,Lolland,Nakskov,Storstrøms Amt,Sjælland
360,379,085,35,Lolland,Ravnsborg,Storstrøms Amt,Sjælland
360,381,085,35,Lolland,Rudbjerg,Storstrøms Amt,Sjælland
360,383,085,35,Lolland,Rødby,Storstrøms Amt,Sjælland
370,353,085,35,Næstved,Fladså,Storstrøms Amt,Sjælland
370,357,085,35,Næstved,Holmegård,Storstrøms Amt,Sjælland
370,373,085,35,Næstved,Næstved,Storstrøms Amt,Sjælland
370,393,085,35,Næstved,Suså,Storstrøms Amt,Sjælland
376,369,085,35,Guldborgsund,Nykøbing-Falster,Storstrøms Amt,Sjælland
376,371,085,35,Guldborgsund,Nysted,Storstrøms Amt,Sjælland
376,375,085,35,Guldborgsund,Nørre-Alslev,Storstrøms Amt,Sjælland
376,387,085,35,Guldborgsund,Sakskøbing,Storstrøms Amt,Sjælland
376,391,085,35,Guldborgsund,Stubbekøbing,Storstrøms Amt,Sjælland
376,395,085,35,Guldborgsund,Sydfalster,Storstrøms Amt,Sjælland
390,361,085,35,Vordingborg,Langebæk,Storstrøms Amt,Sjælland
390,365,085,35,Vordingborg,Møn,Storstrøms Amt,Sjælland
390,377,085,35,Vordingborg,Præstø,Storstrøms Amt,Sjælland
390,397,085,35,Vordingborg,Vordingborg,Storstrøms Amt,Sjælland
400,400,084,40,Bornholm,Bornholms Region,Bornholms Amt,Hovedstaden
410,429,083,42,Middelfart,Ejby,Fyns Amt,Syddanmark
410,445,083,42,Middelfart,Middelfart,Fyns Amt,Syddanmark
410,451,083,42,Middelfart,Nørre Aaby,Fyns Amt,Syddanmark
420,421,083,42,Assens,Assens,Fyns Amt,Syddanmark
420,433,083,42,Assens,Glamsbjerg,Fyns Amt,Syddanmark
420,437,083,42,Assens,Hårby,Fyns Amt,Syddanmark
420,485,083,42,Assens,Tommerup,Fyns Amt,Syddanmark
420,491,083,42,Assens,Vissenbjerg,Fyns Amt,Syddanmark
420,499,083,42,Assens,Årup,Fyns Amt,Syddanmark
430,425,083,42,Faaborg-Midtfyn,Broby,Fyns Amt,Syddanmark
430,431,083,42,Faaborg-Midtfyn,Fåborg,Fyns Amt,Syddanmark
430,473,083,42,Faaborg-Midtfyn,Ringe,Fyns Amt,Syddanmark
430,477,083,42,Faaborg-Midtfyn,Ryslinge,Fyns Amt,Syddanmark
430,497,083,42,Faaborg-Midtfyn,Årslev,Fyns Amt,Syddanmark
440,439,083,42,Kerteminde,Kerteminde,Fyns Amt,Syddanmark
440,441,083,42,Kerteminde,Langeskov,Fyns Amt,Syddanmark
440,447,083,42,Kerteminde,Munkebo,Fyns Amt,Syddanmark
450,449,083,42,Nyborg,Nyborg,Fyns Amt,Syddanmark
450,489,083,42,Nyborg,Ullerslev,Fyns Amt,Syddanmark
450,495,083,42,Nyborg,Ørbæk,Fyns Amt,Syddanmark
461,461,083,42,Odense,Odense,Fyns Amt,Syddanmark
479,427,083,42,Svendborg,Egebjerg,Fyns Amt,Syddanmark
479,435,083,42,Svendborg,Gudme,Fyns Amt,Syddanmark
479,479,083,42,Svendborg,Svendborg,Fyns Amt,Syddanmark
480,423,083,42,Nordfyns,Bogense,Fyns Amt,Syddanmark
480,471,083,42,Nordfyns,Otterup,Fyns Amt,Syddanmark
480,483,083,42,Nordfyns,Søndersø,Fyns Amt,Syddanmark
482,475,083,42,Langeland,Rudkøbing,Fyns Amt,Syddanmark
482,481,083,42,Langeland,Sydlangeland,Fyns Amt,Syddanmark
482,487,083,42,Langeland,Tranekær,Fyns Amt,Syddanmark
492,443,083,42,Ærø,Marstal,Fyns Amt,Syddanmark
492,493,083,42,Ærø,Ærøskøbing,Fyns Amt,Syddanmark
510,509,083,50,Haderslev,Christiansfeld (del af),Sønderjyllands Amt,Syddanmark
510,511,083,50,Haderslev,Gram,Sønderjyllands Amt,Syddanmark
510,515,083,50,Haderslev,Haderslev,Sønderjyllands Amt,Syddanmark
510,525,083,50,Haderslev,Nørre-Rangsstrup (del af),Sønderjyllands Amt,Syddanmark
510,543,083,50,Haderslev,Vojens,Sønderjyllands Amt,Syddanmark
540,501,083,50,Sønderborg,Augustenborg,Sønderjyllands Amt,Syddanmark
540,507,083,50,Sønderborg,Broager,Sønderjyllands Amt,Syddanmark
540,513,083,50,Sønderborg,Gråsten,Sønderjyllands Amt,Syddanmark
540,523,083,50,Sønderborg,Nordborg,Sønderjyllands Amt,Syddanmark
540,533,083,50,Sønderborg,Sundeved,Sønderjyllands Amt,Syddanmark
540,535,083,50,Sønderborg,Sydals,Sønderjyllands Amt,Syddanmark
540,537,083,50,Sønderborg,Sønderborg,Sønderjyllands Amt,Syddanmark
550,505,083,50,Tønder,Bredebro,Sønderjyllands Amt,Syddanmark
550,517,083,50,Tønder,Højer,Sønderjyllands Amt,Syddanmark
550,521,083,50,Tønder,Løgumkloster,Sønderjyllands Amt,Syddanmark
550,525,083,50,Tønder,Nørre-Rangsstrup (del af),Sønderjyllands Amt,Syddanmark
550,531,083,50,Tønder,Skærbæk,Sønderjyllands Amt,Syddanmark
550,541,083,50,Tønder,Tønder,Sønderjyllands Amt,Syddanmark
575,527,083,50,Vejen,Rødding,Sønderjyllands Amt,Syddanmark
580,503,083,50,Aabenraa,Bov,Sønderjyllands Amt,Syddanmark
580,519,083,50,Aabenraa,Lundtoft,Sønderjyllands Amt,Syddanmark
580,529,083,50,Aabenraa,Rødekro,Sønderjyllands Amt,Syddanmark
580,539,083,50,Aabenraa,Tinglev,Sønderjyllands Amt,Syddanmark
580,545,083,50,Aabenraa,Aabenraa,Sønderjyllands Amt,Syddanmark
621,509,083,50,Kolding,Christiansfeld (del af),Sønderjyllands Amt,Syddanmark
530,551,083,55,Billund,Billund,Ribe Amt,Syddanmark
530,565,083,55,Billund,Grindsted,Ribe Amt,Syddanmark
561,557,083,55,Esbjerg,Bramming,Ribe Amt,Syddanmark
561,561,083,55,Esbjerg,Esbjerg,Ribe Amt,Syddanmark
561,567,083,55,Esbjerg,Helle (del af),Ribe Amt,Syddanmark
561,571,083,55,Esbjerg,Ribe,Ribe Amt,Syddanmark
563,563,083,55,Fanø,Fanø,Ribe Amt,Syddanmark
573,553,083,55,Varde,Blåbjerg,Ribe Amt,Syddanmark
573,555,083,55,Varde,Blåvandshuk,Ribe Amt,Syddanmark
573,567,083,55,Varde,Helle (del af),Ribe Amt,Syddanmark
573,573,083,55,Varde,Varde,Ribe Amt,Syddanmark
573,577,083,55,Varde,Ølgod,Ribe Amt,Syddanmark
575,559,083,55,Vejen,Brørup,Ribe Amt,Syddanmark
575,569,083,55,Vejen,Holsted,Ribe Amt,Syddanmark
575,575,083,55,Vejen,Vejen,Ribe Amt,Syddanmark
530,611,083,60,Billund,Give (del af),Vejle Amt,Syddanmark
607,607,083,60,Fredericia,Fredericia,Vejle Amt,Syddanmark
621,605,083,60,Kolding,Egtved (del af),Vejle Amt,Syddanmark
621,621,083,60,Kolding,Kolding,Vejle Amt,Syddanmark
621,623,083,60,Kolding,Lunderskov,Vejle Amt,Syddanmark
621,629,083,60,Kolding,Vamdrup,Vejle Amt,Syddanmark
630,617,083,60,Vejle,Jelling,Vejle Amt,Syddanmark
630,603,083,60,Vejle,Børkop,Vejle Amt,Syddanmark
630,605,083,60,Vejle,Egtved (del af),Vejle Amt,Syddanmark
630,611,083,60,Vejle,Give (del af),Vejle Amt,Syddanmark
630,631,083,60,Vejle,Vejle,Vejle Amt,Syddanmark
657,651,082,65,Herning,Aulum-Haderup,Ringkjøbing Amt,Midtjylland
657,657,082,65,Herning,Herning,Ringkjøbing Amt,Midtjylland
657,677,082,65,Herning,Trehøje,Ringkjøbing Amt,Midtjylland
657,685,082,65,Herning,Åskov,Ringkjøbing Amt,Midtjylland
661,661,082,65,Holstebro,Holstebro,Ringkjøbing Amt,Midtjylland
661,679,082,65,Holstebro,Ulfborg-Vemb,Ringkjøbing Amt,Midtjylland
661,683,082,65,Holstebro,Vinderup,Ringkjøbing Amt,Midtjylland
665,665,082,65,Lemvig,Lemvig,Ringkjøbing Amt,Midtjylland
665,673,082,65,Lemvig,Thyborøn-Harboøre,Ringkjøbing Amt,Midtjylland
671,671,082,65,Struer,Struer,Ringkjøbing Amt,Midtjylland
671,675,082,65,Struer,Thyholm,Ringkjøbing Amt,Midtjylland
756,653,082,65,Ikast-Brande,Brande,Ringkjøbing Amt,Midtjylland
756,663,082,65,Ikast-Brande,Ikast,Ringkjøbing Amt,Midtjylland
760,655,082,65,Ringkøbing-Skjern,Egvad,Ringkjøbing Amt,Midtjylland
760,659,082,65,Ringkøbing-Skjern,Holmsland,Ringkjøbing Amt,Midtjylland
760,667,082,65,Ringkøbing-Skjern,Ringkøbing,Ringkjøbing Amt,Midtjylland
760,669,082,65,Ringkøbing-Skjern,Skjern,Ringkjøbing Amt,Midtjylland
760,681,082,65,Ringkøbing-Skjern,Videbæk,Ringkjøbing Amt,Midtjylland
706,701,082,70,Syddjurs,Ebeltoft,Århus Amt,Midtjylland
706,721,082,70,Syddjurs,Midtdjurs,Århus Amt,Midtjylland
706,733,082,70,Syddjurs,Rosenholm,Århus Amt,Midtjylland
706,739,082,70,Syddjurs,Rønde,Århus Amt,Midtjylland
707,707,082,70,Norddjurs,Grenå,Århus Amt,Midtjylland
707,725,082,70,Norddjurs,Nørre Djurs,Århus Amt,Midtjylland
707,735,082,70,Norddjurs,Rougsø,Århus Amt,Midtjylland
707,747,082,70,Norddjurs,Sønderhald (del af),Århus Amt,Midtjylland
710,709,082,70,Favrskov,Hadsten,Århus Amt,Midtjylland
710,711,082,70,Favrskov,Hammel,Århus Amt,Midtjylland
710,713,082,70,Favrskov,Hinnerup,Århus Amt,Midtjylland
710,717,082,70,Favrskov,Langå (del af),Århus Amt,Midtjylland
727,727,082,70,Odder,Odder,Århus Amt,Midtjylland
730,717,082,70,Randers,Langå (del af),Århus Amt,Midtjylland
730,719,082,70,Randers,Mariager (del af),Århus Amt,Midtjylland
730,723,082,70,Randers,Nørhald,Århus Amt,Midtjylland
730,729,082,70,Randers,Purhus,Århus Amt,Midtjylland
730,731,082,70,Randers,Randers,Århus Amt,Midtjylland
730,747,082,70,Randers,Sønderhald (del af),Århus Amt,Midtjylland
740,705,082,70,Silkeborg,Gjern,Århus Amt,Midtjylland
740,743,082,70,Silkeborg,Silkeborg,Århus Amt,Midtjylland
740,749,082,70,Silkeborg,Them,Århus Amt,Midtjylland
741,741,082,70,Samsø,Samsø,Århus Amt,Midtjylland
746,703,082,70,Skanderborg,Galten,Århus Amt,Midtjylland
746,715,082,70,Skanderborg,Hørning,Århus Amt,Midtjylland
746,737,082,70,Skanderborg,Ry,Århus Amt,Midtjylland
746,745,082,70,Skanderborg,Skanderborg,Århus Amt,Midtjylland
751,751,082,70,Århus,Århus,Århus Amt,Midtjylland
710,767,082,76,Favrskov,Hvorslev,Viborg Amt,Midtjylland
740,771,082,76,Silkeborg,Kjellerup,Viborg Amt,Midtjylland
779,777,082,76,Skive,Sallingsund,Viborg Amt,Midtjylland
779,779,082,76,Skive,Skive,Viborg Amt,Midtjylland
779,781,082,76,Skive,Spøttrup,Viborg Amt,Midtjylland
779,783,082,76,Skive,Sundsøre,Viborg Amt,Midtjylland
791,761,082,76,Viborg,Bjerringbro,Viborg Amt,Midtjylland
791,763,082,76,Viborg,Fjends,Viborg Amt,Midtjylland
791,769,082,76,Viborg,Karup,Viborg Amt,Midtjylland
791,775,082,76,Viborg,Møldrup,Viborg Amt,Midtjylland
791,789,082,76,Viborg,Tjele,Viborg Amt,Midtjylland
791,791,082,76,Viborg,Viborg,Viborg Amt,Midtjylland
791,793,082,76,Viborg,Aalestrup (del af),Viborg Amt,Midtjylland
810,805,081,80,Brønderslev-Dronninglund,Brønderslev,Nordjyllands Amt,Nordjylland
810,807,081,80,Brønderslev-Dronninglund,Dronninglund,Nordjyllands Amt,Nordjylland
813,813,081,80,Frederikshavn,Frederikshavn,Nordjyllands Amt,Nordjylland
813,841,081,80,Frederikshavn,Skagen,Nordjyllands Amt,Nordjylland
813,847,081,80,Frederikshavn,Sæby,Nordjyllands Amt,Nordjylland
820,809,081,80,Vesthimmerlands,Farsø,Nordjyllands Amt,Nordjylland
820,827,081,80,Vesthimmerlands,Løgstør,Nordjyllands Amt,Nordjylland
820,861,081,80,Vesthimmerlands,Aars,Nordjyllands Amt,Nordjylland
825,825,081,80,Læsø,Læsø,Nordjyllands Amt,Nordjylland
840,833,081,80,Rebild,Nørager (del af),Nordjyllands Amt,Nordjylland
840,843,081,80,Rebild,Skørping,Nordjyllands Amt,Nordjylland
840,845,081,80,Rebild,Støvring,Nordjyllands Amt,Nordjylland
846,801,081,80,Mariagerfjord,Arden,Nordjyllands Amt,Nordjylland
846,815,081,80,Mariagerfjord,Hadsund,Nordjyllands Amt,Nordjylland
846,823,081,80,Mariagerfjord,Hobro,Nordjyllands Amt,Nordjylland
846,833,081,80,Mariagerfjord,Nørager (del af),Nordjyllands Amt,Nordjylland
849,803,081,80,Jammerbugt,Brovst,Nordjyllands Amt,Nordjylland
849,811,081,80,Jammerbugt,Fjerritslev,Nordjyllands Amt,Nordjylland
849,835,081,80,Jammerbugt,Pandrup,Nordjyllands Amt,Nordjylland
849,849,081,80,Jammerbugt,Aabybro,Nordjyllands Amt,Nordjylland
851,817,081,80,Aalborg,Hals,Nordjyllands Amt,Nordjylland
851,831,081,80,Aalborg,Nibe,Nordjyllands Amt,Nordjylland
851,837,081,80,Aalborg,Sejlflod,Nordjyllands Amt,Nordjylland
851,851,081,80,Aalborg,Aalborg,Nordjyllands Amt,Nordjylland
860,819,081,80,Hjørring,Hirtshals,Nordjyllands Amt,Nordjylland
860,821,081,80,Hjørring,Hjørring,Nordjyllands Amt,Nordjylland
860,829,081,80,Hjørring,Løkken-Vrå,Nordjyllands Amt,Nordjylland
860,839,081,80,Hjørring,Sindal,Nordjyllands Amt,Nordjylland
.,.,090,.,Grønland,,Grønland,Grønland
400,401,084,40,Bornholm,Allinge-Gudhjem,Bornholms Amt,Hovedstaden
400,403,084,40,Bornholm,Hasle,Bornholms Amt,Hovedstaden
400,405,084,40,Bornholm,Neksø,Bornholms Amt,Hovedstaden
400,407,084,40,Bornholm,Rønne,Bornholms Amt,Hovedstaden
400,409,084,40,Bornholm,Aakirkeby,Bornholms Amt,Hovedstaden"
)

#### Clean data ####

dat2 <- dat1 %>%
  # Remove the data line with a missing municipality code interpreted as meaning
  # Greenland. This assumption seems questionable and will not be made here.
  filter(OldCommunityCode != ".") %>%
  select(-c("CountyCode", "CountyName")) %>%
  # Make more intuitive variable names
  rename(
    municipality_code = OldCommunityCode,
    updated_municipality_code = NewCommunityCode,
    municipality_name = OldCommunityName,
    updated_municipality_name = NewCommunityName,
    region_code = RegionCode,
    region_name = RegionName
    ) %>%
  # Correct spelling mistakes
  mutate(
    updated_municipality_name = case_when(
      updated_municipality_name == "Vesthimmerlands" ~ "Vesthimmerland",
      TRUE ~ updated_municipality_name
    )
  ) %>%
  relocate(
    municipality_code,
    updated_municipality_code,
    municipality_name,
    updated_municipality_name,
    region_code,
    region_name
  ) %>%
  arrange(municipality_code)


#### Allocate codes to unique new municipality ####

# In a few cases, old municipalities were split up in the 2007 reform.
# The data includes a line for each of the new municipalities the old
# municipality is now a part of. We choose to only allocate such municipalities
# to the new municipality for which it is most included in, based on a subjective
# visual assessment based on a map ( see ext-figures branch of github repo).
# This ensures that there is a 1-1 translation of old to new codes.
new_codes <- read.csv(colClasses = "character", strip.white = TRUE, text = "
municipality_code,  updated_municipality_code,  municipality_name,  updated_municipality_name,  region_code,  region_name
793,                820,                        Aalestrup,          Vesthimmerland,             081,          Nordjylland
601,                615,                        Brædstrup,          Horsens,                    082,          Midtjylland
509,                621,                        Christiansfeld,     Kolding,                    083,          Syddanmark
605,                630,                        Egtved,             Vejle,                      083,          Syddanmark
611,                630,                        Give,               Vejle,                      083,          Syddanmark
567,                573,                        Helle,              Varde,                      083,          Syddanmark
717,                730,                        Langå,              Randers,                    082,          Midtjylland
719,                846,                        Mariager,           Mariagerfjord,              081,          Nordjylland
833,                840,                        Nørager,            Rebild,                     081,          Nordjylland
525,                550,                        Nørre-Rangsstrup,   Tønder,                     083,          Syddanmark
233,                250,                        Slangerup,          Frederikssund,              084,          Hovedstaden
747,                730,                        Sønderhald,         Randers,                    082,          Midtjylland
627,                766,                        Tørring-Uldum,      Hedensted,                  082,          Midtjylland
")

dat3 <- dat2 %>%
  # Remove affected data lines
  filter(!municipality_name %in% c(
    "Aalestrup (del af)",
    "Brædstrup (del af)",
    "Christiansfeld (del af)",
    "Egtved (del af)",
    "Give (del af)",
    "Helle (del af)",
    "Langå (del af)",
    "Mariager (del af)",
    "Nørager (del af)",
    "Nørre-Rangsstrup (del af)",
    "Slangerup (del af)",
    "Sønderhald (del af)",
    "Tørring-Uldum (del af)"
  )) %>%
  # Add updated data lines
  bind_rows(new_codes) %>%
  arrange(municipality_code)


#### Add codes introduced in 2007 reform ####

# In cases where a new municipality code was introduced in 2007 instead of
# reusing an old code, there is no data line mapping the code to itself,
# the same way that there is for reused codes. Eg there is a data line
# for Horsens, mapping code 615 to 615 since Horsens and other municipalities
# were combined in 2007 into a new municipality also called Horsens, using the
# same code as was used for Horsens prior to the 2007 reform.
# We will add such data lines for these new codes to rectify this.
dat4 <- dat3 %>%
  filter(!(updated_municipality_code %in% municipality_code)) %>%
  mutate(
    municipality_code = updated_municipality_code,
    municipality_name = updated_municipality_name
  ) %>%
  distinct(updated_municipality_code, .keep_all = TRUE) %>%
  bind_rows(dat3) %>%
  arrange(municipality_code)


#### Add proxy codes ####

# Add additional proxy codes encountered in Danish registries to facilitate
# identification of unknown/unwanted municipality data.

# Christiansø. Not a true municipality, but the code appears in real data and
# persons with this code is usually included in analyses and allocated to
# the Capital region.
new_codes <- read.csv(colClasses = "character", strip.white = TRUE, text = "
municipality_code, municipality_name, region_code, region_name
411, Christiansø, 084, Hovedstaden
")

new_codes <- new_codes %>%
  mutate(
    updated_municipality_code = municipality_code,
    updated_municipality_name = municipality_name
  )

dat5 <- dat4 %>%
  bind_rows(new_codes) %>%
  arrange(municipality_code)

# Add municipality codes used in Greenland
new_codes <- read.csv(colClasses = "character", strip.white = TRUE, text = "
municipality_code,  municipality_name
901,                Christianshåb
903,                Egedesminde
905,                Frederikshåb
907,                Godhavn
909,                Godthåb
911,                Holsteinsborg
913,                Ivigtut
915,                Jacobshavn
917,                Julianehåb
919,                Kangatsiaq
921,                Nanortalik
923,                Narssaq
925,                Sukkertoppen
927,                Umanak
929,                Upernavik
941,                Thule
951,                Angmassalik
953,                Scoresbysund
961,                Uden for den kommunale inddeling i Grønland
931,                Ukendt
933,                Ukendt
935,                Ukendt
937,                Ukendt
939,                Ukendt
943,                Ukendt
945,                Ukendt
947,                Ukendt
949,                Ukendt
955,                Ukendt
957,                Ukendt
959,                Ukendt
963,                Ukendt
")

new_codes <- new_codes %>%
  mutate(
    updated_municipality_code = municipality_code,
    updated_municipality_name = municipality_name,
    region_code = "090",
    region_name = "Grønland"
  )

dat6 <- dat5 %>%
  bind_rows(new_codes) %>%
  arrange(municipality_code)

# Add unknown/missing proxy codes. There are several codes used to indicate
# missing or unknown municipality, or other miscellaneous values that should be
# grouped as such.
new_codes <- read.csv(colClasses = "character", strip.white = TRUE, text = "
municipality_code
000
001
002
003
004
005
006
007
008
009
010
011
012
019
996
997
999
")

new_codes <- new_codes %>%
  mutate(
    updated_municipality_code = municipality_code,
    municipality_name = "Ukendt",
    updated_municipality_name = "Ukendt",
    region_code = "",
    region_name = "Ukendt"
  )

dat7 <- dat6 %>%
  bind_rows(new_codes) %>%
  arrange(municipality_code)


#### Save data ####

dk_municipality_codes <- dat7

usethis::use_data(dk_municipality_codes, overwrite = TRUE)
