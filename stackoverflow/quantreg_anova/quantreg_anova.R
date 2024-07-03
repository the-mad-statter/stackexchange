library(quantreg)

set.seed(42)

data <- data.frame(
  y = c(sapply(c(0, 0.1, 0.2, 0.7), \(mean) rnorm(25, mean))),
  x = rep(letters[1:4], each = 25)
)

qr <- rq(y ~ x, 0.5, data)
summary(qr)

qr0 <- rq(y ~ 1, 0.5, data)
summary(qr0)

anova(qr, qr0)
