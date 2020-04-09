FROM rocker/shiny:latest

# docker build -t shiny-flexdashboard:latest .

MAINTAINER Dadin jaenudin "jaenudin@gmail.com"

RUN mkdir /srv/shiny-server/app/ && \
    chown -R shiny:shiny /srv/shiny-server/

RUN touch /home/shiny/.Renviron
RUN chown shiny.shiny /home/shiny/.Renviron

#install ssl
RUN sudo apt-get update; exit 0
RUN sudo apt-get install -y libssl-dev libxml2-dev

RUN R -e "install.packages(c('leaflet','shiny', 'flexdashboard', 'dplyr','lubridate','highcharter','plotly','dygraphs','xts','DT','echarts4r','shinyWidgets','shinydashboard','data.table','tidyverse','scales','tidyr'))"

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf
 
RUN chmod a+x /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]

