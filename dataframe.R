filenames <- list.files(path = "./text", pattern = "*.csv", full.names = TRUE)
myfiles <- lapply(filenames, function(x) {
  ncol <- max(count.fields(filenames[1], sep = ","))
  myfiles <- read.csv(x, fill = TRUE, header = FALSE, col.names = paste0("V", seq_len(ncol)))
}
