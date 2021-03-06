\name{search.multimir}

\alias{search.multimir}

\title{
  Search the multiMiR Database Given a MySQL Query
}

\description{
  This is an internal function called by some of the other functions
  in multiMiR. Given a MySQL query, it searches and retrieves result
  from the multiMiR database on the multiMiR web server. To use
  \code{search.multimir} directly, users will need to be familiar
  with MySQL and multiMiR table structures. Users are advised to use
  \code{get.multimir} instead.
}

\usage{
  search.multimir(url = getOption("multimir.url"), query)
}

\arguments{
  \item{url}{
    a character string for the URL of the multiMiR web server.
    The default is getOption("multimir.url")
    ("http://multimir.ucdenver.edu/cgi-bin/multimir.pl").
  }
  \item{query}{
    a character string for the MySQL query.
  }
}

\value{
  \code{search.multimir} returns a data frame containing results from
  the multiMiR web server.
}

\author{
  Yuanbin Ru \email{ruyuanbin@gmail.com}
}

\examples{
  ## show all tables in the multiMiR database
  tables <- search.multimir(query="show tables")

  ## show the structure of table diana_microt
  microt <- search.multimir(query="describe diana_microt")

  ## search for validated target genes of hsa-miR-18a-3p in miRecords
  result <- search.multimir(query="select m.mature_mirna_acc, m.mature_mirna_id, t.target_symbol, t.target_entrez, t.target_ensembl, i.experiment, i.support_type, i.pubmed_id from mirna AS m INNER JOIN mirecords AS i INNER JOIN target AS t ON (m.mature_mirna_uid=i.mature_mirna_uid and i.target_uid=t.target_uid) WHERE m.mature_mirna_id='hsa-miR-18a-3p'")
}

\keyword{utilities}
\keyword{database}

