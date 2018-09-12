#' Create link repo on Github
#'
#' Creates a Github repository with a README full of links
#'
#' @param urls Vector of URLS
#' @param repo Name of GH repo.
#' @export
linkrepo <- function(urls, repo) UseMethod("linkrepo")

#' @export
linkrepo.default <- function(urls, repo) {
	if (missing(repo)) {
		stop("Must supply repo name")
	}
	stopifnot(is.character(repo), is.character(urls), length(repo) == 1)
	short <- sub("^https?://", "", sub("\\?.*|\\#.*", "", urls))
	full <- urls
	items <- paste(paste0("+ [", short, "](", full, ")"), collapse = "\n")
	if (dir.exists(repo) && length(list.files(repo, all.files = TRUE)) > 0) {
		stop(paste0(repo, " already exists!"), call. = FALSE)
	}
	if (dir.exists(repo)) {
		if (identical(getwd(), normalizePath(repo, mustWork = FALSE))) {
			setwd("..")
		}
		unlink(repo, recursive = TRUE)
	}
	od <- getwd()
	on.exit(setwd(od), add = TRUE)
	setwd(dirname(normalizePath(repo, mustWork = FALSE)))
	repo <- basename(repo)
	usethis::create_project(repo, rstudio = TRUE, open = FALSE)
	if (!identical(basename(getwd()), repo)) {
		setwd(repo)
	}
	title <- paste0(
		" 🔗🔗 A curated collection of links about ", repo)
	fields <- list(Project = repo, project = repo,
		title = title, Title = title, Description = title,
		description = title)

	txt <- paste0(readme_head(repo, title), items)

	writeLines(txt, "README.Rmd")


	usethis::use_description(fields)

	rmarkdown::render("README.Rmd")
	if (file.exists("README.html")) unlink("README.html")

	writeLines(c(paste0(repo, ".Rproj"), "README.Rmd"), ".gitignore")

	usethis::use_git()

	usethis::use_github()
}

readme_head <- function(repo, desc) {
	paste0('---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->

# ', repo, "  \n  \n> ", desc, "  \n  \n")
}
