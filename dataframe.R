filenames <- list.files(path = "./output", pattern = "*.csv", full.names = TRUE)

myfiles <- lapply(filenames, function(x) {
  ncol <- max(count.fields(filenames[1], sep = ","))
  myfiles <- read.csv(x, fill = TRUE, header = FALSE, 
                      col.names = paste0("V", seq_len(ncol)),
                      stringsAsFactors = FALSE)
  })

labels <- sapply(myfiles, function(x) paste(x[1,1], x[2,1], by = " "))

labs <- sub("\\,.*", "", labels, perl = TRUE)
labs <- sub("^[^_]*providing ", "", labs, perl = TRUE)
labs <- sub("^[^_]*in ", "", labs, perl = TRUE)
labs[38] <- "excluded"
labs[28:32] <- paste0("permanent ", labs[28:32])
labs[33:37] <- paste0("temporary ", labs[33:37])

myfiles <- lapply(myfiles, function(x) { df <- x[!x$V3 == "",] })

#df[df$V6 == "l", "V6"] <- df[df$V6 == "l", "V7"]
#df <- df[,-7]

myfiles<- lapply(myfiles, function(x) { 
  x[is.na(x)] <- ""
  x})

clip <- myfiles[1:14]
clabsi <- myfiles[15:37]
cliplabs <- labs[1:14]
clablabs <- labs[15:37]

clip <- lapply(clip, function(x) {
  x[x$V6 == "l", "V6"] <- x[x$V6 == "l", "V7"]
  x <- x[,-7]
  if(x[1, "V5"] == "") {
    x <- x[-(1:2),]}
  x <- unique(x[x$V2 != "Confidence" & x$V6 != "%^", ])
  x <- data.frame(sapply(x, gsub, pattern="-------",replacement=""))
  x <- x[x$V1 != "Reporting hospital*", ]
})

for(i in 1:length(clip)) {
  clip[[i]][,"type"] <- cliplabs[i] 
}
clip <- do.call(rbind, clip)
clip <- data.frame(apply(clip, 2, as.character), stringsAsFactors = F)
clip[clip$V1 == "STATE OF CALIFORNIA POOLED DATA", "V6"] <- clip[clip$V1 == "STATE OF CALIFORNIA POOLED DATA", "V5"]
clip[clip$V1 == "STATE OF CALIFORNIA POOLED DATA", "V5"] <- ""
clip$V5 <- gsub("[()]", "", clip$V5)
clip$lowCI <- sapply(clip$V5, function(x) strsplit(x, ",")[[1]][1])
clip$uppCI <- sapply(clip$V5, function(x) strsplit(x, ",")[[1]][2])
clip <- clip[,-5]
colnames(clip)[1:5] <- c("hosp", "cases", "linedays", "rate", "adherence")

clabsi <- myfiles[15:37]
clabsi <- lapply(clabsi, function(x) {
  x[x$V5 == "l", "V5"] <- x[x$V5 == "l", "V6"]
  x <- x[,-c(6:7)]
  if(x[1, "V4"] == "") {
    x <- x[-(1:2),]}
  x <- unique(x[x$V2 != "Confidence" & x$V5 != "%^", ])
  x <- data.frame(sapply(x, gsub, pattern="-------",replacement=""))
  x <- x[x$V1 != "Reporting hospital*", ]
})
})

for(i in 1:length(clabsi)) clabsi[[i]][,"type"] <- clablabs[i]
clabsi <- do.call(rbind, clabsi)
clabsi <- data.frame(apply(clabsi, 2, as.character), stringsAsFactors = F)
clabsi[clabsi$V1 == "STATE OF CALIFORNIA POOLED DATA", "V6"] <- clabsi[clabsi$V1 == "STATE OF CALIFORNIA POOLED DATA", "V5"]
clabsi[clabsi$V1 == "STATE OF CALIFORNIA POOLED DATA", "V5"] <- ""
clabsi[nchar(clabsi$V4) > 5, "V5"] <- sapply(clabsi[nchar(clabsi$V4) > 5, "V4"], function(x) strsplit(x, " ")[[1]][2])
clabsi[nchar(clabsi$V4) > 5, "V4"] <- sapply(clabsi[nchar(clabsi$V4) > 5, "V4"], function(x) strsplit(x, " ")[[1]][1])
clabsi$V5 <- gsub("[()]", "", clabsi$V5)
clabsi$lowCI <- sapply(clabsi$V5, function(x) strsplit(x, ",")[[1]][1])
clabsi$uppCI <- sapply(clabsi$V5, function(x) strsplit(x, ",")[[1]][2])
clabsi <- clabsi[,-7]
