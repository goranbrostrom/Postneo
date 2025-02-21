socfig <- function(coeff, ran = c(-25, 5), main = "1935-1950", pval = 0.03, ymax = NULL){
    ## coeff is output from tpchreg(oe(event, exposure) ~ socst + socst:emeantemp 
    ## controls+)
    
    ny <- coeff[substr(names(coeff), 1, 5) == "socst"]
    n <- (length(ny) + 1) / 2
    a <- c(0, ny[1:n])
    b <- ny[n:(2 * n - 1)]
    x <- seq(ran[1], ran[2], length = 100)
    y <- matrix(nrow = n, ncol = length(x))
    for (j in 1:n){
        y[j, ] <- exp(a[j] + b[j] * x)
        ##y[j, ] <- exp(b[j] * x)
    }
    if (is.null(ymax)){
        ymax <- max(y)
    }
    plot(x, y[1, ], type = "l", ylim = c(0, ymax), xlab = "Temperature", 
         ylab = "Rel. hazards", lwd = 2, main = main)
    ##for (i in 2:6){
    for (i in 1:n){                                          ### !! NOTE !!
        lines(x, y[i, ], col = i, lty = i, lwd = 2)
    }
    ##
    ##nam <- c("WhiteCollar", "Farmer",  "lowWhiteC", "qualWorker", "Worker", "None")
    ##legend("topright", legend = nam, col = 1:6, lty = 1:6, cex = 0.7)
    nam <- c("WhiteCollar", "Other")
    legend("topright", legend = nam, col = 1:2, lty = 1:2, cex = 0.8)
    points(0, 1, cex = 2)
    abline(h = 1, v = 0, lty = 3)
    text(mean(ran), ymax - 1, paste("H: Equal slopes, p = ", round(pval, 3)), col = ifelse(pval < 0.05, "red", "black"))
}