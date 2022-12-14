require(tidyverse)
require(bookdown)

# create book directory
if(! "book" %in% list.dirs()){
  dir.create("book")
}

if(! "docs" %in% list.dirs()){
  dir.create("docs")
}

# create gitbook 
if(! "index.Rmd" %in% list.files("book")){
  bookdown::create_gitbook("book")
  file.remove(c("book/book.Rproj", 
                "book/README.md", 
                "book/02-cross-refs.Rmd",
                "book/03-parts.Rmd",
                "book/04-citations",
                "book/05-blocks.Rmd",
                "book/06-share.Rmd",
                "book/07-references.Rmd"))
}
