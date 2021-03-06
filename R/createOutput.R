createOutput <- function(data, output)
{
    outputSpecified <- is.null(output) || !is.na(output)
    if(outputSpecified)
    {
        if(is.null(output))  # data frame
            out <- NULL
        else if(is.character(output))  # raw xdf
            out <- RxXdfData(output, fileSystem=rxGetFileSystem(data))
        else stop("unknown output format", call.=FALSE)
    }
    else out <- tbl(newTbl(data), hasTblFile=TRUE)  # tbl_xdf
    out
}


createSplitOutput <- function(datalst, output, tblDir=tempdir())
{
    n <- length(datalst)
    if(is.null(output))  # data frame
        out <- vector("list", n)  # n NULLs
    else out <- lapply(datalst, function(data)  # tbl_xdf
        tbl(newTbl(data, tblDir=tblDir), hasTblFile=TRUE))
    out
}
