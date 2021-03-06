\name{get.multimir}

\alias{get.multimir}

\title{
  Get microRNA-target Interactions from the multiMiR Package
}

\description{
  The main function to retrieve predicted and validated miRNA-target
  interactions and their disease and drug associations from the
  multiMiR package.
}

\usage{
  get.multimir(url = getOption("multimir.url"), org = 'hsa', mirna = NULL,
               target = NULL, disease.drug = NULL, table = 'validated',
               predicted.cutoff = NULL, predicted.cutoff.type = 'p',
               predicted.site = 'conserved', summary = FALSE,
               add.link = FALSE)
}

\arguments{
  \item{url}{
    a character string for the URL of the multiMiR web server.
    The default is getOption(" multimir.url")
    ("http://multimir.ucdenver.edu/cgi-bin/multimir.pl").
  }
  \item{org}{
    a character string for the organism. Three organisms are supported
    so far: human ("hsa" (default), "human", or "Homo Sapiens"), mouse
    ("mmu", "mouse", or "Mus musculus"), and rat ("rno", "rat", or
    "Rattus norvegicus"). The organism is case insensitive.
  }
  \item{mirna}{
    'NULL' (default) or a character string or character vector for
    the mature miRNA(s). It can be the mature miRNA accession number
    (i.e. "MIMAT0000072"), mature miRNA ID (i.e. "hsa-miR-199a-3p"),
    or a combination of both (i.e. c("MIMAT0000065", "hsa-miR-30a-5p")).
    The character is case insensitive. *See note about the length of list supported.
  }
  \item{target}{
    'NULL' (default) or a character string or character vector for
    the target gene(s). It can be the gene symbol (i.e. c("TP53", "KRAS")),
    Entrez gene ID (i.e. c(578, 3845)), Ensembl gene ID (i.e.
    "ENSG00000171791"), or a combination of any of these identifiers
    (i.e. c("TP53", 3845, "ENSG00000171791")). The character is case
    insensitive. *See note about the length of list supported.
  }
  \item{disease.drug}{
    'NULL' (default) or a character string or character vector for
    the disease(s) and/or drug(s) (i.e. c("bladder cancer", "cisplatin")).
    The character is case insensitive.
  }
  \item{table}{
    a character string indicating which table(s) in multiMiR to
    search. Each table contains data from an external database.
    Options include "validated" (default, to search all validated
    tables "mirecords", "mirtarbase", and "tarbase"), "predicted"
    (to search all predicted tables "diana_microt", "elmmo",
    "microcosm", "miranda", "mirdb", "pictar", "pita", and
    "targetscan"), "disease.drug" (to search all disease/drug tables
    "mir2disease", "pharmaco_mir", and "phenomir"), "all" (to search
    all of the tables above), or an individual table from above.
  }
  \item{predicted.cutoff.type}{
    a character indicating the type of prediction score cutoff. This
    must be either "p" (default, percentage cutoff) or "n"
    (number cutoff).
  }
  \item{predicted.cutoff}{
    'NULL' (default) or an integer giving a prediction score cutoff.
    By default ('NULL'), the cutoff is '20' (search the top 20\% if
    \code{predicted.cutoff.type="p"}) or '300000' (search the top
    300000 (or all records if total < 300000) if
    \code{predicted.cutoff.type="n"}).
  }
  \item{predicted.site}{
    a character string indicating the type of predicted target sites
    to search. This can be one of the strings "conserved",
    "nonconserved", or "all", and can be abbreviated. This only
    applies to three of the predicted tables ("miranda", "pita", and
    "targetscan") that have conservation information of the target
    sites.
  }
  \item{summary}{
    logical. Whether to summarize the result (default = FALSE).
  }
  \item{add.link}{
    logical. Whether to add link to external database for each result
    entry.
  }
}

\details{
  \code{get.multimir} is the main and recommended function to retrieve
  information from the multiMiR package. Input to the function must
  contain at least one of the followings: miRNA(s), target gene(s),
  and disease and drug term(s).

  The setting of \code{predicted.site} is applicable to three
  ("miranda", "pita", and "targetscan") of the eight predicted tables.
  If \code{predicted.site} is \code{"conserved"}, the function will
  search conserved target sites annotated by TargetScan, target sites
  with conservation scores greater than or equal to 0.57 (in human and
  rat; or 0.566 in mouse) in miRanda, and/or sites with conservation
  scores greater than or equal to 0.9 in PITA.

  Although the summary (if \code{summary=TRUE}) can be used to find
  results that are recorded by combinations of different databases,
  please note that for predicted interactions a combination approach
  may not be as effective as a single algorithm because of age or quality
  of the tool.
  
  Note: The length of the list supported has been increased from 
  version1.0.1.  The size is now limited to 20MB which should accommodate
  most requests.  There is a possibility for technical reasons that the 
  query could fail even if the list is under this limit.  If this occurs 
  it is recommended that you break up the list into smaller batches and 
  submit them sequentially.

}

\value{
  \code{get.multimir} returns a list with several data frames
  containing results from a given external database (e.g., if 
  \code{table="targetscan"}), the predicted (if \code{table=
  "predicted"}), validated (if \code{table="validated"}), and
  disease and drug (if \code{table="disease.drug"}) components of
  multiMiR, and a summary (if \code{summary=TRUE}).
}

\author{
  Yuanbin Ru \email{ruyuanbin@gmail.com}
}

\examples{
  ## search 'hsa-miR-18a-3p' in validated interactions in human
  example1 <- get.multimir(mirna='hsa-miR-18a-3p', summary=TRUE)
  names(example1)
  ## target genes that are validated by Luciferase assay
  example1$validated[grep("Luciferase", example1$validated[,"experiment"]),]
  example1$summary[example1$summary[,"target_symbol"] == "KRAS",]

  ## search 'cisplatin' in disease and drug tables in human
  example2 <- get.multimir(disease.drug='cisplatin', table='disease.drug')
  nrow(example2$disease.drug)
  head(example2$disease.drug)
}

\keyword{utilities}
\keyword{database}

