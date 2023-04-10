require(base)
require(utils)
require(yaml)

# install and import rstan
if(!require(rstan)){
  install.packages("rstan", repos = "https://cloud.r-project.org/", dependencies = TRUE)
}
require(rstan)

# import libraries
config <- read_yaml("config.yaml")
pkgs <- config$packages
for(pkg in pkgs){
  if(!require(pkg, character.only=T)){
    install.packages(pkg, repos="https://cran.ism.ac.jp/")
  }
  require(pkg, character.only=T)
}

# create book directory
if(! "./book" %in% list.dirs()){
  dir.create("book")
}else{
  message("book dir already exists.")
}

if(! "./docs" %in% list.dirs()){
  dir.create("docs")
}else{
  message("docs dir already exists.")
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

# def render function
quick_render <- function(){
  bookdown::render_book("book", output_dir="../docs")
  if(!file.exists("docs/.nojekyll")){
    file.create("docs/.nojekyll")
  }
}

message("- You can [quick_render()] function when working dir is root. ")
