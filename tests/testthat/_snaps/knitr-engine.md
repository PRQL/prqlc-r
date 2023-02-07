# Snapshot test of knitr-engine

    Code
      .knit_file("r-style-opts.Rmd")
    Output
      
      
      
      ```elm
      from mtcars
      filter cyl > 6
      select [cyl, mpg]
      derive [mpg_int = round 0 mpg]
      take 3
      ```
      
      ```sql
      SELECT
        TOP (3) cyl,
        mpg,
        ROUND(mpg, 0) AS mpg_int
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
      

---

    Code
      .knit_file("yaml-style-opts.Rmd")
    Output
      
      
      
      ```elm
      from mtcars
      filter cyl > 6
      select [cyl, mpg]
      derive [mpg_int = round 0 mpg]
      take 3
      ```
      
      ```sql
      SELECT
        TOP (3) cyl,
        mpg,
        ROUND(mpg, 0) AS mpg_int
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
      

---

    Code
      withr::with_options(list(prqlr.target = "sql.mssql", prqlr.format = FALSE,
        prqlr.signature_comment = FALSE), .knit_file("minimal.Rmd"))
    Output
      
      ```elm
      from mtcars
      filter cyl > 6
      select [cyl, mpg]
      derive [mpg_int = round 0 mpg]
      take 3
      ```
      
      ```sql
      SELECT
        TOP (3) cyl,
        mpg,
        ROUND(mpg, 0) AS mpg_int
      FROM
        mtcars
      WHERE
        cyl > 6
      ```

