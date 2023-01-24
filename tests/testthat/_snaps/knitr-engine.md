# Snapshot test of knitr-engine

    Code
      cat(paste0(readLines(output), collapse = "\n"))
    Output
      ---
      output: github_document
      ---
      
      
      
      
      ```elm
      from mtcars | filter cyl > 6 | select [mpg] | take 3
      ```
      
      
      
      
      Table: 3 records
      
      |  mpg|
      |----:|
      | 18.7|
      | 14.3|
      | 16.4|
      
      
      ```elm
      from mtcars
      filter cyl > 6
      select [cyl, mpg]
      derive [mpg_int = round 0 mpg]
      take 3
      ```
      
      
      
      
      Table: 3 records
      
      | cyl|  mpg| mpg_int|
      |---:|----:|-------:|
      |   8| 18.7|      19|
      |   8| 14.3|      14|
      |   8| 16.4|      16|
      

