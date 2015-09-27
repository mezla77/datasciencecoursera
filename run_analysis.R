features <- read.table("./features.txt", header=FALSE)

'  Get indices of means & standard deviation columns  '
meanstdIndexes <- sort(c(grep("mean()", features$V2, fixed=TRUE, ignore.case = FALSE), grep("std()", features$V2, fixed=TRUE, ignore.case = FALSE)))

'  Read then combine mean & standard deviation columns of X data  '
testX <- read.table("./test/X_test.txt", header=FALSE)
trainX <- read.table("./train/X_train.txt", header=FALSE)
fullX <- rbind(testX[,meanstdIndexes], trainX[,meanstdIndexes])
remove(testX); remove(trainX)

'  Read and combine Y data  '
testY <- read.table("./test/Y_test.txt", header=FALSE)
trainY <- read.table("./train/Y_train.txt", header=FALSE)
fullY <- rbind(testY, trainY)
remove(testY); remove(trainY)

'  Read and combine Subject data  '
testSubject <- read.table("./test/subject_test.txt", header=FALSE)
trainSubject <- read.table("./train/subject_train.txt", header=FALSE)
fullSubject <- rbind(testSubject, trainSubject)
remove(testSubject); remove(trainSubject)

activities <- read.table("./activity_labels.txt", header=FALSE)

'  Combine X, Y, Subject, and Activity Names  '
fullXYSubject <- cbind(fullSubject, merge(fullY, activities, "V1", sort=FALSE)[,2], fullX)
remove(fullSubject); remove(fullX); remove(activities); remove(fullY)

colnames(fullXYSubject) <- c("Subject", "Activity", as.vector(features$V2[meanstdIndexes]))
remove(features)

