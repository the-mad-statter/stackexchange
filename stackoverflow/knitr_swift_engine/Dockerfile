FROM rocker/verse

FROM swift:latest
COPY --from=0 / /

COPY index.Rmd /home/rstudio/index.Rmd

EXPOSE 8787
CMD ["/init"]
