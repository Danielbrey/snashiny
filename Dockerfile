FROM rocker/shiny-verse:latest
# System libraries of general use (This was produced automatically for me)
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev
# Install R packages required
RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('shinydashboard', repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('andrewsali/shinycssloaders')"
RUN R -e "install.packages('lubridate', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('magrittr', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('glue', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('DT', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('plotly', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('igraph', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('networkD3', repos='http://cran.rstudio.com/')"
# Copy the app to the image
COPY SNABasicsShiny.Rproj /srv/shiny-server/
COPY app.R /srv/shiny-server/

# select port
EXPOSE 3838
# allow permission
RUN sudo chown -R shiny:shiny /srv/shiny-server
# run app
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server//app.R', host = '0.0.0.0', port = 3838)"]
