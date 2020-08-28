tabella = read.csv("tabella.csv",header=F)
tabella.ts = ts(tabella,start=c(1985,10),end=c(2019,11),frequency=12)
ts.plot(tabella.ts)
#andamento dei vari anni
matrixElect = matrix(window(tabella.ts,start=c(1986,1),end=c(2018,12)), 12, 33)
par(bg = "black")
ts.plot(matrixElect, col = heat.colors(33))
ts.plot(scale(matrixElect, scale = F), col = heat.colors(33))
lines(rowMeans(scale(matrixElect, scale = F)), lwd = 6, col = "white")
par(bg = "white")
#acf
layout(1:3)
acf(tabella.ts)
acf(tabella.ts,60)
acf(diff(tabella.ts))
layout(1)
#DECOMPOSIZIONE 
tabella.ts.da = decompose(tabella.ts)
plot(tabella.ts.da)
#residui del modello addittivo
tabella.ts.dar=as.vector(window(tabella.ts.da$random,c(1986,4),c(2019,5)))
plot(tabella.ts.dar,pch=20)
#varianza spiegata
1-var(tabella.ts.dar)/var(window(tabella.ts,c(1986,4),c(2019,5)))
#istogramma
hist(tabella.ts.dar,20,freq=F,main="Istogramma dei residui additivi")
lines(density(tabella.ts.dar),col="blue") 
legend("topleft", legend=c("Densità teorica", "Densità empirica"),col=c("red", "blue"), lty=1:1, cex=1)
lines(sort(tabella.ts.dar),dnorm(sort(tabella.ts.dar),mean(tabella.ts.dar),sd(tabella.ts.dar)),col="red") 
#quantili
qqnorm(tabella.ts.dar,main="Q-Q Plot dei residui additivi")
qqline(tabella.ts.dar)
#acf sui residui
acf(tabella.ts.dar,main="acf residui additivi")
#test di shapiro
shapiro.test(tabella.ts.dar)

#ANALISI

tabella = read.csv("tabella.csv",header=FALSE)
tabella.ts = ts(tabella,start=c(1985,10),end=c(2019,11),frequency=12)
#SE
tabella.se=HoltWinters(tabella.ts,beta=F,gamma=F)
summary(tabella.se)
tabella.se$alpha
plot(tabella.se)
legend("topleft", legend=c("Serie originaria", "Serie delle previsioni con SE"),col=c("black", "red"), lty=1:1, cex=1)
#cambio alpha "a mano"
plot(tabella.se);
points(HoltWinters(tabella.ts,alpha=0.2,beta=F,gamma=F)$fitted, col="blue",type="l")
plot(tabella.se);
points(HoltWinters(tabella.ts,alpha=0.3,beta=F,gamma=F)$fitted, col="blue",type="l")
plot(tabella.se);
points(HoltWinters(tabella.ts,alpha=0.4,beta=F,gamma=F)$fitted, col="blue",type="l")
plot(tabella.se);
points(HoltWinters(tabella.ts,alpha=0.5,beta=F,gamma=F)$fitted, col="blue",type="l")
plot(tabella.se);
points(HoltWinters(tabella.ts,alpha=0.6,beta=F,gamma=F)$fitted, col="blue",type="l")
tabella.se=HoltWinters(tabella.ts,alpha=0.6,beta=F,gamma=F)#0.6 sembra il valore migliore
#previsione SE e bande di confidenza
predict(tabella.se,1)
tabella.se.r = residuals(tabella.se)
plot(tabella.se,predict(tabella.se,1)) 
lines(predict(tabella.se,12)+quantile(tabella.se.r,0.05),col="green3") 
lines(predict(tabella.se,12)+quantile(tabella.se.r,0.95),col="green3")
#SET
tabella.set = HoltWinters(tabella.ts,gamma=F)
plot(tabella.set)
tabella.set$alpha
tabella.set$beta

#HOLT WINTERS
tabella.hw =HoltWinters(tabella.ts)
plot(tabella.hw)
legend("topleft", legend=c("Serie originaria", "Serie delle previsioni con HW"),col=c("black", "red"), lty=1:1, cex=1)

#confronto tra trend di stl e di hw
tabella.stl=stl(tabella.ts[,1],"periodic")
legend("topleft", legend=c("Trend decomposizione", "Trend Holt-Winters"),col=c("black", "red"), lty=1:1, cex=1)
ts.plot(tabella.stl$time.series[,2],tabella.hw$fitted[,2],col=c("black","red"))
#confronto con stagionalita
legend("topleft", legend=c("Stagionalità decomposizione", "Stagionalità Holt-Winters"),col=c("black", "red"), lty=1:1, cex=0.6)
ts.plot(tabella.stl$time.series[,1],tabella.hw$fitted[,4],col=c("black","red"))
#PREVISIONE HW
tabella.hw.r = residuals(tabella.hw)
plot(tabella.hw,predict(tabella.hw,12)) 
lines(predict(tabella.hw,12)+quantile(tabella.hw.r,0.05),col="green3") 
lines(predict(tabella.hw,12)+quantile(tabella.hw.r,0.95),col="green3")
legend("topleft", legend=c("Serie originale", "Serie Holt-Winter","Intervalli di incertezza"),col=c("black", "red","green"), lty=1:1, cex=1)
#RESIDUI HW
plot(tabella.hw.r,type="p",pch=20)
plot(tabella.hw$fitted[,1],tabella.hw.r,pch=20)
start(tabella.ts)
end(tabella.ts)
start(tabella.hw.r)
end(tabella.hw.r)
1-var(tabella.hw.r)/var(window(tabella.ts,c(1986,10)))
acf(tabella.hw.r)
hist(tabella.hw.r,20,freq=F)
lines(density(tabella.hw.r))
lines(sort(tabella.hw.r),dnorm(sort(tabella.hw.r),mean(tabella.hw.r),sd(tabella.hw.r)),col="red") 
qqnorm(tabella.hw.r)
qqline(tabella.hw.r)
shapiro.test(tabella.hw.r)

#CONFRONTO CON METODI AUTOREGRESSIVI
tabella = read.csv("tabella.csv",header=FALSE)
tabella.ts = ts(tabella,start=c(1985,10),end=c(2019,11),frequency=12)
pacf(tabella.ts)
pacf(tabella.ts,60)#25
#YULE-WALKER
tabella.ar = ar(tabella.ts)
tabella.ar#infatti viene una dipendenza di ordine 25
ts.plot(tabella.ts, tabella.ts - tabella.ar$resid, col = c("black", "red"))

#previsione modello
tabella.ar.pt = predict(tabella.ar, n.ahead = 12, se.fit = FALSE) 
plot(tabella.ar.pt)

#incertezza non parametrica
tabella.ar.r = tabella.ar$resid[26:410]
y.max = max(tabella.ar.pt + quantile(tabella.ar.r, 0.975))
y.min = min(tabella.ar.pt + quantile(tabella.ar.r, 0.025)) 
ts.plot(tabella.ar.pt, ylim = c(y.min, y.max)) 
lines(tabella.ar.pt + quantile(tabella.ar.r, 0.975), col = "red") 
lines(tabella.ar.pt + quantile(tabella.ar.r, 0.025), col = "red")

#residui modello
acf(tabella.ar.r)
pacf(tabella.ar.r)
l=length(tabella.ts)
v = var(tabella.ts[26:l]) 
1-var(na.omit(tabella.ar$resid))/v 
hist(tabella.ar.r, 20, freq = F)
lines(density(tabella.ar.r), col = "red")
lines(sort(tabella.ar.r), dnorm(sort(tabella.ar.r), mean(tabella.ar.r), sd(tabella.ar.r)),col = "blue") 
qqnorm(tabella.ar.r) 
qqline(tabella.ar.r)
shapiro.test(tabella.ar.r)#non sono normali

#confronto con hw per previsioni
tabella.hw = HoltWinters(tabella.ts)
tabella.ar.pt = predict(tabella.ar, n.ahead = 11)
ts.plot(tabella.ts, tabella.ar.pt$pred, predict(tabella.hw, 12), col = c("black", "red", "green3"))
legend("topleft", legend=c("serie originale", "previsione metodo Yule-Walker","previsione metodo Holt-Winters"),col=c("black", "red","green3"), lty=1:1, cex=1)

#confronto tramite autovalidazione!
train = window(tabella.ts, start=c(1985,10),end=c(2017,12))
test = window(tabella.ts,start=c(2018,1),end=c(2019,11))
tabella.hw.p = predict(HoltWinters(train), 23)
tabella.ar.p = predict(ar(train), n.ahead = 23, se.fit = FALSE) 
ts.plot(test, tabella.hw.p, tabella.ar.p, col = c("black", "red", "blue")) 
legend("bottomleft", legend=c("serie originale", "previsione metodo Yule-Walker","previsione metodo Holt-Winters"),col=c("black", "blue","red"), lty=1:1, cex=0.8)


#MINIMI QUADRATI
tabella.ls = ar(tabella.ts,method="ols")
tabella.ls$order

#valori stimati del modello
ts.plot(tabella.ts, tabella.ts - tabella.ls$resid, col = c("black", "red"))
legend("topleft", legend=c("serie originale", "valori stimati dal modello dei minimi quadrati"),col=c("black", "red"), lty=1:1, cex=1)

#residui
tabella.ls.r = as.double(na.omit(tabella.ls$resid))
acf(tabella.ls.r)
pacf(tabella.ls.r)
tabella.ls.r = as.double(na.omit(tabella.ls$resid))
tabella.ls.fitted = as.double(na.omit(tabella.ts - tabella.ls$resid))
plot(tabella.ls.fitted, tabella.ls.r, pch = 20)
1-var(tabella.ls.r)/var(tabella.ls.r + tabella.ls.fitted)
hist(tabella.ls.r, 20, freq = F)
lines(density(tabella.ls.r), col = "red")
lines(sort(tabella.ls.r), dnorm(sort(tabella.ls.r), mean(tabella.ls.r), sd(tabella.ls.r)),col = "blue") 
qqnorm(tabella.ls.r) 
qqline(tabella.ls.r)
shapiro.test(tabella.ls.r)#non sono normali

#previsione modello
tabella.ls.pt = predict(tabella.ls, n.ahead = 12, se.fit = FALSE) 
ts.plot(tabella.ts, tabella.ts - tabella.ls$resid, tabella.ls.pt, col = c("black", "blue","red"), lwd = c(1, 1, 1))

# confronto con hw per previsione
tabella.hw = HoltWinters(tabella.ts)
tabella.hw.pt = predict(tabella.hw, 12)
ts.plot(tabella.ts,tabella.ls.pt, tabella.hw.pt, col = c("black","red", "blue")) 
legend("topleft", legend=c("serie originale", "previsione metodo minimi quadrati","previsione metodo Holt-Winters"),col=c("black", "red","blue"), lty=1:1, cex=0.7)

#confronto tramite autovalidazione
train = window(tabella.ts, start=c(1985,10),end=c(2018,12))
test = window(tabella.ts,start=c(2019,1),end=c(2019,11))
tabella.hw.p = predict(HoltWinters(train), 11)
tabella.ls.p = predict(ar(train, method = "ols"), n.ahead = 11, se.fit = FALSE) 
ts.plot(test, tabella.hw.p, tabella.ls.p, col = c("black", "red", "blue")) 
legend("topleft", legend=c("serie originale", "previsione metodo minimi quadrati","previsione metodo Holt-Winters"),col=c("black", "blue","red"), lty=1:1, cex=0.7)


