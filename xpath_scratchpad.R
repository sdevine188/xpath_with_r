## for reference, see http://www.stat.purdue.edu/~mdw/490M/STAT490Mday29.txt
## and http://www.w3schools.com/xpath/xpath_syntax.asp

library(XML)

## xmlInternalTreeParse works for non-broken websites like wikipedia
## but for broken websites like project syndicate, need to ust htmlTreeParse
xml <- xmlInternalTreeParse("http://en.wikipedia.org/wiki/R_%28programming_language%29")
xml <- xmlInternalTreeParse("http://www.project-syndicate.org/columnist/michael-boskin.xml")

## examples of getNodeSet
## avoid // if possible, since this forces xpath to search entire xml document
## if you know the static xml structure, then just navigate directly to xml of interest
page <- htmlTreeParse("http://www.project-syndicate.org/columnist/michael-boskin", useInternalNodes = TRUE)
body <- getNodeSet(page, "/html/body")
div <- getNodeSet(page, "/html/body/div")
div4 <- getNodeSet(page, "/html/body/div[4]")
section <- getNodeSet(page, "/html/body/section")
## get first "section" node
section[[1]]

## pin-point section node with class attribute called "row"
section <- getNodeSet(page, "/html/body/section[@class = \"row\"]")

## generalize the reference to get the article by starting from closest node that is unlikely to change with website updates
article2 <- getNodeSet(page, "//div[@id = \"tab-commentaries\"][1]/article/a/@href")

article <- getNodeSet(page, "/html/body/section/div[2]/article/a/@href")
## get first "@href" 
## first is class XMLAttributeValue
article[1]
## this is attribute called "href"
article[[1]][1]
## this is the string url
toString(article[1])

## examples of xpathSApply
## not used in project syndicate, but useful if you have clean xml like the purdue or w3c example
article_value <- xpathSApply(page, "/html/body/section/div[2]/article/a/@href", xmlValue)

## pull title and article text from project syndicate
xml_article <- htmlTreeParse("http://www.project-syndicate.org/commentary/europe-prosperity-obstacles-by-michael-boskin-2015-02",
                             useInternalNodes = TRUE)
title <- 
