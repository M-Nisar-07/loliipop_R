library(jsonlite)
library(aws.s3)
library(aws.ec2metadata)
library(trackViewer)


#* @serializer svg
#* @post /get_lollipop
#* @param range_
#* @param width_
#* @param height_
#* @param color_
#* @param object_id
#* @param seql
function(range_,width_,height_,color_,object_id,seql){

  range_ <- as.integer(range_)
  width_ <- as.integer(width_)
  height_ <- as.numeric(height_)
  seql <- as.integer(seql)

  print(height_)

features <- GRanges("chr1", IRanges(c(range_),
                                    width=c(width_),
              #names=c('','PBD','','Pkinase',''),
                                  ),
                    fill = c(color_),
                    height = c(height_))


  Sys.setenv(
    "AWS_ACCESS_KEY_ID" = "AKIA5PNVZPT5GW5LL3YX",
    "AWS_SECRET_ACCESS_KEY" = "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",
    "AWS_DEFAULT_REGION" = "us-west-1"
  )

dataa <- s3read_using(FUN = read.csv, object = object_id, bucket = "ciodss3bucketdev")

SNP <- c(dataa$site)
height <- c(dataa$total)

exp_condition.gr <- GRanges("chr1", IRanges(SNP, width=1, names= c(dataa$mapped_phosphosite )),
                     #color = sample.int(6, length(SNP), replace=TRUE),
                     color = c(dataa$color),
                     score = height)

studies <-   exp_condition.gr

xaxis <- append(range_, seql)

max_value <- max(dataa$total)

print(max_value)

yaxis <- get_li(max_value)
print(yaxis)

lolliplot(studies, features, xaxis = xaxis,  yaxis=yaxis , cex=.6 )
}
