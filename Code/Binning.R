auto = read.csv("auto_score.csv")
heu = read.csv("heu_score.csv")


#####binning#####
#1025 bins, each with 1023 records#
auto$quantile_score_1025 = rep(0,dim(auto)[1])
auto = auto[order(auto$Euclidean.Score),]
for(i in 0:1024) { 
  a = i*1023+1
  b = (i+1)*1023
  auto[c(a:b),]$quantile_score_1025 = (i+1) }

heu$quantile_score_1025 = rep(0,dim(heu)[1])
heu = heu[order(heu$euclidean_score),]
for(i in 0:1024) { 
  a = i*1023+1
  b = (i+1)*1023
  heu[c(a:b),]$quantile_score_1025 = (i+1) }

#3075 bins, each with 341 records#
auto$quantile_score_3075 = rep(0,dim(auto)[1])
auto = auto[order(auto$Euclidean.Score),]
for(i in 0:3074) { 
  a = i*341+1
  b = (i+1)*341
  auto[c(a:b),]$quantile_score_3075 = (i+1) }

heu$quantile_score_3075 = rep(0,dim(heu)[1])
heu = heu[order(heu$euclidean_score),]
for(i in 0:3074) { 
  a = i*341+1
  b = (i+1)*341
  heu[c(a:b),]$quantile_score_3075 = (i+1) }

#465 bins, each with 2255 records#
auto$quantile_score_465 = rep(0,dim(auto)[1])
auto = auto[order(auto$Euclidean.Score),]
for(i in 0:464) { 
  a = i*2255+1
  b = (i+1)*2255
  auto[c(a:b),]$quantile_score_465 = (i+1) }

heu$quantile_score_465 = rep(0,dim(heu)[1])
heu = heu[order(heu$euclidean_score),]
for(i in 0:464) { 
  a = i*2255+1
  b = (i+1)*2255
  heu[c(a:b),]$quantile_score_465 = (i+1) }


#merge two datasets#
combined = merge(auto, heu, by.x = "Record", by.y = "RECORD")
combined = combined[, -c(7:17)]


#####calculate combined scores#####
#mean of the two scores#
combined$mean_1025 = (combined$quantile_score_1025.x + combined$quantile_score_1025.y)/2
combined$mean_3075 = (combined$quantile_score_3075.x + combined$quantile_score_3075.y)/2
combined$mean_465 = (combined$quantile_score_465.x + combined$quantile_score_465.y)/2

#max of the two scores#
combined$max_1025 = rep(0,dim(heu)[1])
combined[combined$quantile_score_1025.x<combined$quantile_score_1025.y,]$max_1025 = combined[combined$quantile_score_1025.x<combined$quantile_score_1025.y,]$quantile_score_1025.y
combined[combined$quantile_score_1025.x>=combined$quantile_score_1025.y,]$max_1025 = combined[combined$quantile_score_1025.x>=combined$quantile_score_1025.y,]$quantile_score_1025.x

combined$max_3075 = rep(0,dim(heu)[1])
combined[combined$quantile_score_3075.x<combined$quantile_score_3075.y,]$max_3075 = combined[combined$quantile_score_3075.x<combined$quantile_score_3075.y,]$quantile_score_3075.y
combined[combined$quantile_score_3075.x>=combined$quantile_score_3075.y,]$max_3075 = combined[combined$quantile_score_3075.x>=combined$quantile_score_3075.y,]$quantile_score_3075.x

combined$max_465 = rep(0,dim(heu)[1])
combined[combined$quantile_score_465.x<combined$quantile_score_465.y,]$max_465 = combined[combined$quantile_score_465.x<combined$quantile_score_465.y,]$quantile_score_465.y
combined[combined$quantile_score_465.x>=combined$quantile_score_465.y,]$max_465 = combined[combined$quantile_score_465.x>=combined$quantile_score_465.y,]$quantile_score_465.x

#0.5*mean of the two scores + 0.5*max of the two scores#
combined$mean_max_1025 = (combined$mean_1025 + combined$max_1025) / 2
combined$mean_max_3075 = (combined$mean_3075 + combined$max_3075) / 2
combined$mean_max_465 = (combined$mean_465 + combined$max_465) / 2

#distribution#
ggplot(combined, aes(Euclidean.Score)) + geom_histogram() + scale_y_log10()
ggplot(combined, aes(euclidean_score)) + geom_histogram() + scale_y_log10()

ggplot(combined,aes(mean_1025)) + geom_histogram(bins = 1000) 
ggplot(combined,aes(max_1025)) + geom_histogram(bins = 1000)
ggplot(combined,aes(mean_max_1025)) + geom_histogram(bins = 1000)

ggplot(combined,aes(mean_3075)) + geom_histogram(bins = 1000) 
ggplot(combined,aes(max_3075)) + geom_histogram(bins = 1000)
ggplot(combined,aes(mean_max_3075)) + geom_histogram(bins = 1000)

ggplot(combined,aes(mean_465)) + geom_histogram(bins = 1000) 
ggplot(combined,aes(max_465)) + geom_histogram(bins = 1000)
ggplot(combined,aes(mean_max_465)) + geom_histogram(bins = 1000)



write.csv(combined, "binning_score.csv")
