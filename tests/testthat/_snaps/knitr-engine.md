# Snapshot test of knitr-engine file_name=r-style-opts.Rmd

    Code
      .knit_file(file_name)
    Output
      
      
      
      ```elm
      from mtcars
      filter cyl > 6
      select [mpg]
      take 3
      ```
      
      ```sql
      SELECT
        TOP (3) mpg
      FROM
        mtcars
      WHERE
        cyl > 6
      ```
      
      
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
      

# Snapshot test of knitr-engine file_name=yaml-style-opts.Rmd

    Code
      .knit_file(file_name)
    Output
      
      
      
      ```elm
      from mtcars
      filter cyl > 6
      select [mpg]
      take 3
      ```
      
      ```sql
      SELECT
        TOP (3) mpg
      FROM
        mtcars
      WHERE
        cyl > 6
      ```
      
      
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
      

