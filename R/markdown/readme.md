Notes for authors
After knitting the document - we will successfully generate R Markdown document (Rmd). But this Rmd file cannot be used in github.

So we convert Rmd to md by

    ---
    title: "my project title"
    author: "Rama"
    date: "`r format(Sys.Date())`"
    output:
      html_document:
        keep_md: true
    ---

Then we upload this md document along with the files generated in the folder. Here in this case, for example, I simply dragged and dropped into the browser 1) markdown document 2) bbstats_files folder.

Without the bbstats_files folder we cannot view images since images are stored in that folder.
