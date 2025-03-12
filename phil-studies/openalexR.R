require(openalexR)
options(openalexR.mailto = "weath@umich.edu")

10.1007/s11098-013-0227-2

works_from_dois <- oa_fetch(
  entity = "works",
  doi = c("10.1007/s11098-013-0227-2"),
  verbose = TRUE
)

rrm <- works_from_dois