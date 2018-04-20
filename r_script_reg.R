beh = read.table("~/Desktop/InternshipLeiden/250 Brains/Logfiles/Behavioral_results.txt", sep='', header=TRUE)

library("ggplot2", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")

ourlm = lm(StroopEffect ~ Wself*Wother, data=beh)
summary(ourlm)

ourlm = lm(CongruentvsIncongruentResponses ~ Wself*Wother, data=beh)
summary(ourlm)

thebox = boxplot(beh$CongruentvsIncongruentResponses, range = 2.2) # makes outliers that are 2.2 times the interquartile range
thebox$out

#takes out outliers
newbeh = beh[which (!beh$CongruentvsIncongruentResponses == 7 ),]
newbeh = newbeh[which (!newbeh$CongruentvsIncongruentResponses == 9),]
newbeh = newbeh[which (!newbeh$CongruentvsIncongruentResponses == -5),]
newbeh = newbeh[which (!newbeh$CongruentvsIncongruentResponses == 8),]



boxplot(newbeh$CongruentvsIncongruentResponses, range = 2.2)

t.test(newbeh$CorrectCongruentResponses, newbeh$CorrentIncongruentResponses, alternative = "greater", paired=TRUE)
barplot(c(mean(newbeh$CorrectCongruentResponses), mean(newbeh$CorrentIncongruentResponses)), ylim = c(43, 45))

newbeh$Wself <- as.numeric(scale(newbeh$Wself))
newbeh$Wother <- as.numeric(scale(newbeh$Wother))
hist(newbeh$CongruentvsIncongruentResponses)

ourlm = lm((CongruentvsIncongruentResponses) ~ Wself*Wother+MedianRT, data=newbeh)
summary(ourlm)
predict(ourlm, newbeh,interval="confidence")



ourlm = lm(abs(CongruentvsIncongruentResponses) ~ Wself*Wother+MedianRT, data=newbeh)
summary(ourlm)
predict(ourlm, newbeh,interval="confidence")

ggplot(newbeh, aes(x=Wother, y=CongruentvsIncongruentResponses)) + geom_point() + geom_smooth(method = lm)

#make scatterplots and make interaction lines (table) 

tclm <-  lm(CongruentvsIncongruentResponses ~ Wself*Wother+MedianRT+StroopEffect, data=newbeh)
summary(tclm)
tclm <-  lm(CongruentvsIncongruentResponses ~ Wself*Wother+MedianRT, data=newbeh)
summary(tclm)


tclm <-  lm(CongruentvsIncongruentResponses ~ MedianRT, data=newbeh)
summary(tclm)



#### for plotting only ######
mynewdf = data.frame(Wself = rep(NaN, 9), Wother = rep(NaN, 9))
Wself_array <- c(mean(newbeh$Wself) - sd(newbeh$Wself),mean(newbeh$Wself), mean(newbeh$Wself) + sd(newbeh$Wself))
Wother_array <- c(mean(newbeh$Wother) - sd(newbeh$Wother),mean(newbeh$Wother), mean(newbeh$Wother) + sd(newbeh$Wother))
mynewdf = expand.grid(Wself = Wself_array, Wother = Wother_array)

the_predict <- (predict(tclm, mynewdf, re.form=NA))
mydata <- transform(mynewdf, res = the_predict)
mydata$Wself <- round(mydata$Wself)
mydata$Wother <- round(mydata$Wother)
#575 X 520
p <- ggplot(data = mydata, aes(y = res, x = Wself,  color=(factor(Wother)))) + stat_smooth(method=lm)
p  <- p + scale_colour_discrete(name="Wother") + scale_x_continuous(breaks=mydata$Wother) + theme_bw()  + labs(title = "Wself vs Wother vs Stroop Effect", y = "stroop effect (higher = less cognitive control)")
#p  <- p + geom_point(data = newbeh, aes(y = scale(CongruentvsIncongruentResponses), x = scale(Wself))) + theme(legend.position = "none")
p
ph <- ggplot(newbeh, aes(x=Wself, y=scale(CongruentvsIncongruentResponses))) + geom_point() + geom_smooth(method = lm)

grid.arrange(p, ph, ncol=2)
# p + ggplot(data = newbeh, aes(y = CongruentvsIncongruentResponses, x = scale(Wself))) + geom_point()

hist(newbeh$Wother)
hist(newbeh$Wself)

rcorr(scale(newbeh$Wself), scale(newbeh$Wother))


#### getting dangerous with confidence ####
#### for plotting only ######

ourlm = lm(CongruentvsIncongruentResponses ~ Wself*Wother+MedianRT, data=newbeh)
summary(ourlm)
sim(ourlm)
simulated.coef <- sim(ourlm)
simulated.coef <- coef(simulated.coef)



# mynewdf = data.frame(Wself = rep(NaN, 9), Wother = rep(NaN, 9), MedianRT = rep(444, 9))
Wself_array <- c(mean(newbeh$Wself) - sd(newbeh$Wself),mean(newbeh$Wself), mean(newbeh$Wself) + sd(newbeh$Wself))
Wother_array <- c(mean(newbeh$Wother) - sd(newbeh$Wother),mean(newbeh$Wother), mean(newbeh$Wother) + sd(newbeh$Wother))
mynewdf = expand.grid(Wself = Wself_array, Wother = Wother_array)
mydata <- transform(mynewdf, MedianRT = rep(444,9))

the_predict_sim <- matrix(NaN, 100, length(coef(ourlm)))
for (i in 1:length(simulated.coef)) {
  the_predict <- (sim.mar1s(simulated.coef[i,], mynewdf, re.form=NA))
}
  

# the_predict <- (predict(ourlm, mynewdf, re.form=NA))
mydata <- transform(mynewdf, res = the_predict)
mydata$Wself <- round(mydata$Wself)
mydata$Wother <- round(mydata$Wother)
#575 X 520
p <- ggplot(data = mydata, aes(y = res, x = Wself,  color=(factor(Wother)))) + stat_smooth(method=lm)
p  <- p + scale_colour_discrete(name="Wother") + scale_x_continuous(breaks=mydata$Wother) + theme_bw()  + labs(title = "Wself vs Wother vs Stroop Effect", y = "stroop effect (higher = less cognitive control)")
#p  <- p + geom_point(data = newbeh, aes(y = scale(CongruentvsIncongruentResponses), x = scale(Wself))) + theme(legend.position = "none")
p


ourlm = lm(CongruentvsIncongruentResponses ~ Wself*Wother, data=newbeh)
summary(ourlm)

predict(ourlm, newbeh,interval="confidence")


newdata <- data.frame(Wother = -1, Wself = seq(-1,1,0.1))
ribbondata <- data.frame(predict(ourlm, newdata, se.fit=TRUE))

#newdata0 <- data.frame(Wother = 0, Wself = seq(-1,1,0.1))
#ribbondata0 <- data.frame(predict(ourlm,newdata0,se.fit = TRUE))

newdata1 <- data.frame(Wother = 1, Wself = seq(-1,1,0.1))
ribbondata1 <- data.frame(predict(ourlm,newdata0,se.fit = TRUE))
# ribbondata <- data.frame(predict(ourlm, newdata,interval="predict", level=.60))
# ribbondata <- data.frame(predict(ourlm, newdata,interval="confidence", level=.60))

newnewdata <- cbind(newdata, ribbondata)
#newnewdata0 <- cbind(newdata0, ribbondata0)
newnewdata1 <- cbind(newdata1, ribbondata1)


Wself_array <- c(mean(newbeh$Wself) - sd(newbeh$Wself),mean(newbeh$Wself), mean(newbeh$Wself) + sd(newbeh$Wself))
Wother_array <- c(mean(newbeh$Wother) - sd(newbeh$Wother),mean(newbeh$Wother), mean(newbeh$Wother) + sd(newbeh$Wother))
mynewdf = expand.grid(Wself = Wself_array, Wother = Wother_array)
mydata <- transform(mynewdf, MedianRT = rep(444,9))

the_predict <- (predict(ourlm, mynewdf, re.form=NA))
mydata <- transform(mynewdf, res = the_predict)
mydata$Wself <- round(mydata$Wself)
mydata$Wother <- round(mydata$Wother)
#575 X 520
p <- ggplot(data = mydata, aes(y = res, x = Wself,  color=(factor(Wother)))) + stat_smooth(method=lm)
p  <- p + scale_colour_discrete(name="Wother") + scale_x_continuous(breaks=mydata$Wother) + theme_bw()  + labs(title = "Wself vs Wother vs Stroop Effect", y = "stroop effect (higher = less cognitive control)")
#p  <- p + geom_point(data = newbeh, aes(y = scale(CongruentvsIncongruentResponses), x = scale(Wself))) + theme(legend.position = "none")
p
colnames(newnewdata)[3] <- "res"
#colnames(newnewdata0)[3] <- "res"
colnames(newnewdata1)[3] <- "res"

p <- p + geom_line(data=newnewdata)+geom_ribbon(data=newnewdata,aes(ymin=res-se.fit,ymax=res+se.fit),alpha=0.3)
p

#p <- p + geom_line(data=newnewdata0)+geom_ribbon(data=newnewdata0,aes(ymin=res-se.fit,ymax=res+se.fit),alpha=0.3)
#p
p <- p + geom_line(data=newnewdata1)+geom_ribbon(data=newnewdata1,aes(ymin=res-se.fit,ymax=res+se.fit),alpha=0.3)
p 
